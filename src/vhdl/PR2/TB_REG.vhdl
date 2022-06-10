library ieee;
use ieee.std_logic_1164.all;

entity TB_REG is end entity;

architecture behavior of TB_REG is

begin


	Stimuli: process begin
		
		for I in 1 to 60 loop
			S_IN <= not S_IN;
			wait for 10 ns;
		end loop;

	end process;

end architecture;