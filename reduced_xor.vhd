library ieee;
use ieee.std_logic_1164.all;

entity reduced_xor is
	generic(n: positive := 8);
	port (
		in00: in std_logic_vector(n-1 downto 0);
		dataout: out std_logic_vector(n-1 downto 0));
end entity;

architecture behv of reduced_xor is
	signal tmp: std_logic_vector(n-1 downto 0);
begin
	tmp(0) <= in00(0);
	process(in00, tmp)
	begin
		for idx in 1 to (n-1) loop
			tmp(idx) <= in00(idx) xor tmp(idx);
		end loop;
	end process;
end architecture;