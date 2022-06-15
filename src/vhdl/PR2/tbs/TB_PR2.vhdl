-- TIME=unknow
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_PR2 is end entity;

architecture behavior of TB_PR2 is

    component PR2 is
    generic(SN: integer := 16);
    port(
        super_DIN : in std_logic_vector(SN-1 downto 0);
        super_FLAG: in std_logic;
        super_DOUT: out std_logic_vector(2*SN-1 downto 0)
    );
    end component;

    signal flag: std_logic := '0';
	signal din: std_logic_vector(15 downto 0);
    signal dout: std_logic_vector(31 downto 0);

begin

	dut: PR2
	generic map(SN => 16)
	port map(
		super_DIN	=> din,
		super_FLAG	=> flag,
		super_DOUT 	=> dout
	);
	flag <= not flag after 5 ns;

	process begin

		for i in 0 to 60 loop
			din <= x"0001";
			wait for 10 ns;
		end loop;

	end process;

end architecture;
