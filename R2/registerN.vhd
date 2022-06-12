library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registerN is
	generic(
		width: positive := 8;
		resetValue: integer := 0);
	port(
		clk, reset, load: in std_logic;
		in00: in std_logic_vector(width-1 downto 0);
		dataout: out std_logic_vector(width-1 downto 0));
end entity;

architecture behv of registerN is
	subtype State is std_logic_vector(width-1 downto 0);
	signal currentState, nextState: State;
begin
	-- next state logic
	nextState <= in00 when load='1' else currentState;
	
	--internal state logic
	process(clk, reset)
	begin
		if (reset='1') then
			currentState <= std_logic_vector(to_signed(resetValue, currentState'length));
		elsif (rising_edge(clk)) then
			currentState <= nextState;
		end if;
	end process;

	--output logic
	dataout <= currentState;
end architecture;