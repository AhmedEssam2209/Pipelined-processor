LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY PC IS
	PORT(	CLK, RST, STALL, INTERRUPT_SIG : IN STD_LOGIC;
		DATA_IN: IN STD_LOGIC_VECTOR(31 downto 0);
		RESET_VALUE, INT_VALUE: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		DATAOUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
END ENTITY;

ARCHITECTURE PC_ARCH OF PC IS
	

	SIGNAL DATAIN: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
BEGIN
	PROCESS(CLK, RST) IS
	
	BEGIN
		IF RST = '1' THEN
			DATAIN <= RESET_VALUE;
		ELSIF RISING_EDGE(CLK) THEN
			IF INTERRUPT_SIG ='1' THEN
			DATAIN <= INT_VALUE;
			ELSIF STALL = '1' THEN
				DATAIN <= STD_LOGIC_VECTOR(UNSIGNED(DATA_IN)-1);
			ELSE 
				DATAIN <= STD_LOGIC_VECTOR(UNSIGNED(DATA_IN));		
			END IF;
		END IF;
	END PROCESS;
	
	DATAOUT <= DATAIN;

END ARCHITECTURE;
