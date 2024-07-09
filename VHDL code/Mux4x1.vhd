library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY Mux4x1 IS
    generic(N : INTEGER );
    PORT(
        I0, I1, I2, I3 : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        O : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE ARCH1 OF Mux4x1 IS
    SIGNAL Mux2_out_0, Mux2_out_1 : STD_LOGIC_VECTOR (N-1 DOWNTO 0);
BEGIN
    Mux2_0: entity work.Mux2x1 generic map(N => N) port map(I0 => I0, I1 => I1, S => S(0), O => Mux2_out_0);
    Mux2_1: entity work.Mux2x1 generic map(N => N) port map(I0 => I2, I1 => I3, S => S(0), O => Mux2_out_1);
    O <= Mux2_out_0 WHEN S(1) = '0' ELSE Mux2_out_1;
END ARCHITECTURE;

