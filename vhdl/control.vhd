library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity control is
	port(opcode:in std_logic_vector(5 downto 0);	-- Will receive an input, opcode, from the instruction.
		-- Outputs the following control signals, they are all true or false except ALUOp.
		RegDST, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite:out std_logic;
		ALUOp:out std_logic_vector(1 downto 0));	-- Tells the ALU Control what to do.
end control;

architecture behavioral of control is
begin
	process(opcode)
	begin
		-- Depending on the opcode, set the control signals accordingly.
		if opcode="000000" then	-- R type instruction (add, and, jr, nor, or, slt, sll, srl, sub)
			RegDST<='1';
			Jump<='0';
			Branch<='0';
			MemRead<='0';
			MemtoReg<='0';
			MemWrite<='0';
			ALUSrc<='0';
			RegWrite<='1';
			ALUOp<="10";	-- two bits
		
		elsif opcode="001000" then	-- addi 8hex
			RegDST<='0';
			Jump<='0';
			Branch<='0';
			MemRead<='0';
			MemtoReg<='0';
			MemWrite<='0';
			ALUSrc<='1';
			RegWrite<='1';
			ALUOp<="00";
			
		-- elsif opcode="001100" then	-- andi chex
			-- RegDST<='';
			-- Jump<='';
			-- Branch<='';
			-- MemRead<='';
			-- MemtoReg<='';
			-- MemWrite<='';
			-- ALUSrc<='';
			-- RegWrite<='';
			-- ALUOp<="";
			
		elsif opcode="001101" then	-- ori dhex
			RegDST<='0';
			Jump<='0';
			Branch<='0';
			MemRead<='0';
			MemtoReg<='0';
			MemWrite<='0';
			ALUSrc<='1';
			RegWrite<='1';
			ALUOp<="11";

		elsif opcode<="000100" then	-- beq
			RegDST<='0';
			Jump<='0';
			Branch<='1';
			MemRead<='0';
			MemtoReg<='0';
			MemWrite<='0';
			ALUSrc<='0';
			RegWrite<='0';
			ALUOp<="01";

		-- elsif opcode<="000101" then	-- bne This is EXTRA CREDIT
			-- RegDST<='';
			-- Jump<='0';
			-- Branch<='1';
			-- MemRead<='';
			-- MemtoReg<='';
			-- MemWrite<='';
			-- ALUSrc<='';
			-- RegWrite<='';
			-- ALUOp<="01";
		
		elsif opcode<="000010" then	-- j
			RegDST<='0';
			Jump<='1';
			Branch<='0';
			MemRead<='0';
			MemtoReg<='0';
			MemWrite<='0';
			ALUSrc<='0';
			RegWrite<='0';
			ALUOp<="00";

		elsif opcode<="100011" then	-- lw
			RegDST<='0';
			Jump<='0';
			Branch<='0';
			MemRead<='1';
			MemtoReg<='1';
			MemWrite<='0';
			ALUSrc<='1';
			RegWrite<='1';
			ALUOp<="00";

		elsif opcode<="101011" then	-- sw
			RegDST<='0';
			Jump<='0';
			Branch<='0';
			MemRead<='0';
			MemtoReg<='0';
			MemWrite<='1';
			ALUSrc<='1';
			RegWrite<='0';
			ALUOp<="00";
		else
			-- No recognizable opcode!
		end if;
	end process;
end behavioral;