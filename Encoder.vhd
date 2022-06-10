library ieee;
use ieee.std_logic_1164.all;

entity Encoder is
	port (
		in00: in std_logic_vector(3 downto 0);
		dataout: out std_logic_vector(1 downto 0));
end entity;

architecture behv of Encoder is
begin
	process(in00)
	begin
		case in00 is
			when "1000" =>
				dataout <= "11";
			when "0100" =>
				dataout <= "10";
			when "0010" =>
				dataout <= "01";
			when others =>
				dataout <= "00";
		end case;
	end process;
end architecture;