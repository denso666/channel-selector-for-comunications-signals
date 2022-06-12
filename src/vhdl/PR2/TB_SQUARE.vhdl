-- TIME=40ns
library ieee;
use ieee.std_logic_1164.all;

entity TB_SQUARE is end entity;

architecture behavior of TB_SQUARE is

	component SQUARE is
	generic(n: integer := 16);
	port(
		A: in std_logic_vector(n-1 downto 0);
		R: out std_logic_vector((2*n)-1 downto 0)
	);
	end component;

	signal a: std_logic_vector(15 downto 0);
	signal r: std_logic_vector(31 downto 0);

begin

	uut: SQUARE
	generic map(n => 16)
	port map(
		A 	=> a,
		R 	=> r
	);

	Stimuli: process begin
	
		a <= x"0002";
		wait for 10 ns;

		a <= x"0004";
		wait for 10 ns;

		a <= x"0008";
		wait for 10 ns;

		a <= x"0011";
		wait for 10 ns;

	end process;

end architecture;