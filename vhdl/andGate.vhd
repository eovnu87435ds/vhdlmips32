library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity andGate is
	port(Branch, Zero:in std_logic;
		andVal:out std_logic);
end andGate;

architecture behavioral of andGate is
begin
	process(Branch, Zero)
	begin
		andVal<=Branch AND Zero;
	end process;
end behavioral;