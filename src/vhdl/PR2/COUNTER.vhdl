library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity COUNTER is
port(
	S_IN	: in std_logic;
	S_OUT	: out std_logic
);
end entity;

architecture behavior of COUNTER is
	signal C: unsigned(4 downto 0) := "00000";
begin

	process( S_IN ) begin

		if C = "11110" then
			C <= "00000";
			S_OUT <= '1';
		else
			C <= C + "00001";
			S_OUT <= '0';
		end if;

	end process;

end architecture;