LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ForwardingUnit IS
    PORT (
        clk,SWAPPING1,SWAPPING2,REGWRITE1,REGWRITE2,IN_SIG : IN STD_LOGIC;
        Src1, Src2, ExDst, MemDst : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        MemtoRegE, MemtoRegM : IN STD_LOGIC;
        ExResultMe, MemResult : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        ForwardedData1 : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        Selector1, Selector2 : OUT STD_LOGIC
    );
END ForwardingUnit;

ARCHITECTURE Forwarding OF ForwardingUnit IS
SIGNAL STORED_DST : STD_LOGIC_VECTOR (2 DOWNTO 0) := (OTHERS => '0');
SIGNAL STORED_DST1 : STD_LOGIC_VECTOR (2 DOWNTO 0) := (OTHERS => '0');
SIGNAL STORED_DATA : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
SIGNAL STORED_DATA1 : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');

begin
    PROCESS (clk)
    VARIABLE S1,S2 : STD_LOGIC := '0';
    variable ForwardedData : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
    
    BEGIN
       
        --if rising_edge(clk) then
            -- Default selectors to '0
            S1 := '0';
            S2 := '0';
            ForwardedData := (others => '0');
            -- Forwarding for Src1
            IF Src1 = STORED_DST1 AND MemtoRegM = '0' AND SWAPPING2 = '0' AND REGWRITE1 ='1'THEN
                ForwardedData := STORED_DATA1;
                S1 := '1';
            END if;
            IF Src1 = STORED_DST AND (MemtoRegE = '1' OR IN_SIG = '1') AND SWAPPING1 = '0' AND REGWRITE2 ='1'THEN
                ForwardedData := STORED_DATA;
                S1 := '1';
            END IF; 
            if Src2 = STORED_DST1 AND MemtoRegM = '0'AND SWAPPING2 = '0'AND REGWRITE1 ='1' THEN
                ForwardedData := STORED_DATA1;
                S2 := '1';
                END if;
            IF Src2 = STORED_DST AND(MemtoRegE = '1' OR IN_SIG = '1') AND SWAPPING1 = '0'AND REGWRITE2 ='1'THEN
                ForwardedData := STORED_DATA;
                S2 := '1';
         
            END IF;
            
            Selector1 <= S1;
            Selector2 <= S2;
            STORED_DST <= ExDst;
            STORED_DST1 <= MemDst;
            
            ForwardedData1 <= ForwardedData;

  --END IF;
    END PROCESS;
        STORED_DATA <= ExResultMe;
            STORED_DATA1 <= MemResult;
END Forwarding;
