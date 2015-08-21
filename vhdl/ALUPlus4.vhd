------------------------------------------------------
-- ECEC 355 Computer Architecture
-- MIPS Single Cycle Datapath
-- Cem Sahin - 08/04/2009
-- modified 07/21/2015
------------------------------------------------------

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

add_four: process(clk)
	PCPlus4<=PCOut+4
end process add_four;

end behavioral;