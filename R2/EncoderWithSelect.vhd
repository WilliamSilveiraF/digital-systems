library ieee;
use ieee.std_logic_1164.all;

entity EncoderWithSelect is
	port(
		in00: in std_logic_vector(3 downto 0);
		dataout: out std_logic_vector(1 downto 0));
end entity;

architecture behv of EncodeWithSelect is
begin
	process(in00)
	begin

			"11" when "1000",
			"10" when "0100",
			"01" when "0010",
			"00" when "0001";
	end process;
end architecture;