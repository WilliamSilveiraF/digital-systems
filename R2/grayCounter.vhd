library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity grayCounter is
    generic(
        width: positive := 8;
        rstValue: integer := 0;
        thereIsEnb: boolean := true);
    port (
        clk, rst, load, enable: in std_logic;
        in00: in std_logic_vector(width-1 downto 0);
        dataout: out std_logic_vector(width-1 downto 0));
end entity;

architecture behv of grayCounter is
    subtype state is unsigned(width-1 downto 0);
    signal currentState, nextState: state;
begin
    -- next state logic
    handleThereIsEnb: if thereIsEnb generate
        nextState <=    unsigned(in00) when load='1' else
                        currentState when enable='0' else
                        currentState+1;
    end generate;
    handleThereIsntEnb: if not thereIsEnb generate
        nextState <=    unsigned(in00) when load='1' else currentState+1;
    end generate;

    -- memory element
    process(clk, rst)
    begin
        if (rst='1') then
            currentState <= to_unsigned(rstValue, currentState'length);
        elsif (rising_edge(clk)) then
            currentState <= nextState;
        end if;
    end process;


    dataout <= std_logic_vector(currentState xor ('0' & currentState(width-1 downto 1)));
end architecture;