library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity ModuleCounterEnbInc is
	generic(
		module: positive := 60;
		resetValue: integer := 0;
		thereIsEnable: boolean := true;
		thereIsIncDec: boolean := true);
	port(
		clk, rst, enb, inc, load: in std_logic;
		in00: in std_logic_vector(integer(ceil(log2(real(module))))-1 downto 0);
		dataout: out std_logic_vector(integer(ceil(log2(real(module))))-1 downto 0));
end entity;

architecture behv of ModuleCounterEnbInc is
	subtype state is unsigned(integer(ceil(log2(real(module))))-1 downto 0);
	signal currentState, nextState: state;
begin
	-- nextState logic
	handleThereIsEnable: if thereIsEnable and thereIsIncDec generate
		nextState <= 	unsigned(in00) when load='1' else
						currentState when enb='0' else
						to_unsigned(0, nextState'length) when (currentState=module-1) and (inc='1') else
						to_unsigned(module-1, nextState'length) when (currentState=0) and (inc='0') else
						currentState-1 when (inc='0') else currentState+1;
	end generate;

	-- internal logic
	process(clk, rst)
	begin
		if (rst='1') then
			currentState <= to_unsigned(resetValue, currentState'length);
		elsif (rising_edge(clk)) then
			currentState <= nextState;
		end if;
	end process;
	
	dataout <= std_logic_vector(currentState);
end architecture;