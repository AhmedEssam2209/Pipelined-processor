LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY EXECUTE IS

PORT (
CLK,RST:IN std_logic;
ALU_SRC: IN std_logic;
OP_CODE:IN std_logic_vector(4 DOWNTO 0);
Read_Data1: IN std_logic_vector(31 DOWNTO 0);
Read_Data2: IN std_logic_vector(31 DOWNTO 0);
IMM_VALUE: IN std_logic_vector(31 DOWNTO 0);
RTI_SIG: IN std_logic;
RTI_FLAGS: IN std_logic_vector(3 DOWNTO 0);
IN_SIG: IN std_logic;
IN_PORT: IN  std_logic_vector(31 DOWNTO 0);
ALU_OUTPUT: OUT  std_logic_vector(31 DOWNTO 0);
FLAGS: OUT std_logic_vector(3 downto 0);
PREV_FLAGS: OUT std_logic_vector(3 downto 0);
ForwardedData:IN std_logic_vector(31 DOWNTO 0);
Forwardselector1,Forwardselector2:IN std_logic;
EXCEPTION_O : OUT STD_LOGIC
);

END ENTITY;

Architecture FetchUnit of EXECUTE IS

component ALU IS
PORT(
	CLK,RST: IN STD_LOGIC ;
	A,B: IN STD_LOGIC_VECTOR (31 downto 0);
	OP_CODE : IN std_logic_vector (4 DOWNTO 0);
	FLAGS_IN: IN STD_LOGIC_VECTOR (3 downto 0);
	F: OUT std_logic_vector (31 downto 0);
	FLAGS_OUT: OUT STD_LOGIC_VECTOR (3 downto 0);
	EXCEPTION_OUT : OUT STD_LOGIC
);
END component;

component CCR IS
PORT(
	CLK, RST,RTI_SIG : IN STD_LOGIC;
	DATAIN: IN STD_LOGIC_VECTOR(3 downto 0);
	RTI_FLAGS: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	DATAOUT: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
);
END component;


component Mux2x1 IS
generic(N : INTEGER );
PORT(
I0,I1: IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
S : IN STD_LOGIC;
O : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0 ));

END component;

--Signals
Signal MUX1OUT : std_logic_vector(31 DOWNTO 0) := (others => '0');
Signal MUX2OUT : std_logic_vector(31 DOWNTO 0) := (others => '0');
Signal MUX3OUT : std_logic_vector(31 DOWNTO 0) := (others => '0');
SIGNAL MUX4OUT : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
signal temp_flags : std_logic_vector(3 downto 0) := (others => '0');
signal temp_flags1 : std_logic_vector(3 downto 0) := (others => '0');
BEGIN
U3:Mux2x1 GENERIC MAP (32) PORT MAP(Read_data1,ForwardedData ,Forwardselector1,MUX1OUT);

U4:Mux2x1 GENERIC MAP (32) PORT MAP(read_data2,ForwardedData ,Forwardselector2,MUX2OUT);

U0:Mux2x1 GENERIC MAP (32) PORT MAP(MUX2OUT,imm_value ,ALU_SRC,MUX3OUT);
U5:Mux2x1 GENERIC MAP (32) PORT MAP(MUX1OUT,IN_PORT,IN_SIG,MUX4OUT);
U1:ALU PORT MAP(CLK,RST,MUX4OUT,MUX3OUT,OP_CODE,temp_flags,AlU_OUTPUT,temp_flags1,EXCEPTION_O);
U2:CCR Port MAP(CLK,RST,RTI_SIG,temp_flags1,RTI_FLAGS,temp_flags);

FLAGS <= temp_flags1;
PREV_FLAGS <= temp_flags;


END ARCHITECTURE;
