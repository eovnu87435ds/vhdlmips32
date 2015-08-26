library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity ALUPlus4 is
	port (
		PCOut: in STD_LOGIC_VECTOR(31 downto 0); --PC of current clock cycle
		PCPlus4: out STD_LOGIC_VECTOR (31 downto 0) --PC of current clock cycle plus 4
	);
end ALUPlus4;


architecture behavioral of ALUPlus4 is

signal one: std_logic_vector(31 downto 0);

begin

add_four: process(PCOut)
	begin
	PCPlus4<=PCOut+1;
end process add_four;

end behavioral;