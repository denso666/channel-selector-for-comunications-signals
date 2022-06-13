library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADDER is
generic(n: integer := 32);
port(
	A, B: in std_logic_vector(n-1 downto 0);
	R: out std_logic_vector(n-1 downto 0)
);
end entity;

architecture arch of ADDER is begin

	R <= std_logic_vector(signed(A) + signed(B));

end architecture;
