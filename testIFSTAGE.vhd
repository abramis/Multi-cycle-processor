--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:33:48 03/12/2014
-- Design Name:   
-- Module Name:   C:/organwsh2014/erg2/testIFSTAGE.vhd
-- Project Name:  erg2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IFSTAGE
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


use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
 
ENTITY testIFSTAGE IS
END testIFSTAGE;
 
ARCHITECTURE behavior OF testIFSTAGE IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFSTAGE
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal Instr : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IFSTAGE PORT MAP (
          PC_Immed => PC_Immed,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          Clk => Clk,
          Instr => Instr
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
      -- insert stimulus here 
         PC_Immed <=(others=>'0');
         PC_sel <='0';
         PC_LdEn<='1';
         Reset<='1';
			wait for 20 ns;
	         PC_Immed <=(0=>'1',others=>'0');
         PC_sel <='0';
         PC_LdEn<='1';
         Reset<='0';
			wait for 20 ns;
	         PC_Immed <=(0=>'1',others=>'0');
         PC_sel <='0';
         PC_LdEn<='1';
         Reset<='0';
			wait for 20 ns;
	         PC_Immed <=(0=>'1',others=>'0');
         PC_sel <='1';
         PC_LdEn<='1';
         Reset<='0';
			wait for 20 ns;
	         PC_Immed <=(others=>'0');
         PC_sel <='0';
         PC_LdEn<='1';
         Reset<='0';
			wait for 20 ns;
         PC_Immed <=(others=>'0');
         PC_sel <='0';
         PC_LdEn<='1';
         Reset<='0';
			wait for 20 ns;
         PC_Immed <=(others=>'0');
         PC_sel <='0';
         PC_LdEn<='1';
         Reset<='0';
			wait for 20 ns;
         PC_Immed <=(others=>'0');
         PC_sel <='0';
         PC_LdEn<='1';
         Reset<='0';
			wait for 20 ns;
         PC_Immed <=(others=>'0');
         PC_sel <='0';
         PC_LdEn<='1';
         Reset<='0';
			wait for 20 ns;
         PC_Immed <=(others=>'0');
         PC_sel <='0';
         PC_LdEn<='1';
         Reset<='0';
			wait for 20 ns;
	

      wait;
   end process;

END;
