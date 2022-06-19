library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity ModuleCounterDecor is
	generic(
		module: positive := 60;
		rstValue: integer := 0);
	port(
		clk, enable, load, rst: in std_logic; 
		in00: in std_logic_vector(integer(ceil(log2(real(module))))-1 downto 0);
		dataout: out std_logic_vector(integer(ceil(log2(real(module))))-1 downto 0));
end entity;

architecture behv of ModuleCounterDecor is
	subtype state is unsigned(integer(ceil(log2(real(module))))-1 downto 0);
	signal currentState, nextState: state;
begin
	-- nextState logic
	nextState <= unsigned(in00) when load='1' else
					 currentState when enable='0' else
					 to_unsigned(0, nextState'length) when currentState=module-1 else
					 currentState+1;
	-- internal logic
	process(clk, rst)
	begin
		if (rst='1') then
			currentState <= to_unsigned(rstValue, currentState'length);
		elsif (rising_edge(clk)) then
			currentState <= nextState;
		end if;
	end process;
	
	-- output logic
	dataout <= std_logic_vector(currentState);
end architecture;