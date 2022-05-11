library ieee;
use ieee.std_logic_1164.all;

entity RegBits is
    generic(n: positive := 8);
    port(
        -- control
        clk, rst, enable: in std_logic;
        
        -- uhul
        D: in std_logic_vector(n-1 downto 0);
        Q: out std_logic_vector(n-1 downto 0)
    );
end entity;

architecture behv of RegBits is
    subtype State is std_logic_vector(n-1 downto 0);
    signal nextState, currentState: State;
begin
    -- next state logic
    nextState <= D when enable = '1' else currentState;

    -- internal state logic
    process(clk, rst)
    begin
        if (rst = '1') then
            currentState <= (others => '0');
        elsif (rising_edge(clk)) then
            currentState <= nextState;
        end if;
    end process;

    -- output logic
    Q <= currentState;
end architecture;