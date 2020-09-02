
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_32bit is
    Port ( clock : in  STD_LOGIC;
           we : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (31 downto 0);
           data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end register_32bit;

architecture Behavioral of register_32bit is
 
signal dout_sig: std_logic_vector (31 downto 0):=(others=>'0');

begin

process(clock)
begin
 
if (clock' event and clock='1') then
	if (we='1') then
		dout_sig <= data;
	end if;
end if;

end process;

data_out <= dout_sig;

end Behavioral;

