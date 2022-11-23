-- Square root testbench
-- by Wallace Everest
-- 23-NOV-2022
-- https://github.com/navray/tt02-square-root.git

-- BUS FUNCTIONAL MODEL -------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity tb_sqrt_testbench is
end entity;

architecture behavioral of tb_sqrt_testbench is
  component navray_top is
  port (
    clk    : in std_logic;
    io_in  : in std_logic_vector(7 downto 0);
    io_out : out std_logic_vector(7 downto 0)
  );
  
  signal clk    : std_logic := '0';
  signal io_in  : std_logic_vector(7 downto 0) := (others => '0');
  signal io_out : std_logic_vector(7 downto 0);
  
begin
  TB_SQRT_TESTBENCH_DUT : navray_top
  port map (
    clk    => clk,
    io_in  => io_in,
    io_out => io_out
  );
  
  TB_SQRT_TESTBENCH_CLK : process
  begin
    clk <= '0', '1' after 500 us;
    wait for 1000 us;
  end process;
  
  TB_SQRT_TESTBENCH_STP : process
  begin
    io_in <= std_logic_vector(to_unsigned(32, 8));
    for i in 1 to K_WIDTH/2 loop
      wait until rising_edge(clk);
    end loop;
    io_in <= std_logic_vector(to_unsigned(127, 8));
    wait;
  end process;
  
end architecture;
-- end of file
