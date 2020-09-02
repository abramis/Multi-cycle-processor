library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MEMSTAGE is
Port ( Clk : in STD_LOGIC;
		MEM_WrEn : in STD_LOGIC;
		ALU_MEM_Addr : in STD_LOGIC_VECTOR (31 downto 0);
		MEM_DataIn : in STD_LOGIC_VECTOR (31 downto 0);
		MEM_DataOut : out STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is

	COMPONENT Data_MEM
	PORT(
		clk : IN std_logic;
		we : IN std_logic;
		addr : IN std_logic_vector(9 downto 0);
		din : IN std_logic_vector(31 downto 0);          
		dout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
signal MEM_AddrIn : STD_LOGIC_VECTOR (9 downto 0);

begin
	MEM_AddrIn <= ALU_MEM_Addr(11 downto 2);
	
	MEM : Data_MEM
	PORT Map(
				clk => Clk,
				we => MEM_WrEn,
				addr => MEM_AddrIn,
				din => MEM_DataIn,
				dout => MEM_DataOut
	);
end Behavioral;