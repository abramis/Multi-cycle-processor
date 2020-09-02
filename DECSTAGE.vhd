library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DECSTAGE is
Port ( Instr : in STD_LOGIC_VECTOR (31 downto 0);
		RF_WrEn : in STD_LOGIC;
		ALU_out : in STD_LOGIC_VECTOR (31 downto 0);
		MEM_out : in STD_LOGIC_VECTOR (31 downto 0);
		RF_WrData_sel : in STD_LOGIC_VECTOR (1 downto 0);
		RF_B_sel : in STD_LOGIC;
		Clk : in STD_LOGIC;
		Immed : inout STD_LOGIC_VECTOR (31 downto 0);
		RF_A : out STD_LOGIC_VECTOR (31 downto 0);
		RF_B : out STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE;

architecture Behavioral of DECSTAGE is

component top_level is
Port ( Adr1 : in STD_LOGIC_VECTOR (4 downto 0);
		Adr2 : in STD_LOGIC_VECTOR (4 downto 0);
		Awr : in STD_LOGIC_VECTOR (4 downto 0);
		Dout1 : out STD_LOGIC_VECTOR (31 downto 0);
		Dout2 : out STD_LOGIC_VECTOR (31 downto 0);
		Din : in STD_LOGIC_VECTOR (31 downto 0);
		WrEn : in STD_LOGIC;
		Clk : in STD_LOGIC);
end component;
--signal rfwren: STD_LOGIC;
signal Rd, Rs, Rt, MUX1_out : STD_LOGIC_VECTOR (4 downto 0);
signal Opcode, func : STD_LOGIC_VECTOR (5 downto 0);
signal Immedhelp: STD_LOGIC_VECTOR (15 downto 0);
signal MUX2_out,rfaSig,rfbSig: STD_LOGIC_VECTOR (31 downto 0);

begin
	Opcode <= Instr(31 downto 26);
	Rs <= Instr(25 downto 21);
	Rd <= Instr(20 downto 16);
	Rt <= Instr(15 downto 11);
	Immedhelp <= Instr(15 downto 0);
	func <= Instr(5 downto 0);
--		process (rfaSig, rfbSig, Instr, RF_B_sel, rfwren, ALU_out, MEM_out, RF_WrData_sel, Clk, MUX1_out, MUX2_out)
--		begin
--		--if (clk'event and clk='1') then
--			if (RF_B_sel='0') then
--				MUX1_out <= Rt;
--			else
--				MUX1_out <= Rd;
--			end if;
--			if (RF_WrData_sel='1') then
--				MUX2_out <= MEM_out;
--			else 
--				MUX2_out <= ALU_out;
--			end if;
--			if (Opcode="110000" or Opcode="111000" or Opcode="000011" or Opcode="000111"or Opcode="001111"or Opcode="011111") then
--				if (Immedhelp(15)='0') then   --signextend
--					Immed <= "0000000000000000" & Immedhelp;
--				else
--					Immed <= "1111111111111111" & Immedhelp;
--				end if;
--			elsif (Opcode="111100" or Opcode="111110") then
--				Immed <= "0000000000000000" & Immedhelp;
--			elsif (Opcode="111111" or Opcode="000000" or Opcode="000001") then
--				if (Immedhelp(15)='0') then
--					Immed <= "00000000000000" & Immedhelp & "00";
--				else
--					Immed <= "11111111111111" & Immedhelp & "00";
--				end if;
--			end if;
--			--if (Rd="000000") then
--			--	MUX2_out <= "00000000000000000000000000000000";
--		--end if;
--		end process;
		
	Immed<=("0000000000000000" & Immedhelp) WHEN ((Opcode="110000" or Opcode="111000" or Opcode="000011" or Opcode="000111"or Opcode="001111"or Opcode="011111") and (Immedhelp(15)='0')) ELSE
				("1111111111111111" & Immedhelp) WHEN ((Opcode="110000" or Opcode="111000" or Opcode="000011" or Opcode="000111"or Opcode="001111"or Opcode="011111") and (Immedhelp(15)='1')) ELSE
				("0000000000000000" & Immedhelp) WHEN (Opcode="111100" or Opcode="111110")  else
				("00000000000000" & Immedhelp & "00") WHEN ((Opcode="111111" or Opcode="000000" or Opcode="000001") and (Immedhelp(15)='0')) else
				("11111111111111" & Immedhelp & "00") WHEN ((Opcode="111111" or Opcode="000000" or Opcode="000001") and (Immedhelp(15)='1'));
				
	MUX1_out <= Rt WHEN (RF_B_sel='0') else
					Rd WHEN (RF_B_sel='1');
	MUX2_out <= MEM_out WHEN (RF_WrData_sel="01") else
						ALU_out WHEN (RF_WrData_sel="00") else
						Immed	WHEN (RF_WrData_sel="10");
	--rfwren<=RF_WrEn;
	
	RegFile : top_level
	Port Map(
			Adr1 => Rs,
			Adr2 => MUX1_out,
			Awr => Rd,
			Dout1 => rfaSig,
			Dout2 => rfbSig,
			Din => MUX2_out,
			WrEn => RF_WrEn,
			Clk => Clk
	);
	RF_A<=rfaSig;
	RF_B<=rfbSig;
end Behavioral;