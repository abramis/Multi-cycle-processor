library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
Port ( MUX_out : in STD_LOGIC_VECTOR (31 downto 0);
		PC_LdEn : in STD_LOGIC;
		Clk : in STD_LOGIC;
		Reset : in STD_LOGIC;
		PC_out : out STD_LOGIC_VECTOR (9 downto 0));
end PC;

architecture Behavioral of PC is

signal temp_signal : STD_LOGIC_VECTOR (31 downto 0);

begin
	process(Clk,Reset,MUX_out)
	begin
		if (Reset='1') then
			temp_signal <= (others=>'0');
		elsif (Clk'event and Clk='1') then
			if (PC_LdEn='1') then
				temp_signal <= MUX_out;
			else
				temp_signal<=temp_signal;
			end if;
		end if;	
	end process;
	PC_out<=temp_signal(9 downto 0);
end Behavioral;