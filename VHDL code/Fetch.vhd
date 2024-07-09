LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY Fetch IS

PORT (
CLK,RST,INTERRUPT_SIG,RESET_SIG,CALL_SIG,RET_SIG,RTI_SIG:IN std_logic;
Branch0: IN std_logic := '0';
BranchU: IN std_logic := '0';
Stall: IN std_logic;
CALL_INSTRUCTION: IN std_logic_vector(31 DOWNTO 0);
RET_INSTRUCTION: IN std_logic_vector(31 DOWNTO 0);
BranchAddress:IN std_logic_vector(31 DOWNTO 0);
PC_SAVED: OUT std_logic_vector(31 DOWNTO 0);
FetchedInstruction : OUT std_logic_vector(15 DOWNTO 0);
Swap_INST : IN std_logic_vector(15 DOWNTO 0);
EXTENDED_IMM: OUT std_logic_vector(31 DOWNTO 0);
EXCEPTION_O : OUT STD_LOGIC;
PcBeforepred:in std_logic_vector(31 DOWNTO 0);
LastPred,wrongprediction:in std_logic;

LastPredout:out std_logic


);

END ENTITY;

Architecture FetchUnit of Fetch IS

Component PC IS
PORT(	CLK, RST, STALL, INTERRUPT_SIG : IN STD_LOGIC;
DATA_IN: IN STD_LOGIC_VECTOR(31 downto 0);
RESET_VALUE, INT_VALUE: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
DATAOUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END Component;

Component INSTRUCTION_CACHE IS

PORT (
CLK, RST: IN std_logic;
PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
DATAOUT : OUT std_logic_vector(15 DOWNTO 0);
RESET_VALUE,INT_VALUE: OUT std_logic_vector(31 DOWNTO 0);
EXCEPTION_OUT : OUT STD_LOGIC
);

END Component;

component Mux2x1 IS
generic(N : INTEGER );
PORT(
I0,I1: IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
S : IN STD_LOGIC;
O : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0 ));

END component;
component Mux4x1 IS
    generic(N : INTEGER );
    PORT(
        I0, I1, I2, I3 : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        O : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0)
    );
END component;

SIGNAL MUXOUT : STD_LOGIC_VECTOR(31 downto 0) :=(OTHERS => '0');
SIGNAL MUXOUT1 : STD_LOGIC_VECTOR(31 downto 0) :=(OTHERS => '0');
SIGNAL MUXOUT2 : STD_LOGIC_VECTOR(31 downto 0) :=(OTHERS => '0');
SIGNAL MUXOUT3 : STD_LOGIC_VECTOR(31 downto 0) :=(OTHERS => '0');
SIGNAL PC_OUT : STD_LOGIC_VECTOR(31 downto 0) := (OTHERS => '0');
SIGNAL A : STD_LOGIC := '0';
SIGNAL B : STD_LOGIC := '0';
SIGNAL AddOutput:  std_logic_vector(31 DOWNTO 0);
SIGNAL INST : std_logic_vector(15 DOWNTO 0):= (others => '0');
SIGNAL RESET_VAL,INT_VAL: std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
signal mux1selector: std_logic_vector(1 downto 0);
BEGIN	
				
AddOutput <= STD_LOGIC_VECTOR(UNSIGNED(PC_OUT) + 1);	
				
		
	
	

PC_SAVED <= AddOutput;
A <= RTI_SIG OR RET_SIG;

B <= Branch0 OR BranchU  ;
mux1selector<=LastPred&wrongprediction;
EXTENDED_IMM <= INST(15) &INST(15) &INST(15) &INST(15) &INST(15) &INST(15) &INST(15) &INST(15) &INST(15) &INST(15) &INST(15) &INST(15) &INST(15) &INST(15) &INST(15) &INST(15) & INST;
U0: PC PORT MAP(CLK,RESET_SIG,STALL,INTERRUPT_SIG,MUXOUT3,RESET_VAL,INT_VAL,PC_OUT);
U1:Mux4x1 GENERIC MAP (32) PORT MAP(AddOutput,BranchAddress,AddOutput,PcBeforepred,mux1selector,MUXOUT1);
U2:INSTRUCTION_CACHE PORT MAP(CLK,RST,PC_OUT,INST,RESET_VAL,INT_VAL,EXCEPTION_O);

U3:Mux2x1 GENERIC MAP (16) PORT MAP(INST,Swap_INST,STALL,FetchedInstruction);

U4:Mux2x1 GENERIC MAP (32) PORT MAP(MUXOUT1,CALL_INSTRUCTION,CALL_SIG,MUXOUT2);
U5:Mux2x1 GENERIC MAP (32) PORT MAP(MUXOUT2,RET_INSTRUCTION,RET_SIG ,MUXOUT3);
Lastpredout<=Lastpred;

END ARCHITECTURE;
