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
    signal operandoIn1: std_logic_vector(n-1 downto 0);
begin
    loopBit: for idx in dataout'range generate
        fa: FullAdder port map(carry(idx), in0(idx), operandoIn1(idx), dataout(idx), carry(idx+1));
    end generate;

    generateAdder: if isAdder and not isSubtractor generate
        carry(0) <= '0';
        operandoIn1 <= in1;
    end generate;

    generateSubtractor: if not isAdder and isSubtractor generate
        carry(0) <= '1';
        operandoIn1 <= not in1;
    end generate;

    generateBoth: if isAdder and isSubtractor generate
        carry(0) <= operator;
        operandoIn1 <= in1 when operator = '0' else not in1;
    end generate;
    
    cout <= carry(n);
    overflow <= carry(n) xor carry(n-1);
end architecture;