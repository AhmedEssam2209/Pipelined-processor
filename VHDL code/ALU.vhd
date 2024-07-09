
Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ALU IS
PORT(
	CLK,RST: IN STD_LOGIC ;
	A,B: IN STD_LOGIC_VECTOR (31 downto 0);
	OP_CODE : IN std_logic_vector (4 DOWNTO 0);
	FLAGS_IN: IN STD_LOGIC_VECTOR (3 downto 0);
	F: OUT std_logic_vector (31 downto 0);
	FLAGS_OUT: OUT STD_LOGIC_VECTOR (3 downto 0);
	EXCEPTION_OUT : OUT STD_LOGIC 
);
	
	

END ENTITY;


ARCHITECTURE ArchD_1 of ALU is

SIGNAL External_F: STD_LOGIC_VECTOR (32 downto 0):= (OTHERS => '0');
SIGNAL FLAGS: STD_LOGIC_VECTOR (3 downto 0) := (OTHERS => '0');
BEGIN

Process (CLK,RST,OP_CODE,A,B) IS

VARIABLE Internal_F: STD_LOGIC_VECTOR (32 downto 0);
VARIABLE Temp_F: STD_LOGIC_VECTOR (32 downto 0);

begin
--OUTPUT
IF RST = '1' THEN
	FLAGS <= (OTHERS => '0');
	External_F <= (OTHERS => '0');

	ELSIF FALLING_EDGE(CLK) THEN
Case OP_CODE IS


--NOP
	--XXX WHEN  "00000",
--NOT
	WHEN  "00001" =>
	Internal_F := NOT ( A(31) & A ) ;
	if Internal_F = "000000000000000000000000000000000"
	then
	FLAGS(0) <= '1';
	else
	FLAGS(0) <= '0';
	end if;
	
	FLAGS(1) <= Internal_F(31);
 	
--NEG
	WHEN  "00010" =>
	
       	Internal_F := STD_LOGIC_VECTOR( NOT( A(31) & SIGNED(A) )+1);
    
	
	if Internal_F = "000000000000000000000000000000000"
	then
	FLAGS(0) <= '1';
	else
	FLAGS(0) <= '0';
	end if;	

	FLAGS(1) <= Internal_F(31);
--INC
	WHEN  "00011" =>
	
       	Internal_F := STD_LOGIC_VECTOR( (A(31) & SIGNED(A)  )  + 1);
    
	
	if Internal_F = "000000000000000000000000000000000"
	then
	FLAGS(0) <= '1';
	FLAGS(2) <= '1';    --Carry
	else
	FLAGS(0) <= '0';
	FLAGS(2) <= '0';
	end if;	


	FLAGS(1) <= Internal_F(31);


--DECRMENT TODO
	WHEN  "00100" =>
	
       	Internal_F := STD_LOGIC_VECTOR( (A(31) & SIGNED(A)  )  - 1);
    
	
	if Internal_F = "000000000000000000000000000000000"
	then
	FLAGS(0) <= '1';
	else
	FLAGS(0) <= '0';
	end if;	

	if Internal_F = "111111111111111111111111111111111"   --Carry
	then
	FLAGS(2) <= '1';
	else
	FLAGS(2) <= '0';
	end if;	

	FLAGS(1) <= Internal_F(31);
--OUT
	--XXX WHEN  "00101",
--IN
	WHEN  "00110" =>
	Internal_F := A(31) & A;
--MOV
	WHEN  "00111" =>
	Internal_F := A(31) & A;
--SWAP
	WHEN  "01000" =>
	Internal_F := A(31) & A  ;
--ADD
	 WHEN  "01001" =>
	Internal_F := STD_LOGIC_VECTOR((A(31) & SIGNED(A)) + (B(31) & SIGNED(B)));
	
	if Internal_F = "000000000000000000000000000000000"
	then
	FLAGS(0) <= '1';
	else
	FLAGS(0) <= '0';
	end if;	

	FLAGS(1) <= Internal_F(31);
    if (A(31) = '0' and B(31) = '0' and Internal_F(31) = '1') or  -- Positive overflow
       (A(31) = '1' and B(31) = '1' and Internal_F(31) = '0') then -- Negative overflow
        FLAGS(3) <= '1'; -- Set overflow flag
		EXCEPTION_OUT<= '1';
    else
        FLAGS(3) <= '0'; -- Clear overflow flag
		EXCEPTION_OUT<= '0';
    end if;

	if Internal_F(32) = '1' THEN  --Carry
	FLAGS(2) <= '1';
	else
	FLAGS(2) <= '0';
	end if;	

--ADDI
	 WHEN  "01010" =>
	Internal_F := STD_LOGIC_VECTOR((A(31) & SIGNED(A)) + (B(31) & SIGNED(B)));
	
	if Internal_F = "000000000000000000000000000000000"
	then
	FLAGS(0) <= '1';
	else
	FLAGS(0) <= '0';
	end if;	

	FLAGS(1) <= Internal_F(31);
    if (A(31) = '0' and B(31) = '0' and Internal_F(31) = '1') or  -- Positive overflow
       (A(31) = '1' and B(31) = '1' and Internal_F(31) = '0') then -- Negative overflow
        FLAGS(3) <= '1'; -- Set overflow flag
		EXCEPTION_OUT<= '1';
    else
        FLAGS(3) <= '0'; -- Clear overflow flag
		EXCEPTION_OUT<= '0';
    end if;

	if Internal_F(32) = '1' THEN --Carry
	FLAGS(2) <= '1';
	else
	FLAGS(2) <= '0';
	end if;	

--SUB
	 WHEN  "01011" =>
	Internal_F := STD_LOGIC_VECTOR((A(31) & SIGNED(A)) - (B(31) & SIGNED(B))); 
	
	if Internal_F = "000000000000000000000000000000000"
	then
	FLAGS(0) <= '1';
	else
	FLAGS(0) <= '0';
	end if;	

	FLAGS(1) <= Internal_F(31);
    if (A(31) = '0' and B(31) = '0' and Internal_F(31) = '1') or  -- Positive overflow
       (A(31) = '1' and B(31) = '1' and Internal_F(31) = '0') then -- Negative overflow
        FLAGS(3) <= '1'; -- Set overflow flag
		EXCEPTION_OUT<= '1';
    else
        FLAGS(3) <= '0'; -- Clear overflow flag
		EXCEPTION_OUT<= '0';
    end if;

	if (signed(A) & A(31)) - (signed(B) & B(31)) >0 THEN
	FLAGS(2) <= '1';
	else
	FLAGS(2) <= '0';
	end if;	

--SUBI
	 WHEN  "01100" =>
	Internal_F := STD_LOGIC_VECTOR((A(31) & SIGNED(A)) - (B(31) & SIGNED(B)));
	
	if Internal_F = "000000000000000000000000000000000"
	then
	FLAGS(0) <= '1';
	else
	FLAGS(0) <= '0';
	end if;	

	FLAGS(1) <= Internal_F(31);
    if (A(31) = '0' and B(31) = '0' and Internal_F(31) = '1') or  -- Positive overflow
       (A(31) = '1' and B(31) = '1' and Internal_F(31) = '0') then -- Negative overflow
        FLAGS(3) <= '1'; -- Set overflow flag
		EXCEPTION_OUT<= '1';
    else
        FLAGS(3) <= '0'; -- Clear overflow flag
		EXCEPTION_OUT<= '0';
    end if;

	if (signed(A) & A(31)) - (signed(B) & B(31)) >0 THEN
	FLAGS(2) <= '1';
	else
	FLAGS(2) <= '0';
	end if;	

--AND
	 WHEN  "01101" =>
	Internal_F := STD_LOGIC_VECTOR((A(31) & signed(A)) AND (B(31) & signed(B)));
	
	if Internal_F = "000000000000000000000000000000000"
	then
	FLAGS(0) <= '1';
	else
	FLAGS(0) <= '0';
	end if;	

	FLAGS(1) <= Internal_F(31);
--OR
	 WHEN  "01110" =>
	Internal_F := STD_LOGIC_VECTOR((A(31) & signed(A)) OR (B(31) & signed(B)));
	
	if Internal_F = "000000000000000000000000000000000"
	then
	FLAGS(0) <= '1';
	else
	FLAGS(0) <= '0';
	end if;	

	FLAGS(1) <= Internal_F(31);
	
--XOR
	 WHEN  "01111" =>
	Internal_F := STD_LOGIC_VECTOR((A(31) & signed(A)) XOR (B(31) & signed(B)));
	
	if Internal_F = "000000000000000000000000000000000"
	then
	FLAGS(0) <= '1';
	else
	FLAGS(0) <= '0';
	end if;	

	FLAGS(1) <= Internal_F(31);
--CMP TODO (flags)
	WHEN  "10000" =>
	Temp_F :=  STD_LOGIC_VECTOR( ( A(31) & signed(A)) - (B(31) & signed(B)));
	
	if Temp_F = "000000000000000000000000000000000"
	then
	FLAGS(0) <= '1';
	else
	FLAGS(0) <= '0';
	end if;
		
	
	
	if SIGNED(A) < SIGNED (B) THEN
	FLAGS(1) <= '1';
	else
	FLAGS(1) <= '0';
	end if;

    if (A(31) = '0' and B(31) = '1' and Temp_F(31) = '1') or  -- Positive overflow
       (A(31) = '1' and B(31) = '0' and Temp_F(31) = '0') then -- Negative overflow
        FLAGS(3) <= '1'; -- Set overflow flag
		EXCEPTION_OUT<= '1';
    else
        FLAGS(3) <= '0'; -- Clear overflow flag
		EXCEPTION_OUT<= '0';
    end if;
	

--PUSH
	--XXX WHEN  "10001",
--POP
	--XXX WHEN  "10010",
--LDM
	WHEN  "10011" =>
	Internal_F := B(31) & B ;
--LDD
	WHEN  "10100" =>
	Internal_F := STD_LOGIC_VECTOR((A(31) & signed(A)) + (B(31) & signed(B)));
	
	if Internal_F = "000000000000000000000000000000000"
	then
	FLAGS(0) <= '1';
	else
	FLAGS(0) <= '0';
	end if;	

	FLAGS(1) <= Internal_F(31);

    if (A(31) = '0' and B(31) = '0' and Internal_F(31) = '1') or  -- Positive overflow
       (A(31) = '1' and B(31) = '1' and Internal_F(31) = '0') then -- Negative overflow
        FLAGS(3) <= '1'; -- Set overflow flag
		EXCEPTION_OUT<= '1';
    else
        FLAGS(3) <= '0'; -- Clear overflow flag
		EXCEPTION_OUT<= '0';
    end if;

--STD
	--here we need writedata into memory to be Rsrc1 instead of Rscrc2 like normal (assembler?)
	--Alu adds A(RSRC2) and B(immediate value)
	WHEN  "10101"=>
	Internal_F := STD_LOGIC_VECTOR((A(31) & signed(A)) + (B(31) & signed(B) ));
	
	if Internal_F = "000000000000000000000000000000000"
	then
	FLAGS(0) <= '1';
	else
	FLAGS(0) <= '0';
	end if;	

	FLAGS(1) <= Internal_F(31);
    if (A(31) = '0' and B(31) = '0' and Internal_F(31) = '1') or  -- Positive overflow
       (A(31) = '1' and B(31) = '1' and Internal_F(31) = '0') then -- Negative overflow
        FLAGS(3) <= '1'; -- Set overflow flag
		EXCEPTION_OUT<= '1';
    else
        FLAGS(3) <= '0'; -- Clear overflow flag
		EXCEPTION_OUT<= '0';
    end if;
	
--PROGECT
WHEN  "10110" =>
Internal_F := A(31) & A  ;
--FREE
WHEN  "10111" =>
Internal_F := A(31) & A  ;
--JZ
WHEN  "11000" =>
Internal_F := A(31) & A  ;
--JMP
	WHEN  "11001" =>
	Internal_F := A(31) & A  ;
--CALL
WHEN  "11010" =>
Internal_F := A(31) & A  ;
--RET
WHEN  "11011" =>
Internal_F := A(31) & A  ;
--RTI
WHEN  "11100" =>
Internal_F := A(31) & A  ;
--RESET

--INTERRUPT TODO

WHEN others =>
	null;
end case;
External_F <= Internal_F ;
	end if;
end process;

--FLAGS

Flags_OUT <= Flags ;
F <= External_F(31 downto 0);



END ARCHITECTURE;