library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity ALUPlus4 is
	port (
		PCOut: in STD_LOGIC_VECTOR(31 downto 0); --PC of current clock cycle
		PCPlus4: out STD_LOGIC_VECTOR (31 downto 0) --PC of current clock cycle plus 4
	);
end ALUPlus4;


architecture behavioral of ALUPlus4 is

signal one: std_logic_vector(31 downto 0);

begin

one<=(others=>'0');
one(0)<='1';

add_four: process(PCOut)
	begin
	PCPlus4<=std_logic_vector(unsigned(PCOut)+unsigned(one));
end process add_four;

end behavioral;