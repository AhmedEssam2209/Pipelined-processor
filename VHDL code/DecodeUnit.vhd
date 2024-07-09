LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY DecodeUnit IS

PORT (
CLK,RST,PERV_STALL:IN std_logic;
opcode: IN std_logic_vector(4 DOWNTO 0);
ReadReg1: IN std_logic_vector(2 DOWNTO 0);
ReadReg2: IN std_logic_vector(2 DOWNTO 0);
DST: IN std_logic_vector(2 DOWNTO 0);
RegWRPipeline: IN std_logic;
WriteReg:Std_logic_vector(31 DOWNTO 0);
WriteAdd:std_logic_vector(2 DOWNTO 0);

ReadData1: OUT std_logic_vector(31 DOWNTO 0);
ReadData2: OUT std_logic_vector(31 DOWNTO 0);

MemtoReg, ALUSrc,RegWrite : OUT std_logic;
MemWrite: OUT std_logic;
Stall,Swap,Branch0,BranchU: OUT std_logic;
Push,Pop,Insig: OUT std_logic;
Protect,Free: OUT std_logic;
callSig,retSig,RTI_SIG: OUT STD_LOGIC;
Swaped_INST :OUT std_logic_vector(15 downto 0);
ReadReg1out,ReadReg2out:OUT std_logic_vector(2 downto 0);
OUT_SIG: OUT STD_LOGIC

);

END ENTITY;

Architecture Arch of DecodeUnit is

    COMPONENT controlunit IS

    PORT (
CLK, RST,PERV_STALL : IN std_logic;
OPCODE : IN std_logic_vector(4 DOWNTO 0);
OGInstruction:IN  std_logic_vector(15 downto 0);
Src,DST:IN std_logic_vector(2 downto 0);
--control signals--
--MemtoReg chooses between memory output and Alu output--
--AluSrc chooses wether 2nd operand of Alu is RegSrc2 or ImmValue--
--RegWrite wether operation writes in register file or not--
--MemRead wether operation reads from memory--
--MemRead wether operation writes from memory--
MemtoReg, ALUSrc,RegWrite : OUT std_logic;
MemWrite: OUT std_logic;
Stall,Swap,Branch0,BranchU: OUT std_logic;
Push,Pop,Insig,Outsig: OUT std_logic;
Protect,Free: OUT std_logic;
call: OUT STD_LOGIC;
Ret: OUT STD_LOGIC;
Swap_INST:OUT std_logic_vector(15 downto 0);
RTI_SIG: OUT STD_LOGIC




);
    
    END COMPONENT;

Component REGISTERFILE32 IS

PORT (
CLK, RST, WE : IN std_logic;
DATAIN : IN std_logic_vector(31 DOWNTO 0);
READADDRESS1, READADDRESS2, WRITEADDRESS : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
DATAOUT1, DATAOUT2 : OUT std_logic_vector(31 DOWNTO 0)
);

END Component;
SIGNAL REGWR :std_logic := '0';
SIGNAL OUTSIG :std_logic := '0';
SIGNAL OUTSIG2:std_logic_vector(31 DOWNTO 0) := (others => '0');
SIGNAL TEMP:std_logic_vector(31 DOWNTO 0) := (others => '0');
SIGNAL TEMPOG:std_logic_vector(15 DOWNTO 0) := (others => '0');

Begin

TEMPOG<= OPCODE & ReadReg1&ReadReg2 & DST & "00";
OUT_SIG<= OUTSIG;
u0:Controlunit PORT MAP(CLK,RST,PERV_STALL,OPCODE,TEMPOG,ReadReg1,ReadReg2,MemtoReg, ALUSrc,RegWr,MemWrite,Stall,Swap,Branch0,BranchU,Push,Pop,Insig,Outsig,Protect,Free,callSig,retSig,Swaped_INST,RTI_SIG);
u1:REGISTERFILE32 PORT MAP(CLK,RST,RegWRPipeline,WriteReg,ReadReg1,ReadReg2,WriteAdd,TEMP,ReadData2);


ReadReg1out<=ReadReg1;
ReadReg2out<=ReadReg2;
readdata1 <= temp;
RegWrite<=RegWr;
End Architecture; 