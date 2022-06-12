-- TIME=unknow
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_REG is end entity;

architecture behavior of TB_REG is

	component REG is
	generic(n: integer := 32);
	port(
		DIN : in std_logic_vector(n-1 downto 0);
		RST : in std_logic;
		DOUT: out std_logic_vector(n-1 downto 0)
	);
	end component;

	signal din, dout: std_logic_vector(31 downto 0);
	signal rst: std_logic;

begin

	uut: REG
	generic map(n => 32)
	port map(
		DIN		=> din,
		RST 	=> rst,
		DOUT 	=> dout
	);


	Stimuli: process
		variable temp: unsigned(31 downto 0) := x"00000001";
	begin
		
		--	INITIALIZE
		rst <= '1';
		wait for 20 ns;
		rst <= '0';

		for i in 0 to 25 loop
			--	REAL PROCESS
			din <= std_logic_vector(temp);
			wait for 20 ns;

			-- SHIFT LEFT 1 BIT
			temp := temp sll 1;

			-- RESET
			if i = 10 then
				rst <= '1';
				wait for 20 ns;
				rst <= '0';
			end if ;
		end loop;

	end process;

end architecture;