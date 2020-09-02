
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
entity fulladder is

Port ( x : in STD_LOGIC;
	y : in STD_LOGIC;
	cin : in STD_LOGIC;
	s : out STD_LOGIC;
	cout : out STD_LOGIC);
end fulladder;

architecture Behavioral of fulladder is
	begin
		s <= x XOR y XOR Cin ;
		cout <= (x AND y) OR (x AND cin) OR (y AND cin) ;
end Behavioral;
