library ieee;
use ieee.std_logic_1164.all;

entity GateControl is
	port(
	-- control
		clk, reset: in std_logic;
		--data
		SA, SF, SO, CR: in std_logic;
		MT: out std_logic_vector(1 downto 0));
end entity;

architecture behv of GateControl is
	type State is (IsOpening, IsOpen, IsClosing, IsClosed);
	signal currentState, nextState: State;
begin
	-- nextState logic
	process(currentState, SA, SF, SO, CR)
	begin
		nextState <= currentState;
		case currentState is
			when IsClosed =>
				if (CR='1') then nextState <= IsOpening;
				end if;
			when IsClosing =>
				if (SO='1') then nextState <= IsOpening;
				elsif (SF='1') then nextState <= IsClosed;
				end if;
			when IsOpen =>
				if (CR='1') then nextState <= IsClosing;
				end if;
			when IsOpening =>
				if (SA='1') then nextState <= IsOpen;
				end if;
		end case;
	end process;

	-- internal logic
	process(clk, reset)
	begin
		if	(reset='1') then
			currentState <= IsClosing;
		elsif (rising_edge(clk)) then
			currentState <= nextState;
		end if;
	end process;
	
	-- output logic
	MT <= "00" when currentState=IsOpen else
			"10" when currentState=IsOpening else
			"01" when currentState=IsClosed else
			"11";
end architecture;