--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:18:45 03/12/2014
-- Design Name:   
-- Module Name:   C:/organwsh2014/erg2/testDECSTAGE.vhd
-- Project Name:  erg2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DECSTAGE
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testDECSTAGE IS
END testDECSTAGE;
 
ARCHITECTURE behavior OF testDECSTAGE IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : in STD_LOGIC_VECTOR (1 downto 0);
         RF_B_sel : IN  std_logic;
         Clk : IN  std_logic;
         Immed : inout  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
   signal RF_B_sel : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          Clk => Clk,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk_period*10;
         Instr(15 downto 0) <= (others=>'0');  --1i 200
			Instr(31 downto 26) <="110000";
         RF_WrEn<='0';
         ALU_out <=(others=>'0');
         MEM_out <=(others=>'0');
         RF_WrData_sel <="00";
         RF_B_sel <='0';
			wait for 20 ns;
         Instr(15 downto 0) <= (15=>'1', others=>'0');  --2i 220
			Instr(31 downto 26) <="000011";
			wait for 20 ns;
		Instr(15 downto 0) <= (others=>'1');  --3i 240
			Instr(31 downto 26) <="111100";
						wait for 20 ns;
         Instr(15 downto 0) <= (others=>'1');  --4i 260
			Instr(31 downto 26) <="000000";
						wait for 20 ns;			 --5i 280  
						Instr(15 downto 11) <= "00001";
						Instr(25 downto 21) <= "10000";
         Instr(20 downto 16) <= "01000"; 
			 RF_WrEn<='1';
         ALU_out <=(2=>'1', others=>'0');			--din
         MEM_out <=(1=>'1', others=>'0');			--din
         RF_WrData_sel <="01";						
         RF_B_sel <='0';
			wait for 20 ns;         --6i 300
        	Instr(15 downto 11) <= "00001";	--rt
			Instr(25 downto 21) <= "10000";	--rs
         Instr(20 downto 16) <= "01000";  --  awr (edw omws einai to rd)		  
		  RF_WrEn<='0';         
         ALU_out <=(2=>'1', others=>'0');			--din
         MEM_out <=(1=>'1', others=>'0');			--din
         RF_WrData_sel <="00";
         RF_B_sel <='1';
			wait for 20 ns; --7i 320
			RF_WrEn<='0';
			Instr(25 downto 21) <= "01000";			       
        -- RF_WrEn<='0';
        -- ALU_out <=(others=>'0');
         --MEM_out <=(others=>'0');
         RF_WrData_sel <="00";
         RF_B_sel <='1';
			wait for 20 ns;		--8i 340  
			 Instr(15 downto 0) <= (others=>'1');
			Instr(15 downto 11) <= "00001";
			Instr(25 downto 21) <= "10000";
         Instr(20 downto 16) <= "11010";  -- awr
			 RF_WrEn<='1';
         ALU_out <=(2=>'1', others=>'0');			--din
         MEM_out <=(1=>'1', others=>'0');			--din
         RF_WrData_sel <="10";						
         RF_B_sel <='0';
			wait for 20 ns;         --9i 360
			Instr(15 downto 0) <= (others=>'0');
        	Instr(15 downto 11) <= "00001";
			Instr(25 downto 21) <= "11010";
         Instr(20 downto 16) <= "01000";  --  awr		  
		  RF_WrEn<='0';         
         ALU_out <=(2=>'1', others=>'0');			--din
         MEM_out <=(1=>'1', others=>'0');			--din
         RF_WrData_sel <="10";
         RF_B_sel <='1';

      -- insert stimulus here 

      wait;
   end process;

END;
