
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity compare_module is
    Port ( write_comp : in  STD_LOGIC;
				Awr_comp : in  STD_LOGIC_VECTOR (4 downto 0);
           addr_comp : in  STD_LOGIC_VECTOR (4 downto 0);
           din_comp : in  STD_LOGIC_VECTOR (31 downto 0);
           data_reg : in  STD_LOGIC_VECTOR (31 downto 0);
           dout_comp : out  STD_LOGIC_VECTOR (31 downto 0));
end compare_module;

architecture Behavioral of compare_module is
 signal dout_comp_s : STD_LOGIC_VECTOR (31 downto 0);
begin
	process(addr_comp,dout_comp_s,din_comp,Awr_comp,write_comp,data_reg)
	begin
	if (addr_comp="00000") then
		dout_comp_s<=(OTHERS=>'0');
	elsif ( ((addr_comp=Awr_comp) and (write_comp='1'))) then
		
	     dout_comp_s<= din_comp; 
	 else
				 dout_comp_s<=data_reg;
	end if;

	end process;
		
dout_comp<=dout_comp_s;

end Behavioral;

