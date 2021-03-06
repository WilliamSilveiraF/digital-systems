library ieee;
use ieee.std_logic_1164.all;

entity bit_xor is
	generic(n: integer := 8);
	port(
		in00: in std_logic_vector(n-1 downto 0);
		in01: in std_logic_vector(n-1 downto 0);
		dataout: out std_logic_vector(n-1 downto 0));
end entity;

architecture behv of bit_xor is
begin
	process(in00, in01)
	begin
		for idx in n-1 downto 0 loop
			dataout(idx) <= in00(idx) xor in01(idx);
		end loop;
	end process;
end architecture;