library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder is
    Port ( addr_wr : in  STD_LOGIC_VECTOR (4 downto 0);
           addr_wr_out : out  STD_LOGIC_VECTOR (31 downto 0));
end decoder;

architecture Behavioral of decoder is

begin

process(addr_wr)
begin

	case addr_wr is
		when "00000" => addr_wr_out <= (0=>'1',OTHERS=>'0');
		when "00001" => addr_wr_out <= (1=>'1', OTHERS=>'0');
		when "00010" => addr_wr_out <= (2=>'1', OTHERS=>'0');
		when "00011" => addr_wr_out <= (3=>'1', OTHERS=>'0');
		when "00100" => addr_wr_out <= (4=>'1', OTHERS=>'0');
		when "00101" => addr_wr_out <= (5=>'1', OTHERS=>'0');
		when "00110" => addr_wr_out <= (6=>'1', OTHERS=>'0');
		when "00111" => addr_wr_out <= (7=>'1', OTHERS=>'0');
		when "01000" => addr_wr_out <= (8=>'1', OTHERS=>'0');
		when "01001" => addr_wr_out <= (9=>'1', OTHERS=>'0');
		when "01010" => addr_wr_out <= (10=>'1', OTHERS=>'0');
		when "01011" => addr_wr_out <= (11=>'1', OTHERS=>'0');
		when "01100" => addr_wr_out <= (12=>'1', OTHERS=>'0');
		when "01101" => addr_wr_out <= (13=>'1', OTHERS=>'0');
		when "01110" => addr_wr_out <= (14=>'1', OTHERS=>'0');
		when "01111" => addr_wr_out <= (15=>'1', OTHERS=>'0');
		when "10000" => addr_wr_out <= (16=>'1', OTHERS=>'0');
		when "10001" => addr_wr_out <= (17=>'1', OTHERS=>'0');
		when "10010" => addr_wr_out <= (18=>'1', OTHERS=>'0');
		when "10011" => addr_wr_out <= (19=>'1', OTHERS=>'0');
		when "10100" => addr_wr_out <= (20=>'1', OTHERS=>'0');
		when "10101" => addr_wr_out <= (21=>'1', OTHERS=>'0');
		when "10110" => addr_wr_out <= (22=>'1', OTHERS=>'0');
		when "10111" => addr_wr_out <= (23=>'1', OTHERS=>'0');
		when "11000" => addr_wr_out <= (24=>'1', OTHERS=>'0'); 
		when "11001" => addr_wr_out <= (25=>'1', OTHERS=>'0');
		when "11010" => addr_wr_out <= (26=>'1', OTHERS=>'0');
		when "11011" => addr_wr_out <= (27=>'1', OTHERS=>'0');
		when "11100" => addr_wr_out <= (28=>'1', OTHERS=>'0');
		when "11101" => addr_wr_out <= (29=>'1', OTHERS=>'0');
		when "11110" => addr_wr_out <= (30=>'1', OTHERS=>'0');
		when "11111" => addr_wr_out <= (31=>'1', OTHERS=>'0');
		when others => addr_wr_out <= (OTHERS=>'0');
	end case;
		
end process;

end Behavioral;

