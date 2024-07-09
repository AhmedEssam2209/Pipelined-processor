LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY controlunit IS

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

END ENTITY;

Architecture Arch of controlunit is
Signal control :std_logic_vector(16 DOWNTO 0) := (OTHERS => '0');
SIGNAL SWAPPING: std_logic_vector(15 downto 0);
Begin


process(clk,rst) IS

BEGIN
IF rst='1' THEN
	control<="00000000000000000";
	SWAPPING<="0000000000000000";
ELSE
if Falling_EDGE(clk) THEN
	IF(opcode="00000") THEN --NoOp

	control<="00000000000000000";

	END IF;
	IF(opcode="00001") THEN --NOT

	control<="01010000000000000";

	END IF;
	IF(opcode="00100") THEN --DEC

	control<="01010000000000000";

	END IF; 
	IF(opcode="01110") THEN --OR

	control<="01010000000000000";

	END IF;
	IF(opcode="10011") THEN --LDM
	--fakes el swap control signal just use stall and inject either NOP OR swapped

	control<="01110100000000000";
	SWAPPING<="0000000000000000";
	END IF;
	IF(opcode="00111") THEN --MOV

	control<="01010000000000000";

	END IF;	
	IF(opcode="10000") THEN --CMP

	control<="00000000000000000";

	END IF;

IF(opcode="00010") THEN --NEG
    control<="01010000000000000";
END IF;
IF(opcode="00011") THEN --INC
    control<="01010000000000000";
END IF;
IF opcode="01000" AND PERV_STALL = '0' THEN --SWAP,1
    control<="01010110000000000";
SWAPPING<=OGInstruction(15 downto 11) & OGInstruction(4 downto 2) & OGInstruction(7 downto 5)&OGInstruction(10 downto 8)&OGInstruction(1 downto 0);

END IF;
IF opcode="01000" AND PERV_STALL = '1' THEN --SWAP,2
    control<="01010000000000000";
SWAPPING<=OGInstruction(15 downto 11) & OGInstruction(4 downto 2) &OGInstruction(7 downto 5)&OGInstruction(10 downto 8)&OGInstruction(1 downto 0);
END IF;
IF(opcode="01001") THEN --ADD
    control<="01010000000000000";
END IF;
IF(opcode="01010") THEN --ADDI
    control<="01110000000000000";
END IF;
IF(opcode="01011") THEN --SUB
    control<="01010000000000000";
END IF;
IF(opcode="01100") THEN --SUBI
    control<="01110000000000000";
END IF;
IF(opcode="01101") THEN --AND
    control<="01010000000000000";
END IF;
IF(opcode="01111") THEN --XOR
    control<="01010000000000000";
END IF;
IF(opcode="10001") THEN --PUSH
    control<="00001000010000000";
END IF;
IF(opcode="10010") THEN --POP
    control<="00010000001000000";
END IF;
IF(opcode="10100") THEN --LDD
    control<="00110100000000000";
SWAPPING<="0000000000000000";
END IF;
IF(opcode="10101") THEN --STD 
    control<="00101100000000000";
SWAPPING<="0000000000000000";
END IF;
IF(opcode="10110") THEN --PROTECT
    control<="00000000000001000";
END IF;
IF(opcode="10111") THEN --FREE
    control<="00000000000000100";
END IF;

IF(opcode="11010") THEN --CALL
    control<="00001000000000010";
END IF;
IF(opcode="11011") THEN --RET
    control<="00000000000000001";
END IF;
IF(opcode="11100") THEN --RTI
    control<="10000000000000000";
END IF;
IF(opcode="11101") THEN --RESET
    control<="00000000000000000";
END IF;
IF(opcode="00110") THEN --IN
    control<="00010000000100000";
END IF;
IF(opcode="00101") THEN --OUT
    control<="00000000000010000";
END IF;
IF(opcode="11000") THEN --JZ
    control<="00000000100000000";
END IF;
IF(opcode="11001") THEN --JMP
    control<="00000001000000000";
END IF;
END IF;
END IF;

END PROCESS;
RTI_SIG<=control(16);
MemtoReg<=control(15);
ALUSrc<=control(14);
RegWrite<=control(13 );
MemWrite<=control(12 );
Stall<=control(11 );
Swap<=control(10 );
Branch0<=control(9 );
BranchU<=control(8 );
Push<=control(7 );
Pop<=control(6);
Insig<=control(5);
Outsig<=control(4);
Protect<=control(3);
Free<=control(2);
call<=control(1);
Ret<=control(0);
SWAP_INST<=SWAPPING;
END ARCHITECTURE;
