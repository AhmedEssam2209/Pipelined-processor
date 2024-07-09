
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY E_M IS
	PORT(	CLK, RST: IN STD_LOGIC;
		Alu_output: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		PC: IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
		Flags: IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
		WriteAddress :IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
		inport :IN std_logic_vector(31 DOWNTO 0);
		MemToReg :IN std_logic;
		RegWrite : IN std_logic;
		MemWrite : IN std_logic;
		Branch_Sig  :IN std_logic;
		Branch_Z_Sig  :IN std_logic;
		PUSH  :IN std_logic;
		POP  :IN std_logic;
		In_SIG  :IN std_logic;
		Protect  :IN std_logic;
		Free  :IN std_logic;
		Write_data:IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
		callSig: IN STD_LOGIC;
		RET_SIG: IN STD_LOGIC;
		RTI_SIG: IN STD_LOGIC;
		INTERRUPT_SIG: IN STD_LOGIC;
		PREV_FLAGS: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		SWAPPING: IN STD_LOGIC;
		
		
		Alu_outputOut: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		PCOut: OUT STD_LOGIC_VECTOR(31 DOWNTO 0); 
		FLAGS_Out: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		CCR_FlagsOut: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); 
		WriteAddressOut  :OUT STD_LOGIC_VECTOR(2 DOWNTO 0); 
		inportOut  :OUT std_logic_vector(31 DOWNTO 0);
		MemToRegOut  :OUT std_logic;
		RegWriteOut  :OUT std_logic;
		MemWriteOut  :OUT std_logic;
		Branch_SigOut :OUT std_logic;
		Branch_Z_SigOut  :OUT std_logic;
		PUSHOut  :OUT std_logic;
		POPOut  : OUT std_logic;
		In_SIGOut: OUT std_logic;
		ProtectOut : OUT std_logic;
		FreeOut :OUT std_logic;
		Write_data_out:out STD_LOGIC_VECTOR(31 DOWNTO 0);
		callSig_out: OUT STD_LOGIC;
		RET_SIG_out: OUT STD_LOGIC;
		RTI_SIG_out: OUT STD_LOGIC;
		INTERRUPT_SIG_out: OUT STD_LOGIC;
		SWAPPING_OUT: OUT STD_LOGIC;
		OUT_PORT_IN: IN STD_LOGIC_VECTOR (31 downto 0);
		OUT_PORT: OUT STD_LOGIC_VECTOR (31 downto 0)




);
		
END ENTITY;

ARCHITECTURE FDREGARCH OF E_M IS
BEGIN

	PROCESS(CLK) IS
	BEGIN
		
		IF RISING_EDGE(CLK) THEN

			IF RST = '1' THEN
			
			Alu_outputOut<= (others =>'0');
			PCOut<= (others =>'0');
			CCR_FlagsOut<= (others =>'0');
			WriteAddressOut  <= (others =>'0');
			Write_DATA_Out  <= (others =>'0');
			inportOut  <= (others =>'0');
			MemToRegOut   <= '0';
			RegWriteOut   <= '0';
			MemWriteOut   <= '0';
			Branch_SigOut  <= '0';
			Branch_Z_SigOut   <= '0';
			PUSHOut   <= '0';
			POPOut   <= '0';
			In_SIGOut <= '0';
			ProtectOut  <= '0';
			FreeOut  <= '0';
			callSig_out <= '0';
			RET_SIG_out <= '0';
			INTERRUPT_SIG_out <= '0';
			RTI_SIG_out <= '0';
			FLAGS_Out<= (others =>'0');
			SWAPPING_OUT <= '0';

			ELSE
			Write_DATA_Out  <= Write_DATA;
			
			Alu_outputOut<= Alu_output;
			PCOut<= PC;
			CCR_FlagsOut<= PREV_Flags;
			WriteAddressOut  <=WriteAddress;
			inportOut  <= inport;
			MemToRegOut   <= MemToReg;
			RegWriteOut   <= RegWrite;
			MemWriteOut   <= MemWrite;
			Branch_SigOut  <=Branch_Sig;
			Branch_Z_SigOut   <= Branch_Z_Sig;
			PUSHOut   <= PUSH;
			POPOut   <= POP;
			In_SIGOut <= In_SIG;
			ProtectOut  <= Protect;
			FreeOut  <= Free;
			callSig_out <= callSig;
			RET_SIG_out <= RET_SIG;
			INTERRUPT_SIG_out <= INTERRUPT_SIG;
			RTI_SIG_out <= RTI_SIG;
			FLAGS_Out<= Flags;
			SWAPPING_OUT <= SWAPPING;
			OUT_PORT <= OUT_PORT_IN;
			
			END IF; 

		END IF;
	END PROCESS;

END ARCHITECTURE;




