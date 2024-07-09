
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY BranchPredictionUnit IS
    PORT (
        clk : IN STD_LOGIC; --??????????????
        BranchResult, LastPred: IN STD_LOGIC;
        LastPredOut : OUT STD_LOGIC;
	WrongPrediction : OUT STD_LOGIC;
        Flush : OUT STD_LOGIC --hatrooh as a RST signal to F/D, D/E, E/M
    );
END BranchPredictionUnit;

ARCHITECTURE BracnchPred OF BranchPredictionUnit IS
BEGIN
    PROCESS (BranchResult, LastPred)
    BEGIN
        IF BranchResult = LastPred THEN
            -- Correct prediction
            WrongPrediction <= '0';
            Flush <= '0';
        ELSE
            -- Wrong prediction
            WrongPrediction <= '1';
            Flush <= '1';
        END IF;
        
        -- Output LastPred
        LastPredOut <= LastPred;
    END PROCESS;
END BracnchPred;



