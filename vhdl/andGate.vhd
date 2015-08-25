library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity andGate is
	port(Branch, Zero:in std_logic;
		andVal:out std_logic);
end andGate;

architecture behavioral of andGate is
begin
	process(Branch, Zero)
		if Branch AND Zero then
			andVal<=1;
		else
			andVal<=0;
		end if;
	end process;
end behavioral;