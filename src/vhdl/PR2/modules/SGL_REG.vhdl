library ieee;
use ieee.std_logic_1164.all;

entity SGL_REG is
generic(n: integer := 16);
port(
	R: out std_logic_vector(n-1 downto 0)
);
end entity;

architecture behavior of SGL_REG is
	signal val: std_logic_vector(n-1 downto 0) := (others=>'0');
begin

	R <= val;

end architecture;