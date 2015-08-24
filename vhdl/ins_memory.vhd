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
entity ins_memory is
	port (
		address: in STD_LOGIC_VECTOR (31 downto 0);
		read_instruction: out STD_LOGIC_VECTOR (31 downto 0)
	);
end ins_memory;


architecture behavioral of ins_memory is	  

type instruction_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);

signal data_mem: instruction_array := (
    X"8D100000", --         lw $s0, 0($t0)
    X"8D110004", --         lw $s1, 4($t0)
    X"12110002", --         beq $s0, $s1, L
    X"02959820", --         add $s3, $s4, $s5
    X"08000006", --         j EXIT
    X"02959822", -- L:      sub $s3, $s4, $s5
    X"AD130008", -- EXIT:   sw $s3, 8($t0)
    X"00000000",
    X"00000000",
    X"00000000", 
    X"00000000", -- mem 10 
    X"00000000", 
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",  
    X"00000000", -- mem 20
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000", 
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000", 
    X"00000000", -- mem 30
    X"00000000");

begin
	process(address)	-- Only execute on a change in address.
	begin
		read_instruction <= data_mem(conv_integer(address(6 downto 2))); -- I think this is all that's needed -Mike
	end process;
end behavioral;