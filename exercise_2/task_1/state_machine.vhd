library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity state_machine is
    Port ( clk : in  STD_LOGIC;
	        rst : in  STD_LOGIC;
           btn : in  STD_LOGIC_VECTOR (2 downto 0);
           led : out  STD_LOGIC_VECTOR (2 downto 0));
end state_machine;

architecture Behavioral of state_machine is
	type StateT is (st0, st1, st2, st3);
	signal state : StateT := st0;
	signal state_next : StateT;
begin
	clocked_process : process(clk)
	begin
		if rising_edge(clk) then
			state <= state_next;
		end if;
	end process;
	
	state_machine : process(state, btn, rst)
	begin
		state_next <= state;
		if rst = '1' then
			state_next <= st0;
		elsif btn = "001" then
			state_next <= st1;
		elsif btn = "010" then
			state_next <= st2;
		elsif btn = "100" then
			state_next <= st3;
		end if;
	end process;
	
	with state select
		led <= "000" when st0,
		       "001" when st1,
				 "010" when st2,
				 "100" when st3,
				 "111" when others;
end Behavioral;

