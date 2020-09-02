
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY simu1b IS
END simu1b;
 
ARCHITECTURE behavior OF simu1b IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_level
    PORT(
         Adr1 : IN  std_logic_vector(4 downto 0);
         Adr2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         Clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Adr1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Adr2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_level PORT MAP (
          adr1 => adr1,
          adr2 => adr2,
          Awr => Awr,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Din => Din,
          WrEn => WrEn,
          Clk => Clk
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
		
		
		 adr1 <= "01000";
		 adr2<="00111";
       Awr <= "00111";
       
		 Din <= (1=>'1', others=>'0');
          WrEn <= '1';
  wait for 20 ns;	
		
		
		 adr1 <= "00000";
		 
       Awr <= "01000";
       
		 Din <= (1=>'1', others=>'0');
          WrEn <= '1';
  wait for 20 ns;			
		
		 adr1 <= "01000";
		 
       Awr <= "00100";
       
		 Din <= (1=>'1', others=>'0');
          WrEn <= '0';
			 wait for 20 ns;			
		
		 adr1 <= "00100";
		 
       Awr <= "11111";
       
		 Din <= (4=>'1', others=>'0');
          WrEn <= '1';
			 wait for 20 ns;			
		
		 adr1 <= "11111";
		 
       Awr <= "00100";
       
		 Din <= (1=>'1', others=>'0');
          WrEn <= '0';
			 			 wait for 20 ns;			
		adr1 <= "00000";
		 adr2 <= "11111";
		 
       Awr <= "00100";
       
		 Din <= (1=>'1', others=>'0');
          WrEn <= '0';
			 wait for 20 ns;			
		
		 adr1 <= "11000";
		 adr2 <= "00000";
       Awr <= "11000";
       
		 Din <= (5=>'1', others=>'0');
          WrEn <= '0';

  wait for 20 ns;	
  		 adr1 <= "11000";
		 adr2 <= "01000";
       Awr <= "00000";
       
		 Din <= (5=>'1', others=>'0');
          WrEn <= '1';
  wait for 20 ns;	
  		 adr1 <= "00000";
		 adr2 <= "01000";
       Awr <= "00100";
       
		 Din <= (5=>'1', others=>'0');
          WrEn <= '0';
  wait for 20 ns;	

      wait;
   end process;

END;
