library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shiftRegister is
    generic(
        width: positive := 8;
        toLeft: boolean := true;
        toRight: boolean := true;
        resetValue: integer := 0);
    port(
        clk, reset, load, enable, op: in std_logic;
        inpFromLeft, inpFromRight: in std_logic;
        outFromLeft, outFromRight: out std_logic;
        in00: in std_logic_vector(width-1 downto 0);
        dataout: out std_logic_vector(width-1 downto 0));
end entity;

architecture behv of shiftRegister is
    subtype state is std_logic_vector(width+1 downto 0);
    signal currentState, nextState: state;
    signal tempNextState: state;
begin
    -- next state logic
    nextState <=    '0'&in00&'0' when load='1' else 
                    currentState when enable='0' else
                    tempNextState;
    handleToLeft: if toLeft and not toRight generate
        tempNextState <= currentState(width downto 1) & inpFromRight & currentState(0);
    end generate;

    handleToRight: if not toLeft and toRight generate
        tempNextState <= currentState(width+1) & inpFromLeft & currentState(width downto 1);
    end generate;

    handleBoth: if toLeft and toRight generate
        tempNextState <=    currentState(width downto 1) & inpFromRight & currentState(0) when op='0' else
                            currentState(width+1) & inFromLeft & currentState(width downto 1);
    end generate;

    -- memory logic
    process(clk, reset)
    begin
        if(reset='1') then
            currentState <= '0'&std_logic_vector(to_signed(resetValue, currentState'length-2))&'0';
        elsif (rising_edge(clk)) then
            currentState <= nextState;
        end if;
    end process;

    -- output logic
    outFromLeft <= currentState(width+1);
    outFromRight <= currentState(0);
    dataout <= currentState(width downto 1);
end architecture;