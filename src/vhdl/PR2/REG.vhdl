library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity REG is
generic(n: integer := 32);
port(
	DIN : in std_logic_vector(n-1 downto 0);
	RST : in std_logic;
	DOUT: out std_logic_vector(n-1 downto 0)
);
end entity;

architecture behavior of REG is
	signal data: std_logic_vector(n-1 downto 0) := (others=>'0');
begin

	process( DIN, RST ) begin
		if RST = '1' then
			data <= (others=>'0');
		else
			data <= DIN;
		end if;

		DOUT <= data;
	end process;

end architecture;