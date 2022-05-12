library ieee;
use ieee.std_logic_1164.all;

entity Mux4x1NBits is
    generic(n: positive := 8);
    port (
        --control
        sel: in std_logic_vector(1 downto 0);

        --uhul
        in00, in01, in10, in11: in std_logic_vector(n-1 downto 0);
        dataout: out std_logic_vector(n-1 downto 0)
    );
end entity;

architecture behv of Mux4x1NBits is
begin
    dataout <=  in00 when (sel="00") else
                in01 when (sel="01") else
                in10 when (sel="10") else
                in11 when (sel="11") else
                (others => '0');
end architecture;