
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFSTAGE is
Port ( PC_Immed : in STD_LOGIC_VECTOR (31 downto 0);
		PC_sel : in STD_LOGIC;
		PC_LdEn : in STD_LOGIC;
		Reset : in STD_LOGIC;
		Clk : in STD_LOGIC;
		Instr : out STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

component IF_MEM IS
PORT (
		clk : IN STD_LOGIC;
		addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END component;

component PC is
Port ( MUX_out : in STD_LOGIC_VECTOR (31 downto 0);
		PC_LdEn : in STD_LOGIC;
		Clk : in STD_LOGIC;
		Reset : in STD_LOGIC;
		PC_out : out STD_LOGIC_VECTOR (9 downto 0));
end component;

--	COMPONENT IFmux
--	PORT(
--		pcim : IN std_logic_vector(9 downto 0);
--		pcsel : IN std_logic;
--		pcout : IN std_logic_vector(9 downto 0);          
--		muxout : OUT std_logic_vector(9 downto 0)
--		);
--	END COMPONENT;


signal MUX_temp, PC_temp : STD_LOGIC_VECTOR (31 downto 0):=(others=>'0');
signal instrSig : STD_LOGIC_VECTOR (31 downto 0);
--signal PC_temp :STD_LOGIC_VECTOR (9 downto 0):=(others=>'0');
begin



process(PC_temp, PC_Immed,PC_Sel)
begin

	--wait until clk'event and clk='1';
	if (PC_Sel='0') then
		MUX_temp <=( PC_temp+4);
	else
		MUX_temp <= ((PC_temp)+4+PC_Immed);
	end if;
end process;

MEM : IF_MEM
PORT MAP (
			clk => Clk,
			addr => PC_temp(11 downto 2),
			dout => instrSig
);

PCcomp : PC
Port Map(
			MUX_out => MUX_temp,
			PC_LdEn => PC_LdEn,
			Clk => Clk,
			Reset => Reset,
			PC_out => PC_temp(9 downto 0)
);

--	Inst_IFmux: IFmux PORT MAP(
--		pcim => PC_Immedsig,
--		pcsel =>PC_sel ,
--		pcout => PC_temp,
--		muxout =>MUX_temp 
--	);
Instr<=instrSig;
end Behavioral;