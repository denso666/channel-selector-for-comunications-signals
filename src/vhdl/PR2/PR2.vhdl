library ieee;
use ieee.std_logic_1164.all;

entity PR2 is
generic(SN: integer := 16);
port(
    DIN : in std_logic_vector(SN-1 downto 0);
    DOUT: out std_logic_vector(2*SN-1 downto 0)
);
end entity;

architecture behavior of PR2 is
    --------------------------------------------------
    --                  COMPONENTS
    --------------------------------------------------
    component SQUARE is
    generic(n: integer := 16);
    port(
    	A: in std_logic_vector(n-1 downto 0);
    	R: out std_logic_vector((2*n-1) downto 0)
    );
    end component;

    component ADDER is
    generic(n: integer := 32);
    port(
    	A, B: in std_logic_vector(n-1 downto 0);
    	R: out std_logic_vector(n-1 downto 0)
    );
    end component;

    component COUNTER is
    port(
    	S_IN	: in std_logic;
    	S_OUT	: out std_logic
    );
    end component;

    component REG is
    generic(n: integer := 32);
    port(
    	DIN : in std_logic_vector(n-1 downto 0);
    	RST : in std_logic;
    	DOUT: out std_logic_vector(n-1 downto 0)
    );
    end component;

    component MUX is
    generic(n: integer := 16);
    port(
    	A, B: in std_logic_vector(n-1 downto 0);
    	SEL: in std_logic;
    	R: out std_logic_vector(n-1 downto 0)
    );
    end component;

    --------------------------------------------------
    --                  SIGNALS
    --------------------------------------------------

    signal sqr_out: std_logic_vector((2*SN-1) downto 0);
    signal adder_out: std_logic_vector((2*SN-1) downto 0);
    signal reg_out: std_logic_vector((2*SN-1) downto 0);
    signal ctrl: std_logic;
begin

    u_sqr : SQUARE
    generic map(n => SN)
    port map(
        A => DIN,
        R => sqr_out
    );

    u_adder : ADDER
    generic map(n => SN*2)
    port map(
    	A => sqr_out,
        B => reg_out,
    	R => adder_out
    );

    u_counter : COUNTER
    port map(
    	S_IN => ctrl,  -- Control Bit unknow
    	S_OUT => ctrl
    );

    u_reg : REG
    generic map(n => SN*2)
    port map(
    	DIN => adder_out,
    	RST => ctrl,
    	DOUT => reg_out
    );

    u_mux : MUX
    generic map(n => SN*2)
    port map(
    	A => reg_out,
        B => (others=>'X'),
    	SEL => ctrl,
    	R => DOUT
    );

end architecture;
