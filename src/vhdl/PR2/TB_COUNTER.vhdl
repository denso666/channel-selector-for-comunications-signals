-- TIME=600ns
library ieee;
use ieee.std_logic_1164.all;

entity TB_COUNTER is end entity;

architecture behavior of TB_COUNTER is

	component COUNTER is
	port(
		S_IN	: in std_logic;
		S_OUT	: out std_logic
	);
	end component;
	signal s_in : std_logic := '0';
	signal s_out: std_logic;

begin

	uut: COUNTER port map(
		S_IN 	=> s_in,
		S_OUT 	=> s_out
	);

	Stimuli: process begin
		
		for I in 1 to 60 loop
			S_IN <= not S_IN;
			wait for 10 ns;
		end loop;

	end process;

end architecture;