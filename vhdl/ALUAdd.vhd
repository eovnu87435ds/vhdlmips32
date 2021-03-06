library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity ALUAdd is
	port (
		PCPlus4, BranchAddress: in STD_LOGIC_VECTOR(31 downto 0); --PC of current clock cycle plus 4
		PCBranch: out STD_LOGIC_VECTOR (31 downto 0) --PC if branch is taken
	);
end ALUAdd;


architecture behavioral of ALUAdd is

begin

add_branch: process(PCPlus4, BranchAddress)
	begin
	PCBranch<=PCPlus4+BranchAddress;
end process add_branch;

end behavioral;