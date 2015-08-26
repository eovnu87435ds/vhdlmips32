library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity CPU_testbench is
end CPU_testbench;

architecture behavioral of CPU_testbench is
component CPU
	port(ck: in    std_logic);
end component;

signal ck:std_logic:='0';
  
begin
dut : CPU port map(ck);
ck <= not ck after 100 ns;

end behavioral;
