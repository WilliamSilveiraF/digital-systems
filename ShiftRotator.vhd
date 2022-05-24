library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ShiftRotator is
	generic(
        n: positive := 8;
        isShifter: boolean := true;
        toleft: boolean := true;
        isLogical: boolean := false
	);
	port (
		in0: in std_logic_vector(7 downto 0);
		out0: out std_logic_vector(7 downto 0));
end entity;

architecture Behv of ShiftRotator is
	begin
        handleShifterLeftLogical: if isShifter and toleft and isLogical generate
            out0 <= std_logic_vector(signed(in0) sll 1);
        end generate;

        handleShifterRightLogical: if isShifter and not toleft and isLogical generate
            out0 <= std_logic_vector(signed(in0) srl 1);
        end generate;

        handleShifterLeftArith: if isShifter and toleft and not isLogical generate
            out0 <= std_logic_vector(SHIFT_LEFT(signed(in0), 1));
        end generate;

        handleShifterRightArith: if isShifter and not toleft and not isLogical generate
            out0 <= std_logic_vector(SHIFT_RIGHT(signed(in0), 1));
        end generate;

		handleRotateLeft: if not isShifter and toleft generate
			out0 <= std_logic_vector(ROTATE_LEFT(signed(in0), 1));
		end generate;
	
		handleRotateRight: if not isShifter and toleft generate
			out0 <= std_logic_vector(ROTATE_RIGHT(signed(in0), 1));
		end generate;
end architecture;