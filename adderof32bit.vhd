
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
entity adderof32bit is

Port ( x : in STD_LOGIC_VECTOR (31 downto 0);
	y : in STD_LOGIC_VECTOR (31 downto 0);
	cin : in STD_LOGIC;
	cout : out STD_LOGIC;
	s : out STD_LOGIC_VECTOR (31 downto 0);
	ovf : out STD_LOGIC);
end adderof32bit;

architecture Behavioral of adderof32bit is

SIGNAL C : STD_LOGIC_VECTOR(32 downto 0) ;

component fulladder
	PORT ( cin, x, y : IN STD_LOGIC ;
		s, cout : OUT STD_LOGIC ) ;
END component ;

begin
	c(0) <= cin ;
	Generate_label:
	FOR i IN 0 TO 31 GENERATE
		adder: fulladder PORT MAP ( c(i), x(i), y(i), s(i), c(i+1) ) ;
	END GENERATE ;
	cout <= c(32) ;
	ovf<=c(32) xor c(31);
end Behavioral;