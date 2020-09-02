library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity logical is
	Port ( num1 : in STD_LOGIC_VECTOR (31 downto 0);
		num2 : in STD_LOGIC_VECTOR (31 downto 0);
		op : in STD_LOGIC_VECTOR (3 downto 0);
		outlogical : out STD_LOGIC_VECTOR (31 downto 0));
end logical;

architecture Behavioral of logical is

SIGNAL x : STD_LOGIC_VECTOR(31 downto 0);

begin
	PROCESS (x, op, num1, num2)
		BEGIN
		IF op="0011" THEN
			x <= (num1 AND num2);
		ELSIF op="0001" THEN
			x <= (NOT num1);
		ELSIF op="0000" THEN
			x <= (num1 OR num2);
		ELSIF op="1000" THEN
			SRight: FOR i IN 0 TO 30 loop
				x(i)<=num1(i+1);
				x(31)<='0';
			END loop;
		ELSIF op="1100" THEN
			SLeft: FOR i IN 1 TO 31 loop
				x(i)<=num1(i-1);
				x(0)<='0';
			END loop;
		ELSIF op="1110" THEN
			x(0)<=num1(31);
			--rol entoli
			Rleft: FOR i IN 1 TO 31 loop
				x(i)<=num1(i-1);
			END loop;
		ELSIF op="0101" THEN
			x(31)<=num1(0);
			Rright: FOR i IN 0 TO 30 loop
				x(i)<=num1(i+1);
			END loop;
		END IF;
	END PROCESS;

outlogical<=x;

end Behavioral;