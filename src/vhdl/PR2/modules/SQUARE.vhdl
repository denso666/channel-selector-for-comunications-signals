library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MULTIPLIER is
generic(n: integer := 16);
port(
	A, B: in std_logic_vector(n-1 downto 0);
	R: out std_logic_vector((2*n-1) downto 0)
);
end entity;

architecture behavior of MULTIPLIER is begin

	R <= std_logic_vector(resize(signed(A) * signed(B), 2*n));

end architecture;