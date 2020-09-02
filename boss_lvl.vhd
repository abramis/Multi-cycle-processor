library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity boss_lvl is
    Port ( Clk : in STD_LOGIC;
				Reset : in  STD_LOGIC);
end boss_lvl;

architecture Behavioral of boss_lvl is

	COMPONENT IFSTAGE
	PORT(
		PC_Immed : IN std_logic_vector(31 downto 0);
		PC_sel : IN std_logic;
		PC_LdEn : IN std_logic;
		Reset : IN std_logic;
		Clk : IN std_logic;          
		Instr : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT DECSTAGE
	PORT(
		Instr : IN std_logic_vector(31 downto 0);
		RF_WrEn : IN std_logic;
		ALU_out : IN std_logic_vector(31 downto 0);
		MEM_out : IN std_logic_vector(31 downto 0);
		RF_WrData_sel : IN STD_LOGIC_VECTOR (1 downto 0);
		RF_B_sel : IN std_logic;
		Clk : IN std_logic;          
		Immed : INOUT std_logic_vector(31 downto 0);
		RF_A : OUT std_logic_vector(31 downto 0);
		RF_B : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ALUSTAGE
	PORT(
		RF_A : IN std_logic_vector(31 downto 0);
		RF_B : IN std_logic_vector(31 downto 0);
		Immed : IN std_logic_vector(31 downto 0);
		ALU_Bin_sel : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);          
		ALU_out : OUT std_logic_vector(31 downto 0);
		zero: OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT MEMSTAGE
	PORT(
		Clk : IN std_logic;
		MEM_WrEn : IN std_logic;
		ALU_MEM_Addr : IN std_logic_vector(31 downto 0);
		MEM_DataIn : IN std_logic_vector(31 downto 0);          
		MEM_DataOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT control1
	PORT(
		instr : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;
		clk : IN std_logic;
		zero : IN std_logic;          
		pcsel : OUT std_logic;
		pclden : OUT std_logic;
		rfbsel : OUT std_logic;
		rfwren : OUT std_logic;
		rfwrdatasel : OUT std_logic_vector(1 downto 0);
		alubinsel : OUT std_logic;
		alufunc : OUT std_logic_vector(3 downto 0);
		memwren : OUT std_logic;
		memdinsel : OUT std_logic;
		memdoutsel : OUT std_logic
		);
	END COMPONENT;


signal Instr_sig,Immed_sig,RFa_sig,RFb_sig,memdatain_sig,aluout_sig,memout_sig,memdataout_sig : STD_LOGIC_VECTOR (31 downto 0);
signal zero_sig,pcsel_sig,pclden_sig,rfbsel_sig,rfwren_sig,alubinsel_sig,memwren_sig,memdinsel_sig,memdoutsel_sig: STD_LOGIC;
signal rfwrdatasel_sig: STD_LOGIC_VECTOR (1 downto 0);
signal alufunc_sig: STD_LOGIC_VECTOR (3 downto 0);

begin

	Inst_IFSTAGE: IFSTAGE PORT MAP(
		PC_Immed => Immed_sig,
		PC_sel => pcsel_sig,
		PC_LdEn => pclden_sig,
		Reset => Reset,
		Clk =>Clk ,
		Instr => Instr_sig
	);

	Inst_DECSTAGE: DECSTAGE PORT MAP(
		Instr => Instr_sig,
		RF_WrEn => rfwren_sig,
		ALU_out =>aluout_sig ,
		MEM_out =>memout_sig ,
		RF_WrData_sel => rfwrdatasel_sig,
		RF_B_sel => rfbsel_sig,
		Clk =>Clk ,
		Immed => Immed_sig,
		RF_A => RFa_sig,
		RF_B =>RFb_sig 
	);
	
	Inst_ALUSTAGE: ALUSTAGE PORT MAP(
		RF_A => RFa_sig,
		RF_B => RFb_sig,
		Immed => Immed_sig,
		ALU_Bin_sel => alubinsel_sig,
		ALU_func => alufunc_sig,
		ALU_out =>aluout_sig, 
		zero=> zero_sig
	);

	Inst_MEMSTAGE: MEMSTAGE PORT MAP(
		Clk => Clk,
		MEM_WrEn => memwren_sig,
		ALU_MEM_Addr =>aluout_sig ,
		MEM_DataIn => memdatain_sig,
		MEM_DataOut => memdataout_sig
	);

	Inst_control1: control1 PORT MAP(
		instr => Instr_sig,
		reset => Reset,
		clk => clk,
		zero => zero_sig,
		pcsel => pcsel_sig,
		pclden => pclden_sig,
		rfbsel => rfbsel_sig,
		rfwren => rfwren_sig,
		rfwrdatasel => rfwrdatasel_sig,
		alubinsel => alubinsel_sig,
		alufunc => alufunc_sig,
		memwren => memwren_sig,
		memdinsel =>memdinsel_sig ,
		memdoutsel => memdoutsel_sig
	);
PROCESS(RFb_sig, memdinsel_sig)
begin
	if ( memdinsel_sig = '0') then
		memdatain_sig <= RFb_sig;
	else
		memdatain_sig(7 downto 0) <= RFb_sig(7 downto 0);
		memdatain_sig(31 downto 8) <= (others => '0');
	end if;
end process;				 

PROCESS(memdataout_sig, memdoutsel_sig)
begin
	if ( memdoutsel_sig = '0') then
		memout_sig <= memdataout_sig;
	else
		memout_sig(7 downto 0) <= memdataout_sig(7 downto 0);
		memout_sig(31 downto 8) <= (others => '0');
	end if;
end process;

end Behavioral;

