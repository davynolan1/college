--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:35:12 10/02/2019
-- Design Name:   
-- Module Name:   C:/Users/dnolan5/CS2022/Project1a/decoderTestBench.vhd
-- Project Name:  Project1a
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: registerFile
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
 
ENTITY decoderTestBench IS
END decoderTestBench;
 
ARCHITECTURE behavior OF decoderTestBench IS 
 
    COMPONENT decoder
    PORT(
         a0 : IN  std_logic;
         a1 : IN  std_logic;
         a2 : IN  std_logic;
         q0 : OUT  std_logic;
         q1 : OUT  std_logic;
         q2 : OUT  std_logic;
         q3 : OUT  std_logic;
         q4 : OUT  std_logic;
         q5 : OUT  std_logic;
         q6 : OUT  std_logic;
         q7 : OUT  std_logic
        );
    END COMPONENT;
    
   signal a0 : std_logic := '0';
   signal a1 : std_logic := '0';
   signal a2 : std_logic := '0';

   signal q0 : std_logic;
   signal q1 : std_logic;
   signal q2 : std_logic;
   signal q3 : std_logic;
   signal q4 : std_logic;
   signal q5 : std_logic;
   signal q6 : std_logic;
   signal q7 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN

   uut: decoder PORT MAP (
          a0 => a0,
          a1 => a1,
          a2 => a2,
          q0 => q0,
          q1 => q1,
          q2 => q2,
          q3 => q3,
          q4 => q4,
          q5 => q5,
          q6 => q6,
          q7 => q7
        ); 

   stim_proc: process
   begin		
		--000
		wait for 10ns;
		a0 <= '0';
		a1 <= '0';
		a2 <= '0';
		--001
		wait for 10ns;
		a0 <= '0';
		a1 <= '0';
		a2 <= '1';
		--010
		wait for 10ns;
		a0 <= '0';
		a1 <= '1';
		a2 <= '0';
		--011
		wait for 10ns;
		a0 <= '0';
		a1 <= '1';
		a2 <= '1';
		--100
		wait for 10ns;
		a0 <= '1';
		a1 <= '0';
		a2 <= '0';
		--101
		wait for 10ns;
		a0 <= '1';
		a1 <= '0';
		a2 <= '1';
		--110
		wait for 10ns;
		a0 <= '1';
		a1 <= '1';
		a2 <= '0';
		--111
		wait for 10ns;
		a0 <= '1';
		a1 <= '1';
		a2 <= '1';
   end process;

END;
