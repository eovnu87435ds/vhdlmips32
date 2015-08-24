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
entity RegMemory is
	port (
		WriteData, read_instruction: in STD_LOGIC_VECTOR(31 downto 0); --Data written back into registers and instruction taken from instruction memory
		RegWrite, RegDst, ck: in STD_LOGIC; --RegWrite and RegDst control signals
		ReadData1, ReadData2: out STD_LOGIC_VECTOR (31 downto 0) --Data from registers going to ALU
	);
end RegMemory;


architecture behavioral of RegMemory is	  

type reg_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);

--Registers taken from instruction code
signal ReadReg1, ReadReg2, WriteReg: STD_LOGIC_VECTOR(4 downto 0);

ReadReg1<=read_instruction(25 downto 21);
ReadReg2<=read_instruction(20 downto 16);
WriteReg<=read_instruction(15 downto 11);

signal reg_values: reg_array := (
    X"00000000", -- initialize data memory
    X"00000000", -- mem 1
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
    X"00000000",
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

--Read the values from the registers ReadReg1 and ReadReg2 into the output signals ReadData1 and ReadData2, and also set the wb_reg to the register indicated by WriteReg
set_read_data: process(ReadReg1, ReadReg2, WriteReg, ck)
begin
	ReadData1<=reg_values(conv_integer(ReadReg1));
	ReadData2<=reg_values(conv_integer(ReadReg2));
end process set_read_data;

--Write WriteData to the WriteReg only if RegWrite is high
write_reg_data: process(WriteData, ck)
begin
	if (RegWrite='1') then
		reg_values(conv_integer(WriteReg))<=WriteData;
	end if;
end process write_reg_data;

end behavioral;