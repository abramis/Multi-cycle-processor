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
entity aithmetic is
	Port ( num1 : in STD_LOGIC_VECTOR (31 downto 0);
		num2 : in STD_LOGIC_VECTOR (31 downto 0);
		op : in STD_LOGIC_VECTOR (3 downto 0);
		cout : out STD_LOGIC;
		ovf : out STD_LOGIC;
		outarithmetic : out STD_LOGIC_VECTOR (31 downto 0));
end aithmetic;

architecture Behavioral of aithmetic is

SIGNAL result, result_add, result_sub, complement: STD_LOGIC_VECTOR(31 downto 0);
SIGNAL c1,c2, c, d ,ovf1,ovf2: STD_LOGIC;

component adderof32bit is
	Port ( cin : in STD_LOGIC;
		x : in STD_LOGIC_VECTOR (31 downto 0);
		y : in STD_LOGIC_VECTOR (31 downto 0);
		s : out STD_LOGIC_VECTOR (31 downto 0);
		cout : out STD_LOGIC;
		ovf : out STD_LOGIC);
end component;

begin
	c<='0';
	stage0: adderof32bit PORT MAP (c, num1, num2, result_add, c1,ovf1);
	complement<=NOT num2;
	d<='1';
	stage1: adderof32bit PORT MAP (d, num1, complement, result_sub, c2,ovf2);
	with op select
		result<=result_add WHEN "1111",
		result_sub WHEN "0111",
		"00000000000000000000000000000000" when others;
	with op select
		cout<=c1 WHEN "1111",
		c2 WHEN "0111" ,
		'0' when others;
	with op select
		ovf<=ovf1 WHEN "1111",
		'0' WHEN others;
		outarithmetic<=result;
end Behavioral;
