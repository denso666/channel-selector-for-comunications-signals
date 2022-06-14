library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SQUARE is
generic(n: integer := 16);
port(
	A: in std_logic_vector(n-1 downto 0);
	R: out std_logic_vector((2*n-1) downto 0)
);
end entity;

architecture behavior of SQUARE is begin

	R <= std_logic_vector(resize(signed(A) * signed(A), 2*n));

end architecture;