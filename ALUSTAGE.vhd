library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ALUSTAGE is
Port ( RF_A : in STD_LOGIC_VECTOR (31 downto 0);
		RF_B : in STD_LOGIC_VECTOR (31 downto 0);
		Immed : in STD_LOGIC_VECTOR (31 downto 0);
		ALU_Bin_sel : in STD_LOGIC;
		ALU_func : in STD_LOGIC_VECTOR (3 downto 0);
		ALU_out : out STD_LOGIC_VECTOR (31 downto 0);
		zero: OUT std_logic
		);
end ALUSTAGE;

architecture Behavioral of ALUSTAGE is

component alu is
Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
		b : in STD_LOGIC_VECTOR (31 downto 0);
		op : in STD_LOGIC_VECTOR (3 downto 0);
		outalu : out STD_LOGIC_VECTOR (31 downto 0);
		zero : out STD_LOGIC;
		cout : out STD_LOGIC;
		ovf : out STD_LOGIC);
end component;

signal  MUX_out : STD_LOGIC_VECTOR (31 downto 0);

begin
	process(RF_A, RF_B, Immed, ALU_Bin_sel, ALU_func)
	begin
	   if (ALU_Bin_sel='0') then
			MUX_out <= RF_B;
		else
			MUX_out <= Immed;
		end if;
	end process;

ALU1 : alu
Port Map(
			a => RF_A,
			b => MUX_out,
			op => ALU_func,
			outalu => ALU_out,
			zero => zero,
			cout => open,
			ovf => open
);
end Behavioral;