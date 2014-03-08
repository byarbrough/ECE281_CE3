--------------------------------------------------------------------------------
-- Company: 		USAFA DFEC
-- Engineer:		Brian Yarbrough
--
-- Create Date:   16:44:51 03/07/2014
-- Design Name:   Mealy Elevator Control Testbench
-- Module Name:   C:/Users/C16Brian.Yarbrough/Documents/Academics/3dg/CE_Projects/CE3_Yarbrough/Mealy_testbench_Yarbrough.vhd
-- Project Name:  CE3_Yarbrough
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MealyElevatorController
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: This testbench is almost identical to the Moore testbench
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Mealy_testbench_Yarbrough IS
END Mealy_testbench_Yarbrough;
 
ARCHITECTURE behavior OF Mealy_testbench_Yarbrough IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MealyElevatorController
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         stop : IN  std_logic;
         up_down : IN  std_logic;
         floor : OUT  std_logic_vector(3 downto 0);
         nextfloor : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal stop : std_logic := '0';
   signal up_down : std_logic := '0';

 	--Outputs
   signal floor : std_logic_vector(3 downto 0);
   signal nextfloor : std_logic_vector(3 downto 0);
	signal expected_floor : std_logic_vector(3 downto 0):= (others => '0');

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MealyElevatorController PORT MAP (
          clk => clk,
          reset => reset,
          stop => stop,
          up_down => up_down,
          floor => floor,
          nextfloor => nextfloor
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
-- hold reset state.
      wait for 20 ns;	
		
		--floor one
		reset <='1';
		--set expected floor
		expected_floor <= "0001";
		wait for clk_period;
		--check
		assert floor = "0001" report "error on setting to floor1";
		--get rid of reset
		reset<='0';
		--one clk cycle
      wait for clk_period;

		---------------------------------------
		-- test going from floor one to four --
		---------------------------------------
		--loop through all floors
		for f in 0 to 2 loop
			--increment expected floor
			expected_floor <= expected_floor + "0001";
			--go up
			up_down<='1';
			stop<='0';
			--wait a cycle
			wait for clk_period;
			--stop
			stop<='1';
			--wait two cycles
			wait for clk_period*2;
			--check correct floor
			assert floor = expected_floor report "Error going up! Expected " 
				& std_logic'image(expected_floor(3))& std_logic'image(expected_floor(2))& std_logic'image(expected_floor(1))& std_logic'image(expected_floor(0)) & " got " &
				std_logic'image(floor(3))& std_logic'image(floor(2))& std_logic'image(floor(1))& std_logic'image(floor(0));
		end loop;
		
		--------------------------------------------
		-- return to first floow without stopping --
		--------------------------------------------
		--to each floor
		for f in 0 to 2 loop
			--decrement expected floor
			expected_floor <= expected_floor - "0001";
			--go down
			up_down<='0';
			stop<='0';
			--wait a cycle
			wait for clk_period;
			--stop
			stop<='1';
			--wait two cycles
			wait for clk_period*2;
			--check correct floor
			assert floor = expected_floor report "Error going down! Expected " 
				& std_logic'image(expected_floor(3))& std_logic'image(expected_floor(2))& std_logic'image(expected_floor(1))& std_logic'image(expected_floor(0)) & " got " &
				std_logic'image(floor(3))& std_logic'image(floor(2))& std_logic'image(floor(1))& std_logic'image(floor(0));
			end loop;	

      wait;
   end process;

END;
