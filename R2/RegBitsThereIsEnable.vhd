library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegBitsThereIsEnable is
	generic(
		width: positive := 8;
		resetValue: integer := 0;
		thereIsEnable: boolean := true);
	port (
		clk, reset, enable: in std_logic;
		in00: in std_logic_vector(width-1 downto 0);
		dataout: out std_logic_vector(width-1 downto 0));
end entity;

architecture behv of RegBitsThereIsEnable is
	subtype state is std_logic_vector(width-1 downto 0);
	signal currentState, nextState: state;
begin
	-- next state logic
	flagThereIsEnable: if thereIsEnable generate
		nextState <= in00 when enable='1' else currentState;
	end generate;
	
	flagThereIsntEnable: if not thereIsEnable generate
		nextState <= in00;
	end generate;
	
	-- internal
	process(clk, reset)
	begin
		if (reset = '1') then
			currentState <= std_logic_vector(to_unsigned(resetValue, currentState'length));
		elsif (rising_edge(clk)) then
			currentState <= nextState;
		end if;
	end process;

	-- output logic
	dataout <= currentState;
end architecture;