-- Square root testbench
-- by Wallace Everest
-- 23-NOV-2022
-- https://github.com/navray/tt02-square-root

-- BUS FUNCTIONAL MODEL -------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity tb_sqrt_testbench is
end entity;

architecture behavioral of tb_sqrt_testbench is
  component navray_top is
  port (
    io_in  : in std_logic_vector(7 downto 0);
    io_out : out std_logic_vector(7 downto 0)
  );
  end component;
  
  signal io_in  : std_logic_vector(7 downto 0) := (others => '0');
  signal io_out : std_logic_vector(7 downto 0);
  
begin
  TB_SQRT_TESTBENCH_DUT : navray_top
  port map (
    io_in  => io_in,
    io_out => io_out
  );
  
  TB_SQRT_TESTBENCH_CLK : process
  begin
    io_in(0) <= '0', '1' after 500 us;
    wait for 1000 us;
  end process;
  
  TB_SQRT_TESTBENCH_STP : process
  begin
    io_in(7 downto 1) <= std_logic_vector(to_unsigned(32, 7));
    for i in 1 to 4 loop
      wait until rising_edge(io_in(0));
    end loop;
    io_in(7 downto 1) <= std_logic_vector(to_unsigned(127, 7));
    wait;
  end process;
  
end architecture;
-- end of file
