library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sl32 is
-- VARIABLE NAME NEEDS TO BE CHANGED FROM OUTPUT
	port(signOut:in std_logic_vector(31 down to 0);	-- will receive instruction[15:0] padded with 16 0's
		output:out std_logic_vector(31 down to 0));	-- Output of the shift left twice.
end sl32;

architecture behavioral of sl32 is
begin
	process()
	begin
		signOut sll 2;
		output<=signOut;
	end process;
end behavioral;