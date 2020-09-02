--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:17:43 03/12/2014
-- Design Name:   
-- Module Name:   C:/organwsh2014/erg2/testMEMSTAGE.vhd
-- Project Name:  erg2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEMSTAGE
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
 
ENTITY testMEMSTAGE IS
END testMEMSTAGE;
 
ARCHITECTURE behavior OF testMEMSTAGE IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
    PORT(
         Clk : IN  std_logic;
         MEM_WrEn : IN  std_logic;
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal MEM_WrEn : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          Clk => Clk,
          MEM_WrEn => MEM_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut
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
         MEM_WrEn <='0';
         ALU_MEM_Addr<=(4=>'1',others=>'0');
         MEM_DataIn <=(1=>'1',others=>'0');
wait for 20 ns;
         MEM_WrEn <='1';
         ALU_MEM_Addr<=(4=>'1',others=>'0');
         MEM_DataIn <=(1=>'1',others=>'0');
wait for 20 ns;
         MEM_WrEn <='1';
         ALU_MEM_Addr<=(2=>'1',others=>'0');
         MEM_DataIn <=(8=>'1',others=>'0');
wait for 20 ns;
         MEM_WrEn <='0';
         ALU_MEM_Addr<=(4=>'1',others=>'0');
         MEM_DataIn <=(7=>'1',others=>'0');
wait for 20 ns;
         MEM_WrEn <='1';
         ALU_MEM_Addr<=(6=>'1',others=>'0');
         MEM_DataIn <=(9=>'1',others=>'0');
wait for 20 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
