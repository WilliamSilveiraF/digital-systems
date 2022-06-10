library ieee;
use ieee.std_logic_1164.all;

entity Decoder is
	port (
		in00: in std_logic_vector(1 downto 0);
		dataout: out std_logic_vector(3 downto 0));
end entity;

architecture behv of Decoder is
begin
	process(in00)
	begin
		case in00 is
			when "11" =>
				dataout <= "1000";
			when "10" =>
				dataout <= "0100";
			when "01" =>
				dataout <= "0010";
			when others =>
				dataout <= "0001";
		end case;
	end process;
end architecture;