library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

entity ModuleCounter is
	generic(
		module: integer := 60;
		resetValue: integer := 0);
	port (
		--control
		clk, reset, load, enb: in std_logic;
		--data
		in00: in unsigned(integer(ceil(log2(real(module))))-1 downto 0);
		dataout: out unsigned(integer(ceil(log2(real(module))))-1 downto 0));
end entity;

architecture behv of ModuleCounter is
	subtype State is unsigned(integer(ceil(log2(real(module))))-1 downto 0);
	signal currentState, nextState: State;
begin
	-- nextState logic
	nextState <= 	unsigned(in00) when load='1' else 
						currentState when enb='0' else
						to_unsigned(0, currentState'length) when currentState=module-1 else currentState+ 1;

	-- internal state logic
	process(reset, clk)
	begin
		if (reset='1') then
			currentState <= to_unsigned(resetValue, currentState'length);
		elsif (rising_edge(clk)) then
			currentState <= nextState;
		end if;
	end process;

	-- output logic
	dataout <= std_logic_vector(currentState);
end architecture;