library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity signExtend is
	port(read_instruction:in std_logic_vector(15 down to 0);	-- Will receive instruction[15:0]
		signOut:out std_logic_vector(31 down to 0));	-- 32-bit extended number.
end signExtend;

architecture behavioral of signExtend is
begin
	process(read_instruction)	-- Depends on the change in read_instruction.
	begin
		-- Extend the 16-bit number to a 32-bit number by resizing the instruction
		-- to the length of the logic vector signOut.
		signOut<=std_logic_vector(resize(read_instruction), signOut'length);
	end process;
end behavioral;