LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY DataMemory IS

PORT (
CLK,RST,WE,INTERRUPT_SIG,RTI_SIG,MEMTOREG: IN std_logic;
Protect_SIG,Free_SIG : IN std_logic;
ADDRESS : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
WriteData: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
FLAGS: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
DATAOUT : OUT std_logic_vector(31 DOWNTO 0);
FLAGS_OUT: OUT std_logic_vector(3 DOWNTO 0);
EXCEPTION_OUT : OUT STD_LOGIC 

);

END ENTITY;

ARCHITECTURE ARCH OF DataMemory IS

TYPE ram_type IS ARRAY(4095 DOWNTO 0) of std_logic_vector(16 DOWNTO 0);
SIGNAL RAM : ram_type ;
SIGNAL Protect_Bit : std_logic;
SIGNAL TEMP_DATAOUT : std_logic_vector(31 DOWNTO 0);
BEGIN

PROCESS(CLK, RST) IS
BEGIN

IF to_integer("0000" & unsigned(ADDRESS(11 DOWNTO 0 ))) >4095 OR to_integer("0000" & unsigned(ADDRESS(11 DOWNTO 0 ))) <0 THEN
EXCEPTION_OUT<= '1';
else
EXCEPTION_OUT<= '0';
END IF;


if Protect_SIG = '1' then
RAM(to_integer("0000" & unsigned(ADDRESS(11 DOWNTO 0))) )(16) <= '1';
RAM(to_integer("0000" & unsigned(ADDRESS(11 DOWNTO 0))) + 1 )(16) <= '1';
end if;
if Free_SIG = '1' then
RAM(to_integer("0000" & unsigned(ADDRESS(11 DOWNTO 0))) )(16) <= '0';
RAM(to_integer("0000" & unsigned(ADDRESS(11 DOWNTO 0))) + 1 )(16) <= '0';
end if;   


Protect_Bit <= RAM(to_integer("0000" &unsigned(ADDRESS(11 DOWNTO 0))))(16);

IF INTERRUPT_SIG = '1' THEN
RAM(to_integer("0000" & unsigned(ADDRESS(11 DOWNTO 0))) ) <= '0' & WriteData(31 DOWNTO 16);
RAM(to_integer("0000" & unsigned(ADDRESS(11 DOWNTO 0))) + 1 ) <='0'&  WriteData(15 DOWNTO 0);
RAM(to_integer("0000" & unsigned(ADDRESS(11 DOWNTO 0))) - 2) <= "0000000000000" & FLAGS(3 DOWNTO 0);
RAM(to_integer("0000" & unsigned(ADDRESS(11 DOWNTO 0))) - 1 ) <="00000000000000000" ;
END IF;

IF RTI_SIG = '1' THEN
FLAGS_OUT <= RAM(to_integer(unsigned(ADDRESS(15 DOWNTO 0))) - 2)(3 DOWNTO 0);
END IF;

IF RST = '1' THEN

RAM <= (OTHERS => (OTHERS => '0'));

ELSIF falling_edge(CLK) THEN
IF MEMTOREG ='1'  OR unsigned(ADDRESS(11 DOWNTO 0 )) = "111111111111" THEN
    
    TEMP_DATAOUT <= "00000000000000000000000000000000";    
     else
           
    IF WE = '1'  AND Protect_bit = '0'  THEN
    RAM(to_integer("0000" & unsigned(ADDRESS(11 DOWNTO 0))) ) <= '0' & WriteData(31 DOWNTO 16);
    RAM(to_integer("0000" & unsigned(ADDRESS(11 DOWNTO 0))) + 1 ) <='0'&  WriteData(15 DOWNTO 0);
    END IF;

   

        
    TEMP_DATAOUT <=RAM(to_integer("0000" & unsigned(ADDRESS(11 DOWNTO 0 ))))(15 downto 0) & RAM(to_integer("0000" & unsigned(ADDRESS(11 DOWNTO 0) )) + 1)(15 downto 0) ;
    END IF;
    END IF;


END PROCESS;


DATAOUT <= TEMP_DATAOUT;

END ARCHITECTURE;
