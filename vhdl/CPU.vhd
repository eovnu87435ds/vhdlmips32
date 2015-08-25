library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU is
	port(ck:in std_logic);
end CPU;

architecture behavioral of CPU is

component ALU is
	port (
		ReadData1, ReadData2: in STD_LOGIC_VECTOR(31 downto 0); --Input values to operate on
		ALUCont: in STD_LOGIC_VECTOR(3 downto 0); --4 bit control signal to ALU
		ALUResult: out STD_LOGIC_VECTOR (31 downto 0) --ALU output value
		Zero: out STD_LOGIC; --Bit to set if branch is to be taken
	);
end component;

component ALUAdd is
	port (
		PCPlus4, BranchAddress: in STD_LOGIC_VECTOR(31 downto 0); --PC of current clock cycle plus 4
		PCBranch: out STD_LOGIC_VECTOR (31 downto 0) --PC if branch is taken
end component;

component ALUControl is
	port (
		Funct: in STD_LOGIC_VECTOR(5 downto 0); --6 bit function code taken from instruction memory
		ALUOp: in STD_LOGIC_VECTOR(1 downto 0); --2 bit ALUOp control signal
		ALUCont: out STD_LOGIC_VECTOR (3 downto 0) --4 bit output to ALU
	);
end component;

component ALUPlus4 is
	port (
		PCOut: in STD_LOGIC_VECTOR(31 downto 0); --PC of current clock cycle
		PCPlus4: out STD_LOGIC_VECTOR (31 downto 0) --PC of current clock cycle plus 4
		);
end component;

component control is
	port(opcode:in std_logic_vector(5 down to 0);	-- Will receive an input, opcode, from the instruction.
		-- Outputs the following control signals, they are all true or false except ALUOp.
		RegDST, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite:out std_logic;
		ALUOp:out std_logic_vector(1 down to 0));	-- Tells the ALU Control what to do.
end component;

component ins_memory is
	port (
		address: in STD_LOGIC_VECTOR (31 downto 0);
		read_instruction: out STD_LOGIC_VECTOR (31 downto 0)
	);
end component;

component memory is
	port (
		address, write_data: in STD_LOGIC_VECTOR (31 downto 0);
		MemWrite, MemRead, ck: in STD_LOGIC;
		read_data: out STD_LOGIC_VECTOR (31 downto 0)
	);
end component;

component Mux32 is
	port (
		zero,one : in STD_LOGIC_VECTOR(31 downto 0);
		sel : in STD_LOGIC;
		ck : in STD_LOGIC;
		muxout : STD_LOGIC_VECTOR(31 downto 0));
end component;

component Mux5 is
	port (
		zero5,one5 : in STD_LOGIC_VECTOR(31 downto 28);
		sel5 : in STD_LOGIC;
		ck : in STD_LOGIC;
		muxout5 : STD_LOGIC_VECTOR(31 downto 28));
end component;

component PC is	-- added ck
	port(ck:in std_logic;
		address:in std_logic_vector(31 down to 0);	-- Will receive a program count.
		progCount:out std_logic_vector(31 down to 0));	-- Program count that will be returned.
end component;

component RegMemory is
	port (
		WriteData, read_instruction: in STD_LOGIC_VECTOR(31 downto 0); --Data written back into registers and instruction taken from instruction memory
		RegWrite, RegDst, ck: in STD_LOGIC; --RegWrite and RegDst control signals
		ReadData1, ReadData2: out STD_LOGIC_VECTOR (31 downto 0) --Data from registers going to ALU
	);
end component;

component signExtend is
	port(read_instruction:in std_logic_vector(15 down to 0);	-- Will receive instruction[15:0]
		signOut:out std_logic_vector(31 down to 0));	-- 32-bit extended number.
end component;

component sl26 is
	port(read_instruction:in std_logic_vector(25 down to 0);	-- Will receive a 25-bit value from instruction memory
		pcPlus4:in std_logic_vector(31 down to 28;)	-- From the pc+4 ALU.
		jmpAddr:out std_logic_vector(31 down to 0));	-- Jump address if needed.
end component;

component sl32 is
	port(signOut:in std_logic_vector(31 down to 0);	-- will receive instruction[15:0] padded with 16 0's
		BranchAddress:out std_logic_vector(31 down to 0));	-- Output of the shift left twice.
end component;

-- Declaration of all the signals!
signal instruction:std_logic_vector(31 downto 0);	-- 32-bit MIPS instruction.
signal ReadData1, ReadData2, ALUResult,	PCPlus4, BranchAddress, PCBranch, PCOut, read_data, progCount, signOut, jmpAddr:std_logic_vector(31 downto 0);
		opcode:std_logic_vector(5 downto 0);
		branchMuxout, jumpMuxout, aluMuxout, memMuxout:std_logic_vector(4 downto 0);
		ALUCont:std_logic_vector(3 downto 0);
		ALUOp:std_logic_vector(1 downto 0);
		Zero, Branch, RegDST, Jump, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, andVal, ck:std_logic;
begin
	ALU port map(ReadData1, aluMuxout, ALUCont, 	ALUResult, Zero);	-- Good to go
	ALUAdd port map(PCPlus4, BranchAddress, 	PCBranch);	-- Good to go
	ALUControl port map(instruction(5 downto 0), ALUOp, 	ALUCont);	-- Good to go
	ALUPlus4 port map(PCOut, 	PCPlus4);	-- Good to go
	andGate port map(Branch, Zero,		andVal);	-- Good to go
	control port map(opcode,	RegDST, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp);	-- Good to go
	ins_memory port map(PCOut,		instruction);	-- Good to go
	memory port map(ALUResult, ReadData2, MemWrite, MemRead, ck,	read_data);	-- Good to go
	Mux5 port map(instruction(20 downto 16), instruction(15 downto 11), RegDST,		muxout5);	-- Good to go
	jumpMux:Mux32 port map(branchMuxout, jmpAddr, Jump,		jumpMuxout);	-- Good to go
	branchMux:Mux32 port map(PCPlus4, PCBranch, andVal,		branchMuxout);	-- Good to go
	ALUMux:Mux32 port map(ReadData2, signOut, ALUSrc, 	aluMuxout);	-- Good to go
	memMux:Mux32 port map(ALUResult, read_data, MemtoReg, 	memMuxout);
	PC port map(ck, jumpMuxout, 	PCOut);	-- Good to go
	RegMemory port map(read_data, instruction, RegWrite, ck,	ReadData1, ReadData2);	-- NEED TO EDIT INPUTS
	signExtend port map(instruction(15 downto 0),	signOut);	-- Good to go
	sl26 port map(instruction(25 downto 0), pcPlus4(31 downto 28),		jmpAddr);	-- Good to go
	sl32 port map(signOut, 		BranchAddress);
end behavioral;
