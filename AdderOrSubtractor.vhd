library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AdderOrSubtractor is
    generic(n: integer := 8);
    port(
        --control
        clk, rst, enable, load, inc: in std_logic;

        --uhul
        in0: in std_logic_vector(n-1 downto 0);
        outp: out std_logic_vector(n-1 downto 0)
    );
end entity;

architecture behv of AdderOrSubtractor is
    subtype State is unsigned(n-1 downto 0);
    signal nextState, currentState: State;
    signal operator: integer;
begin
    operator <= 1 when inc = '1' else -1;

    -- next state logic
    nextState <=    unsigned(in0) when load = '1' else
                    currentState when enable = '0' else
                    currentState + operator
    
    -- internal state logic
    process(clk, rst)
    begin
        if reset = '1' then
            currentState <= (others => '0');
        elsif rising_edge(clk) then
            currentState <= nextState;
        end if;
    end process;

    -- output logic
    outp <= std_logic_vector(currentState);
end architecture;