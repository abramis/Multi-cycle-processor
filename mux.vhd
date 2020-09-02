
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux is
    Port ( reg0 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg1 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg2 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg3 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg4 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg5 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg6 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg7 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg8 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg9 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg10 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg11 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg12 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg13 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg14 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg15 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg16 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg17 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg18 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg19 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg20 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg21 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg22 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg23 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg24 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg25 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg26 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg27 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg28 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg29 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg30 : in  STD_LOGIC_VECTOR (31 downto 0);
           reg31 : in  STD_LOGIC_VECTOR (31 downto 0);
           address : in  STD_LOGIC_VECTOR (4 downto 0);
           out_data : out  STD_LOGIC_VECTOR (31 downto 0));
end mux;

architecture Behavioral of mux is

begin

process (address,reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15, reg16, reg17, reg18, reg19, reg20, reg21, reg22, reg23, reg24, reg25, reg26, reg27, reg28, reg29, reg30, reg31)
begin
	case address is
		when "00000" => out_data <= reg0;
		when "00001" => out_data <= reg1;
		when "00010" => out_data <= reg2;
		when "00011" => out_data <= reg3;
		when "00100" => out_data <= reg4;
		when "00101" => out_data <= reg5;
		when "00110" => out_data <= reg6;
		when "00111" => out_data <= reg7;
		when "01000" => out_data <= reg8;
		when "01001" => out_data <= reg9;
		when "01010" => out_data <= reg10;
		when "01011" => out_data <= reg11;
		when "01100" => out_data <= reg12;
		when "01101" => out_data <= reg13;
		when "01110" => out_data <= reg14;
		when "01111" => out_data <= reg15;
		when "10000" => out_data <= reg16;
		when "10001" => out_data <= reg17;
		when "10010" => out_data <= reg18;
		when "10011" => out_data <= reg19;
		when "10100" => out_data <= reg20;
		when "10101" => out_data <= reg21;
		when "10110" => out_data <= reg22;
		when "10111" => out_data <= reg23;
		when "11000" => out_data <= reg24;
		when "11001" => out_data <= reg25;
		when "11010" => out_data <= reg26;
		when "11011" => out_data <= reg27;
		when "11100" => out_data <= reg28;
		when "11101" => out_data <= reg29;
		when "11110" => out_data <= reg30;
		when "11111" => out_data <= reg31;
		when others => out_data <= (OTHERS=>'0');
	end case;


end process;
end Behavioral;

