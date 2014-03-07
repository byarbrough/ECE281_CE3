----------------------------------------------------------------------------------
-- Company: USAFA/DFEC
-- Engineer: Silva & Yarbrough
-- 
-- Create Date:    10:33:47 07/07/2012 
-- Design Name: 
-- Module Name:    MealyElevatorController Silva - Behavioral 
-- Project Name: 		CE3
-- Target Devices: 	Simulation
-- Tool versions: 
-- Description: 	Mealy Elevator Control
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MealyElevatorController is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           up_down : in  STD_LOGIC;
           floor : out  STD_LOGIC_VECTOR (3 downto 0);
			  nextfloor : out std_logic_vector (3 downto 0));
end MealyElevatorController;

architecture Behavioral of MealyElevatorController is

type floor_state_type is (floor1, floor2, floor3, floor4);

signal floor_state, nextfloor_state : floor_state_type;

begin

---------------------------------------------------------
-- Mealy machine next-state process ----
---------------------------------------------------------
floor_state_machine: process(clk)
begin
--only change on rising edge
	if rising_edge(clk) then
		--reset is active high and will return the elevator to floor1
		if reset='1' then
			floor_state <= floor1;
		else -- define next state
			case floor_state is
				if stop='0' then --elevator is stopped
					--stay at current floor
					nextfloor_state <= floor_state;
				
				elsif up_down='0' then --elevator is going down
					nextfloor_state <= floor_state;
				
				elsif up_down='1' then --elevator is giong up
					nextfloor_state <= floor_state;
				
				else --account for mysterious cases
					nextfloor_state <= floor1;
				end if;
			--phantom states
			when others =>
				floor_state <= floor1;
			end case;
		end if;
	end if;
end process;

-----------------------------------------------------------
--Code your Ouput Logic for your Mealy machine below
--Remember, now you have 2 outputs (floor and nextfloor)
-----------------------------------------------------------
floor <= "0001" when ( floor_state = floor1 ) else
			"0010" when ( floor_state = floor2 ) else
			"0011" when ( floor_state = floor3 ) else
			"0100" when ( floor_state = floor4 ) else
			"0001";
nextfloor <= "0001" when ( nextfloor_state = floor1 ) else
			"0010" when ( nextfloor_state = floor2 ) else
			"0011" when ( nextfloor_state = floor3 ) else
			"0100" when ( nextfloor_state = floor4 ) else
			"0001";

end Behavioral;

