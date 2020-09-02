library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity control1 is
Port ( instr : in STD_LOGIC_VECTOR (31 downto 0);
		reset : in STD_LOGIC;
		clk : in STD_LOGIC;
		zero : in STD_LOGIC;
		pcsel : out STD_LOGIC;
		pclden : out STD_LOGIC;
		rfbsel : out STD_LOGIC;
		rfwren : out STD_LOGIC;
		rfwrdatasel : out STD_LOGIC_VECTOR (1 downto 0);
		alubinsel : out STD_LOGIC;
		alufunc : out STD_LOGIC_VECTOR (3 downto 0);
		memwren : out STD_LOGIC;
		memdinsel : out STD_LOGIC;
		memdoutsel : out STD_LOGIC);
end control1;

architecture Behavioral of control1 is

signal func : STD_LOGIC_VECTOR (5 downto 0);
signal Opcode : STD_LOGIC_VECTOR (5 downto 0);
signal Rd,Rs : STD_LOGIC_VECTOR (3 downto 0);
signal Immed_temp : STD_LOGIC_VECTOR (11 downto 0);

TYPE state IS (stfsm0,stfsm1,stfsm1B,stfsm1C,stfsm1D,stfsm2B,stfsm3B,stfsm3C,stfsm4B,stfsm4C,stfsm4D,stfsm5B,stfsm6B,stfsm7B,stfsm7C,stfsm8B,stfsm8C,stfsm9B,stfsm9C,stfsm10B,stfsm11B,stfsm11C,stfsm12B );
SIGNAL stage: state ;

begin
Opcode <= Instr(31 downto 26);
Rd <= Instr(25 downto 22);
Rs <= Instr(21 downto 18);
Immed_temp <= Instr(17 downto 6);
func <= Instr(5 downto 0);

process (clk,reset)
begin
	if (reset='1') then
		pcsel<='0';
		pclden <='0';
		memdinsel<='0';
		memdoutsel<='0';
		rfbsel<='0';
		rfwren<='0';
		rfwrdatasel<="00";
		alubinsel<='0';
		alufunc<="0000";
		memwren<='0';
		stage<=stfsm0;
	elsif (clk'event and clk='1') then
		case stage is
			when stfsm0 =>
				stage<=stfsm1;
			when stfsm1 =>
				if (Opcode="100000") then  --alu
						rfbsel<='0';
						rfwren<='0';
						stage <= stfsm1B;
				elsif (Opcode="111111") then   --b
					rfwren<='0';
					memwren<='0';
					pcsel<='1';
					pclden<='1';
					stage <= stfsm2B;
				elsif (Opcode="110000") then   --li
					rfwren<='0';
					stage <= stfsm3B;
				elsif (Opcode="111000") then  --addi
					rfwren<='0';
					stage <= stfsm4B;
				elsif (Opcode="111100") then	--andi
					rfwren<='0';
					stage <= stfsm5B;
				elsif (Opcode="111110") then	--ori
					rfwren<='0';
					stage<= stfsm6B; 	
				elsif (Opcode="000000") then		--beq
					rfbsel<='1';
					rfwren<='0';
					stage <= stfsm7B; 
				elsif (Opcode="000001") then		--bneq
					rfbsel<='1';
					rfwren<='0';
					stage <= stfsm8B; 
				elsif (Opcode="000111") then		--sb
					rfwren<='0';
					memdinsel<='1';
					memwren<='1';
					stage <= stfsm9B; 
				elsif (Opcode="000011") then		--lb
					rfwren<='1';
					rfwrdatasel <="01";
					memdoutsel<='1';
					memwren<='0';
					pclden <='1';
					pcsel <='0';
					stage <= stfsm10B; 
				elsif (Opcode="011111") then		--sw
					rfwren<='0';
					memdinsel<='0';
					memwren<='1';
					stage <= stfsm11B; 
				elsif (Opcode="001111") then		--lw
					rfwren<='1';
					rfwrdatasel <="01";
					memdoutsel<='0';
					memwren<='0';
					pclden <='1';
					pcsel <='0';
					stage <= stfsm12B; 
				end if;	
			when stfsm1B =>  --alu
				case 	(instr(4 downto 1)) is
					when "1111" =>  alufunc<="1111";
					when "0111" =>  alufunc<="0111";
					when "0011" =>  alufunc<="0011";
					when "0001" =>  alufunc<="0001";
					when "0000" =>  alufunc<="0000";
					when "1000" =>  alufunc<="1000";
					when "1100" =>  alufunc<="1100";
					when "1110" =>  alufunc<="1110";
					when "0101" =>  alufunc<="0101";
					when others =>	stage <= stfsm0;
				end case;
					alubinsel<='0';	
					stage<=stfsm1C;							
			when stfsm1C =>   --alu
				rfwren <='1';
				rfwrdatasel <="00";
				pclden <='1';
				pcsel <='0';
				stage <= stfsm1D;			
			when stfsm1D =>  --alu
				pclden<='0';
				rfwren<='0';
				stage <= stfsm0;	
			when stfsm2B =>		--b
				pclden <='0';
				stage <= stfsm0;	
			when stfsm3B =>   --li
				rfwren <='1';
				rfwrdatasel <="10";
				pclden <='1';
				pcsel <='0';
				stage <= stfsm3C;
			when stfsm3C=>   --li
				pclden<='0';
				rfwren<='0';
				stage <= stfsm0;
			when stfsm4B =>  --addi
				alubinsel <='1';
				alufunc<= "1111";
					stage<=stfsm4C;
			when stfsm4C =>  --addi
				rfwren <='1';
				rfwrdatasel <="00";
				pclden <='1';
				pcsel <='0';
				stage<=stfsm4D;
			when stfsm4D =>  --addi
				rfwren <='0';
				pclden <='0';
				stage<=stfsm0;
			when stfsm5B=>		--andi
				alubinsel <='1';
				alufunc<= "0011";
				stage<=stfsm4C;
			when stfsm6B=>		--ori
				alubinsel <='1';
				alufunc<= "0000";
				stage<=stfsm4C;
			when stfsm7B =>	--beq
				alubinsel<='0';
				alufunc <= "0111";
				stage <= stfsm7C;
			when stfsm7C =>
				if(zero='1') then
					rfwren<='0';
					memwren<='0';
					pcsel<='1';
					pclden<='1';
				else
					rfwren<='0';
					memwren<='0';
					pcsel<='0';
					pclden<='1';				
				end if;
				stage <= stfsm2B;
			when stfsm8B =>			--bneq
				alubinsel<='0';
				alufunc <= "0111";
				stage <= stfsm8C;
			when stfsm8C =>
				if(zero='0') then
					rfwren<='0';
					memwren<='0';
					pcsel<='1';
					pclden<='1';
				else
					rfwren<='0';
					memwren<='0';
					pcsel<='0';
					pclden<='1';				
				end if;
				stage <= stfsm2B;
			when stfsm9B =>		--sb
					memdinsel<='0';
					memwren<='0';
					pclden<='1';
					pcsel<='0';
					stage<=stfsm9C;
			when stfsm9C=>
					pclden<='0';
					stage<=stfsm0;
			when stfsm10B=>	--lb
					rfwren<='0';
					memdoutsel<='0';
					pclden <='0';
					stage <= stfsm0; 
			when stfsm11B =>		--sw
					memwren<='0';
					pclden<='1';
					pcsel<='0';
					stage<=stfsm11C;
			when stfsm11C=>
					pclden<='0';
					stage<=stfsm0;
			when stfsm12B=>	--lw
					rfwren<='0';
					pclden <='0';
					stage <= stfsm0; 
			when others =>
				stage <= stfsm0;
		end case;
	end if;
end process;

end Behavioral;