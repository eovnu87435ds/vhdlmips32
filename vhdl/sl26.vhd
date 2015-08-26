library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sl26 is
	port(read_instruction:in std_logic_vector(25 down to 0);	-- Will receive a 25-bit value from instruction memory
		pcPlus4:in std_logic_vector(31 down to 28;)	-- From the pc+4 ALU.
		jmpAddr:out std_logic_vector(31 down to 0));	-- Jump address if needed.
end sl26;

architecture behavioral of sl26 is

signal temp: std_logic_vector(27 downto 0);

begin
	process(read_instruction, pcPlus4)
	begin
		temp<=read_instruction & "00";
		jmpAddr(27 downto 0)<=temp; -- needs to be a 28 bit number.
		jmpAddr(31 downto 28)<=pcPlus4;	-- Take care of the four bits from the pc + 4.
	end process;
end behavioral;