-- TIME=unknow
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_REG is end entity;

architecture behavior of TB_REG is

    component PR2 is
    generic(SN: integer := 16);
    port(
        DIN : in std_logic_vector(SN-1 downto 0);
        DOUT: out std_logic_vector(2*SN-1 downto 0)
    );
    end component;

	signal din: std_logic_vector(15 downto 0);
    signal dout: std_logic_vector(31 downto 0);

begin

	uut: PR2
	generic map(SN => 16)
	port map(
		DIN		=> din,
		DOUT 	=> dout
	);


	Stimuli: process
		variable temp: unsigned(15 downto 0) := x"0001";
    begin
		for i in 0 to 25 loop
			--	REAL PROCESS
			din <= std_logic_vector(temp);
			wait for 20 ns;

			-- SHIFT LEFT 1 BIT
			temp := temp sll 1;
		end loop;
	end process;

end architecture;
