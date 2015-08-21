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
entity ALUAdd is
	port (
		PCPlus4: in STD_LOGIC_VECTOR(31 downto 0); --PC of current clock cycle plus 4
		PCBranch: out STD_LOGIC_VECTOR (31 downto 0) --PC if branch is taken
	);
end ALUAdd;


architecture behavioral of ALUAdd is

signal BranchAddress: STD_LOGIC_VECTOR(31 downto 0);  

add_branch: process(PCPlus4, BranchAddress)
	PCBranch<=PCPlus4+BranchAddress
end process add_four;

end behavioral;