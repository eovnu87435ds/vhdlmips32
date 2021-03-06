library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity ALUControl is
	port (
		Funct: in STD_LOGIC_VECTOR(5 downto 0); --6 bit function code taken from instruction memory
		ALUOp: in STD_LOGIC_VECTOR(1 downto 0); --2 bit ALUOp control signal
		ALUCont: out STD_LOGIC_VECTOR (3 downto 0) --4 bit output to ALU
	);
end ALUControl;


architecture behavioral of ALUControl is

begin  

update_ALU: process(Funct, ALUOp)
	begin
	if ALUOp="00" then
		ALUCont<="0010"; --add for lw/sw, or andi
	elsif ALUOp="01" then
		ALUCont<="0110"; --sub for beq
	elsif ALUOp="10" then
		case Funct is
			when "100000"=> ALUCont<="0010"; --add
			when "100010"=> ALUCont<="0110"; --sub
			when "100100"=> ALUCont<="0000"; --and
			when "100101"=> ALUCont<="0001"; --or
			when "101010"=> ALUCont<="0111"; --slt
			when others=>null;
		end case;
	elsif ALUOp="11" then
		ALUCont<="0001"; --ori
	end if;
end process update_ALU;

end behavioral;