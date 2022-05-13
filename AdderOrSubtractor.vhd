library ieee;
use ieee.std_logic_1164.all;

entity AdderOrSubtractor is
    generic(
        n: positive := 8;
        isAdder: boolean := false;
        isSubtractor: boolean := true
    );
    port( 
        operator: in std_logic;
        in0, in1: in std_logic_vector(n-1 downto 0);
        dataout: out std_logic_vector(n-1 downto 0);
        overflow, cout : out std_logic
    );
end entity;

architecture behv of AdderOrSubtractor is
    component FullAdder is
        port (
            Cin, X, Y : in std_logic;
            sum, Cout : out std_logic
        );
    end component;
    signal carry: std_logic_vector(n downto 0);
    signal handleIn1: std_logic_vector(n-1 downto 0);
begin
    assert (isAdder or isSubtractor) report "There must be at least one operator equal to true" severity error;

    loopBit: for idx in dataout'range generate
        fa: FullAdder port map(carry(idx), in0(idx), handleIn1(idx), dataout(idx), carry(idx+1));
    end generate;

    handleAdder: if isAdder and not isSubtractor generate
        carry(0) <= '0';
        handleIn1 <= in1;
    end generate;

    handleSubtractor: if not isAdder and isSubtractor generate
        carry(0) <= '1';
        handleIn1 <= not in1;
    end generate;

    handleBoth: if isAdder and isSubtractor generate
        carry(0) <= operator;
        handleIn1 <= in1 when operator = '0' else not in1;
    end generate;
    
    cout <= carry(n);
    overflow <= carry(n) xor carry(n-1);
end architecture;