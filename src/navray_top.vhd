-- Top-level wrapper
-- by Wallace Everest
-- 23-NOV-2022
-- https://github.com/navray/tt02-square-root.git

-- FUNCTIONAL MODEL -------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

library work;
  use work.sqrt_pkg.all;

entity navray_top is
  port (
    io_in  : in std_logic_vector(7 downto 0);
    io_out : out std_logic_vector(7 downto 0)
  );
end entity;

architecture rtl of navray_top is 
  constant K_WIDTH : natural := 7;
  signal data_out : unsigned(3 downto 0);
  
begin
  SQRT_MAP : block
  begin
    io_out(3 downto 0) <= std_logic_vector(data_out);
    io_out(7 downto 4) <= (others => '0');
  end;
  
  SQRT_INST : sqrt
  generic map ( G_WIDTH => K_WIDTH )
  port map (
    clk      => io_in(7),
    data_in  => unsigned(io_in(6 downto 0)),
    data_out => data_out
  );

end architecture;
-- end of file
