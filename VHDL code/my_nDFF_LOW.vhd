
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY my_nDFF_LOW IS
	GENERIC ( n : integer := 16);
	PORT(	Clk,Rst : IN std_logic;
		d : IN std_logic_vector(n-1 DOWNTO 0);
		q : OUT std_logic_vector(n-1 DOWNTO 0));
END my_nDFF_LOW;

ARCHITECTURE b_my_nDFF_LOW OF my_nDFF_LOW IS
	COMPONENT my_DFF_LOW IS
	PORT( 	d,Clk,Rst : IN std_logic;
			q : OUT std_logic);
	END COMPONENT;
BEGIN
	loop1: FOR i IN 0 TO n-1 GENERATE
	fx: my_DFF_LOW PORT MAP(d(i),Clk,Rst,q(i));
END GENERATE;

END b_my_nDFF_LOW;