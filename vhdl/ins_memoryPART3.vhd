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
    X"00008020", 
    X"20110030", 
    X"2012000a", 
    X"20130014", 
    X"00004020", 
    X"0253582a", 
    X"11600009", 
    X"02534820",
    X"00105080",
    X"8e0c0000", 
    X"022c6820", -- mem 10 
    X"ae2d0000", 
    X"2252ffff",
    X"2273fffd",
    X"21080001",
    X"08000005",
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