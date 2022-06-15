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

	process is begin
		wait until rising_edge(S_IN);
		if C = "11101" then
			C <= "00000";
			S_OUT <= '1';
		else
			C <= C + "00001";
			S_OUT <= '0';
		end if;
		
		wait on S_IN;
	end process;

end architecture;