
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( Adr1 : in  STD_LOGIC_VECTOR (4 downto 0);
			  Adr2 : in  STD_LOGIC_VECTOR (4 downto 0);
			  Awr : in  STD_LOGIC_VECTOR (4 downto 0);
			  Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
	        Din : in  STD_LOGIC_VECTOR (31 downto 0);
			  WrEn : in  STD_LOGIC;
	        Clk : in  STD_LOGIC );
end top_level;

architecture Behavioral of top_level is

component register_32bit is
    Port ( clock : in  STD_LOGIC;
           we : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (31 downto 0);
           data_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


component decoder is
    Port ( addr_wr : in  STD_LOGIC_VECTOR (4 downto 0);
           addr_wr_out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component wrEn_module is
    Port ( writeEnable : in  STD_LOGIC;
           regDec : in  STD_LOGIC;
           writeReg : out  STD_LOGIC);
end component;

component mux is
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
end component;

component compare_module is
    Port ( write_comp : in  STD_LOGIC;
				Awr_comp : in  STD_LOGIC_VECTOR (4 downto 0);
           addr_comp : in  STD_LOGIC_VECTOR (4 downto 0);
           din_comp : in  STD_LOGIC_VECTOR (31 downto 0);
           data_reg : in  STD_LOGIC_VECTOR (31 downto 0);
           dout_comp : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


signal data0, data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15, data16, data17, data18, data19, data20, data21, data22, data23, data24, data25, data26, data27, data28, data29, data30, data31 : STD_LOGIC_VECTOR (31 downto 0);

signal data1_sig , data2_sig, d2_final_out, d1_final_out : STD_LOGIC_VECTOR (31 downto 0);

signal en_wr : STD_LOGIC_VECTOR (31 downto 0);
signal en_r: STD_LOGIC_VECTOR (31 downto 0);


begin


	dec: decoder 
	port map(addr_wr => Awr,
            addr_wr_out => en_wr);

	Generate_label:
	FOR i IN 0 TO 31 GENERATE
		wrAND: wrEn_module PORT MAP ( writeEnable=> WrEn,
												regDec=>en_wr(i),
												writeReg=>en_r(i) ) ;
	END GENERATE ;



   reg0 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(0),
              data => Din,
              data_out => data0);

   reg1 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(1),
              data => Din,
              data_out => data1);

   reg2 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(2),
              data => Din,
              data_out => data2);

   reg3 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(3),
              data => Din,
              data_out => data3);

   reg4 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(4),
              data => Din,
              data_out => data4);

   reg5 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(5),
              data => Din,
              data_out => data5);

   reg6 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(6),
              data => Din,
              data_out => data6);

   reg7 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(7),
              data => Din,
              data_out => data7);

   reg8 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(8),
              data => Din,
              data_out => data8);

   reg9 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(9),
              data => Din,
              data_out => data9);

   reg10 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(10),
              data => Din,
              data_out => data10);

   reg11 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(11),
              data => Din,
              data_out => data11);

   reg12 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(12),
              data => Din,
              data_out => data12);

   reg13 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(13),
              data => Din,
              data_out => data13);

   reg14 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(14),
              data => Din,
              data_out => data14);

   reg15 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(15),
              data => Din,
              data_out => data15);

   reg16 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(16),
              data => Din,
              data_out => data16);

   reg17 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(17),
              data => Din,
              data_out => data17);

   reg18 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(18),
              data => Din,
              data_out => data18);

   reg19 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(19),
              data => Din,
              data_out => data19);

   reg20 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(20),
              data => Din,
              data_out => data20);

   reg21 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(21),
              data => Din,
              data_out => data21);

   reg22 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(22),
              data => Din,
              data_out => data22);

   reg23 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(23),
              data => Din,
              data_out => data23);

   reg24 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(24),
              data => Din,
              data_out => data24);

   reg25 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(25),
              data => Din,
              data_out => data25);

   reg26 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(26),
              data => Din,
              data_out => data26);

   reg27 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(27),
              data => Din,
              data_out => data27);


   reg28 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(28),
              data => Din,
              data_out => data28);

   reg29 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(29),
              data => Din,
              data_out => data29);

   reg30 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(30),
              data => Din,
              data_out => data30);

   reg31 : register_32bit 
    Port map( clock => clk  ,
				  we => en_r(31),
              data => Din,
              data_out => data31);



	muxUP: mux 
	port map(reg0 => data0,
           reg1 => data1,
           reg2 => data2,
           reg3 => data3,
           reg4 => data4,
           reg5 => data5,
           reg6 => data6,
           reg7 => data7,
           reg8 => data8,
           reg9 => data9,
           reg10 => data10,
           reg11 => data11,
           reg12 => data12,
           reg13 => data13,
           reg14 => data14,
           reg15 => data15,
           reg16 => data16,
           reg17 => data17,
           reg18 => data18,
           reg19 => data19,
           reg20 => data20,
           reg21 => data21,
           reg22 => data22,
           reg23 => data23,
           reg24 => data24,
           reg25 => data25,
           reg26 => data26,
           reg27 => data27,
           reg28 => data28,
           reg29 => data29,
           reg30 => data30,
           reg31 => data31,
           address => Adr1,
           out_data => data1_sig);

	muxDOWN: mux 
	port map(reg0 => data0,
           reg1 => data1,
           reg2 => data2,
           reg3 => data3,
           reg4 => data4,
           reg5 => data5,
           reg6 => data6,
           reg7 => data7,
           reg8 => data8,
           reg9 => data9,
           reg10 => data10,
           reg11 => data11,
           reg12 => data12,
           reg13 => data13,
           reg14 => data14,
           reg15 => data15,
           reg16 => data16,
           reg17 => data17,
           reg18 => data18,
           reg19 => data19,
           reg20 => data20,
           reg21 => data21,
           reg22 => data22,
           reg23 => data23,
           reg24 => data24,
           reg25 => data25,
           reg26 => data26,
           reg27 => data27,
           reg28 => data28,
           reg29 => data29,
           reg30 => data30,
           reg31 => data31,
           address => Adr2,
           out_data => data2_sig);
comp1: compare_module
Port map ( write_comp => WrEn,
				Awr_comp => awr,
           addr_comp => adr1,
           din_comp => din,
           data_reg => data1_sig,
           dout_comp => d1_final_out);
comp2: compare_module
Port map ( write_comp => WrEn,
				Awr_comp => awr,
           addr_comp => adr2,
           din_comp => din,
           data_reg => data2_sig,
           dout_comp => d2_final_out);

dout1<= d1_final_out;
dout2<= d2_final_out;

end Behavioral;

