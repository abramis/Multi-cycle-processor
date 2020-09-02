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
entity alu is
	Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
		b : in STD_LOGIC_VECTOR (31 downto 0);
		op : in STD_LOGIC_VECTOR (3 downto 0);
		outalu : out STD_LOGIC_VECTOR (31 downto 0);
		zero : out STD_LOGIC;
		cout : out STD_LOGIC;
		ovf : out STD_LOGIC);
end alu;

architecture Behavioral of alu is

SIGNAL logic, arith, selected : STD_LOGIC_VECTOR(31 downto 0);
SIGNAL test,over : STD_LOGIC;

COMPONENT aithmetic
	PORT(num1, num2 :IN STD_LOGIC_VECTOR(31 downto 0);
		op :IN STD_LOGIC_VECTOR(3 downto 0);
		cout ,ovf :OUT STD_LOGIC;
		outarithmetic :OUT STD_LOGIC_VECTOR(31 downto 0));
END COMPONENT;

COMPONENT logical
	PORT(num1, num2 :IN STD_LOGIC_VECTOR(31 downto 0);
		op :IN STD_LOGIC_VECTOR(3 downto 0);
		outlogical :OUT STD_LOGIC_VECTOR(31 downto 0));
END COMPONENT;

begin
	stage0: aithmetic PORT MAP(a, b, op, test, over, arith);
	stage1: logical PORT MAP(a, b, op, logic);
	
	selected<=arith WHEN op="1111" ELSE
				arith WHEN op="0111" ELSE
				logic WHEN op="0011" else
				logic WHEN op="0001" else
				logic WHEN op="0000" else
				logic WHEN op="1000" else
				logic WHEN op="1100" else
				logic WHEN op="1110" else
				logic WHEN op="0101" ;
				cout<=test WHEN op="1111" ELSE
				test WHEN op="0111" ELSE
				'0' WHEN op="0011" else
				'0' WHEN op="0001" else
				'0' WHEN op="0000" else
				'0' WHEN op="1000" else
				'0' WHEN op="1100" else
				'0' WHEN op="1110" else
				'0' WHEN op="0101" ;
				ovf<=over WHEN op="1111" ELSE
				over WHEN op="0111" ELSE
				'0' WHEN op="0011" else
				'0' WHEN op="0001" else
				'0' WHEN op="0000" else
				'0' WHEN op="1000" else
				'0' WHEN op="1100" else
				'0' WHEN op="1110" else
				'0' WHEN op="0101" ;
				zero<='1' WHEN selected="00000000000000000000000000000000" ELSE
				'0';
				
outalu<=selected;

end Behavioral;


