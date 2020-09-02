library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity wrEn_module is
    Port ( writeEnable : in  STD_LOGIC;
           regDec : in  STD_LOGIC;
           writeReg : out  STD_LOGIC);
end wrEn_module;

architecture Behavioral of wrEn_module is

signal wrR_sig :STD_LOGIC;

begin
	process(regDec ,writeEnable )
	begin

		wrR_sig<=regDec and writeEnable;

	end process;
writeReg<=wrR_sig;

end Behavioral;

