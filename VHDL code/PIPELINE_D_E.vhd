
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY D_E IS
PORT(	CLK, RST: IN STD_LOGIC;
MemToReg,RegWrite,MemWrite,Branch_Sig,Branch_Z_Sig,PUSH,POP,In_SIG,Protect,Free,ALU_SRC: IN STD_LOGIC;
PC,READ_DATA1,READ_DATA2,IMM_VALUE: IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
IN_PORT_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);  
WRITE_ADDRESS:IN STD_LOGIC_VECTOR(2 DOWNTO 0);
OP_CODE: IN STD_LOGIC_VECTOR(4 DOWNTO 0); 
callSig: IN STD_LOGIC;
RET_SIG: IN STD_LOGIC;
RTI_SIG: IN STD_LOGIC;
INTERRUPT_SIG: IN STD_LOGIC;
SWAPPING_SIG: IN STD_LOGIC;


MemToReg_OUT,RegWrite_OUT,MemWrite_OUT,Branch_Sig_OUT,Branch_Z_Sig_OUT,PUSH_OUT,POP_OUT,In_SIG_OUT,Protect_OUT,Free_OUT,ALU_SRC_OUT: OUT STD_LOGIC;
PC_OUT,READ_DATA1_OUT,READ_DATA2_OUT,IMM_VALUE_OUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0); 
IN_PORT_OUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);  
WRITE_ADDRESS_OUT:OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
OP_CODE_D_E: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
callSig_out: OUT STD_LOGIC;
RET_SIG_OUT: OUT STD_LOGIC;
RTI_SIG_OUT: OUT STD_LOGIC;
INTERRUPT_SIG_OUT: OUT STD_LOGIC;
ReadReg1in,ReadReg2in:IN std_logic_vector(2 downto 0);
ReadReg1out,ReadReg2out:OUT std_logic_vector(2 downto 0);
lastpredin:in STD_LOGIC;
lastpredout:out STD_LOGIC;
SWAPPING_SIG_OUT: OUT STD_LOGIC;
OUT_SIG: IN STD_LOGIC;
OUT_PORT: OUT STD_LOGIC_VECTOR (31 downto 0)


);
		
END ENTITY;

ARCHITECTURE FDREGARCH OF D_E IS
BEGIN

	PROCESS(CLK) IS
	BEGIN
		
		IF RISING_EDGE(CLK) THEN

			IF RST = '1' THEN

			MemToReg_OUT <= '0';
			RegWrite_OUT<= '0';
			MemWrite_OUT<= '0';
			Branch_Sig_OUT<= '0';
			Branch_Z_Sig_OUT<= '0';
			PUSH_OUT<= '0';
			POP_OUT <= '0';
			In_SIG_OUT<= '0';
			Protect_OUT<= '0';
			Free_OUT<= '0';
			ALU_SRC_OUT<= '0';
			callSig_out<= '0';
			RET_SIG_OUT<= '0';
			INTERRUPT_SIG_OUT<= '0';
			RTI_SIG_OUT<= '0';
			
			SWAPPING_SIG_OUT<= '0';
			PC_OUT <=(OTHERS => '0');
			READ_DATA1_OUT <=(OTHERS => '0');
			READ_DATA2_OUT <=(OTHERS => '0');
			IMM_VALUE_OUT <=(OTHERS => '0');
			IN_PORT_OUT <=(OTHERS => '0');
			WRITE_ADDRESS_OUT <=(OTHERS => '0');
			OP_CODE_D_E <=(OTHERS => '0');
			lastpredout<='0';
			OUT_PORT<=(OTHERS=>'0');

			ELSE
			
			MemToReg_OUT <= MemToReg ;
			RegWrite_OUT <= RegWrite;
			MemWrite_OUT <= MemWrite;
			Branch_Sig_OUT <= Branch_Sig;
			Branch_Z_Sig_OUT <= Branch_Z_Sig;
			PUSH_OUT <= PUSH;
			POP_OUT <= POP;
			In_SIG_OUT  <= In_SIG;
			Protect_OUT <= Protect;
			Free_OUT <= Free;
			ALU_SRC_OUT <= ALU_SRC;
			RET_SIG_OUT <= RET_SIG;
			RTI_SIG_OUT <= RTI_SIG;
			PC_OUT <=PC;
			READ_DATA1_OUT <=READ_DATA1;
			READ_DATA2_OUT <=READ_DATA2;
			IMM_VALUE_OUT <=IMM_VALUE;
			IN_PORT_OUT <=IN_PORT_IN;
			WRITE_ADDRESS_OUT <= WRITE_ADDRESS;
			OP_CODE_D_E <=OP_CODE;
			callSig_out <= callSig;
			INTERRUPT_SIG_OUT <= INTERRUPT_SIG;
			ReadReg1out<=ReadReg1in;
			ReadReg2out<=ReadReg2in;
			lastpredout<=lastpredin;
			SWAPPING_SIG_OUT<=SWAPPING_SIG;
			IF OUT_SIG='1' THEN
				OUT_PORT<=READ_DATA1;
			ELSE
				OUT_PORT<=(OTHERS=>'X');
			END IF; 

		END IF;
	END IF;
	END PROCESS;

END ARCHITECTURE;



