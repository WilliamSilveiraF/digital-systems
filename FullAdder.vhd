library ieee;
use ieee.std_logic_1164.all;
entity FullAdder is
    port( 
        Cin, X, Y : in std_logic;
        sum, Cout : out std_logic
    );
end entity;

architecture behv of FullAdder is
begin
    sum <= (X xor Y) xor Cin;
    Cout <= (X and (Y or Cin)) or (Cin and Y);
end architecture;
