--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:14:52 10/02/2019
-- Design Name:   
-- Module Name:   C:/Users/dnolan5/CS2022/Project1a/registerTestBench.vhd
-- Project Name:  Project1a
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: register
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY registerTestBench IS
END registerTestBench;
 
ARCHITECTURE behavior OF registerTestBench IS 
 
    COMPONENT register
    PORT(
         D : IN  std_logic_vector(15 downto 0);
         load : IN  std_logic;
         clk : IN  std_logic;
         Q : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   signal D : std_logic_vector(15 downto 0) := (others => '0');
   signal load : std_logic := '0';
   signal clk : std_logic := '0';

   signal Q : std_logic_vector(15 downto 0);

   constant clk_period : time := 10 ns;
 
BEGIN
 
   uut: register PORT MAP (
          D => D,
          load => load,
          clk => clk,
          Q => Q
        );

   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

   stim_proc: process
   begin		
		wait for 10ns;
		D <= x"FFFF";
		load <= '1';
		
		wait for 10ns;
		load <= '0';
		
		wait for 10ns;
		D <= x"AAAA";
		load <= '1';
		
		wait for 10ns;
		load <= '0';
   end process;

END;
