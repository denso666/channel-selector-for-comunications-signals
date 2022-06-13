-- TIME=40ns
library ieee;
use ieee.std_logic_1164.all;

entity TB_ADDER is end entity;

architecture behavior of TB_ADDER is

	component ADDER is
	generic( n: integer := 32 );
	port (
		A, B: in std_logic_vector(n-1 downto 0);
		R: out std_logic_vector(n-1 downto 0)
	);
	end component;

	signal a, b, r : std_logic_vector(31 downto 0);

begin

	uut: ADDER
	generic map(n => 32)
	port map(
		A 	=> a,
		B 	=> b,
		R 	=> r
	);

	Stimuli: process begin
	
		a <= x"00000000";
		b <= x"00000001";
		wait for 10 ns;

		a <= x"00000010";
		b <= x"00001001";
		wait for 10 ns;

		a <= x"00001000";
		b <= x"00000001";
		wait for 10 ns;

		a <= x"00001000";
		b <= x"00000111";
		wait for 10 ns;

	end process;

end architecture;