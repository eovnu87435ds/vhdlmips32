library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity ALU is
	port (
		ReadData1, ReadData2: in STD_LOGIC_VECTOR(31 downto 0); --Input values to operate on
		ALUCont: in STD_LOGIC_VECTOR(3 downto 0); --4 bit control signal to ALU
		ALUResult: out STD_LOGIC_VECTOR (31 downto 0); --ALU output value
		Zero: out STD_LOGIC --Bit to set if branch is to be taken
	);
end ALU;


architecture behavioral of ALU is

begin  

ALU_Op: process(ReadData1, ReadData2, ALUCont)
	begin
	case ALUCont is
		when "0010"=> --add
			ALUResult<=ReadData1+ReadData2;
			Zero<='0';
			
		when "0110"=> --sub
			ALUResult<=ReadData1-ReadData2;
			if ReadData1=ReadData2 then
				Zero<='1';
			else
				Zero<='0';
			end if;
			
		when "0000"=> --and
			ALUResult<=ReadData1 AND ReadData2;
			Zero<='0';
			
		when "0001"=> --or	
			ALUResult<=ReadData1 OR ReadData2;
			Zero<='0';
			
		when "0111"=> --slt
			if ReadData1<ReadData2 then
				ALUResult(0)<='1';
			else
				ALUResult(0)<='0';
			end if;
			Zero<='0';

		when others=>null;
	end case;
end process ALU_Op;

end behavioral;