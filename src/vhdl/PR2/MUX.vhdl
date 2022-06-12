library ieee;
use ieee.std_logic_1164.all;

entity MUX is
generic(n: integer := 16);
port (
	A: in std_logic_vector(n-1 downto 0);
	SEL: in std_logic;
	R: out std_logic_vector(n-1 downto 0)
);
end entity MUX;

architecture behavior of MUX is begin
	
	with SEL select
		R <= A when '1',
		  	 (others => 'X') when others;

end architecture behavior;