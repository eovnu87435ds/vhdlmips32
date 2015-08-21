library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
	port(address:in std_logic_vector(31 down to 0);	-- Will receive a program count.
		progCount:out std_logic_vector(31 down to 0));	-- Program count that will be returned.
end PC;

architecture behavioral of PC is
begin
	process()
	begin
		-- Increment the program count. Has to be 4 byte aligned due to the 32-bit architecture.
		progCount<=address+4;
	end process;
end behavioral;