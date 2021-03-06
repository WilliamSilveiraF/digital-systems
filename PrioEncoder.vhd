library ieee;
use ieee.std_logic_1164.all;

entity PrioEncoder is
	port (
		in00: in std_logic_vector(3 downto 0);
		isActive: out std_logic;
		dataout: out std_logic_vector(1 downto 0));
end entity;

architecture behv of PrioEncoder is
begin
	process(in00)
	begin
		dataout <= "00";
		if (in00(1) = '1') then
			dataout <= "01";
		end if;
		if (in00(2) = '1') then
			dataout <= "10";
		end if;
		if (in00(3) = '1') then
			dataout <= "11";
		end if;
		isActive <= in00(3) or in00(2) or in00(1) or in00(0);
	end process;
end architecture;