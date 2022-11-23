-- Square root algorithm
-- by Wallace Everest
-- 23-NOV-2022
-- https://github.com/navray/tt02-square-root.git
--
-- Based on work from Yamin Li and Wanming Chu
-- "A New Non-Restoring Square Root Algorithm"
-- International Conference on Computer Design, 1996

-- PACKAGE WRAPPER ------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

package sqrt_pkg is
  component sqrt is
  generic (G_WIDTH : natural);
  port (
    clk      : in std_logic;
    data_in  : in unsigned(G_WIDTH-1 downto 0);
    data_out : out unsigned(G_WIDTH/2-1 downto 0)
  );
  end component;
end package;

-- FUNCTIONAL MODEL -------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity sqrt is
  generic (G_WIDTH : natural := 8);
  port (
    clk      : in std_logic;
    data_in  : in unsigned(G_WIDTH-1 downto 0);
    data_out : out unsigned(G_WIDTH/2-1 downto 0)
  );
end entity;

architecture rtl of sqrt is
  type TYPE_D is array (0 to G_WIDTH/2) of std_logic_vector(data_in'range);
  type TYPE_Q is array (0 to G_WIDTH/2) of std_logic_vector(data_out'range);
  type TYPE_R is array (0 to G_WIDTH/2) of std_logic_vector(data_out'left+2 downto 0);
  signal d : TYPE_D := (others => (others => '0'));
  signal q : TYPE_Q := (others => (others => '0'));
  signal r : TYPE_R := (others => (others => '0'));

begin
  SQRT_MAP : block
  begin
    d(0) <= std_logic_vector(data_in);
    q(0) <= (others => '0');
    r(0) <= (others => '0');
    data_out <= unsigned(q(q'high));
  end block;

  SQRT_GEN : for i in 0 to G_WIDTH/2-1 generate
    SQRT_REG : process(clk)
      variable sign : std_logic;
      variable x    : std_logic_vector(data_out'left+2 downto 0);
      variable y    : std_logic_vector(data_out'left+2 downto 0);
      variable alu  : signed(data_out'left+2 downto 0);
    begin
      if rising_edge(clk) then
        sign := r(i)(r(i)'left);  -- sign of R is operand
        x    := r(i)(data_out'range) & d(i)(data_in'left downto data_in'left-1);
        y    := q(i) & sign & '1';
        if ( sign = '0' ) then
          alu := signed(x) - signed(y);
        else
          alu := signed(x) + signed(y);
        end if;
        d(i+1) <= d(i)(data_in'left-2 downto 0) & b"00";                -- shift left 2-bits
        q(i+1) <= q(i)(data_out'left-1 downto 0) & not(alu(alu'left));  -- shift left 1 bit
        r(i+1) <= std_logic_vector(alu);
      end if;
    end process;    
  end generate;
  
end architecture;
-- end of file
