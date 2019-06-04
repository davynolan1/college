--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:56:42 10/02/2019
-- Design Name:   
-- Module Name:   C:/Users/dnolan5/CS2022/Project1a/mux816TestBench.vhd
-- Project Name:  Project1a
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux816
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
 
ENTITY mux816TestBench IS
END mux816TestBench;
 
ARCHITECTURE behavior OF mux816TestBench IS 
 
    COMPONENT mux816
    PORT(
         s0 : IN  std_logic;
         s1 : IN  std_logic;
         s2 : IN  std_logic;
         in0 : IN  std_logic_vector(15 downto 0);
         in1 : IN  std_logic_vector(15 downto 0);
         in2 : IN  std_logic_vector(15 downto 0);
         in3 : IN  std_logic_vector(15 downto 0);
         in4 : IN  std_logic_vector(15 downto 0);
         in5 : IN  std_logic_vector(15 downto 0);
         in6 : IN  std_logic_vector(15 downto 0);
         in7 : IN  std_logic_vector(15 downto 0);
         z : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   signal s0 : std_logic := '0';
   signal s1 : std_logic := '0';
   signal s2 : std_logic := '0';
   signal in0 : std_logic_vector(15 downto 0) := (others => '0');
   signal in1 : std_logic_vector(15 downto 0) := (others => '0');
   signal in2 : std_logic_vector(15 downto 0) := (others => '0');
   signal in3 : std_logic_vector(15 downto 0) := (others => '0');
   signal in4 : std_logic_vector(15 downto 0) := (others => '0');
   signal in5 : std_logic_vector(15 downto 0) := (others => '0');
   signal in6 : std_logic_vector(15 downto 0) := (others => '0');
   signal in7 : std_logic_vector(15 downto 0) := (others => '0');

   signal z : std_logic_vector(15 downto 0);
 
BEGIN

   uut: mux816 PORT MAP (
          s0 => s0,
          s1 => s1,
          s2 => s2,
          in0 => in0,
          in1 => in1,
          in2 => in2,
          in3 => in3,
          in4 => in4,
          in5 => in5,
          in6 => in6,
          in7 => in7,
          z => z
        );

   stim_proc: process
   begin		
		in0 <= x"FFFF";
		in1 <= x"CCCC";
		in2 <= x"DDDD";
		in3 <= x"CCCC";
		in4 <= x"BBBB";
		in5 <= x"AAAA";
		in6 <= x"9999";
		in7 <= x"8888";
		
		wait for 10ns;
		s0 <= '1';
		s1 <= '0';
		s2 <= '0';
		
		wait for 10ns;
		s0 <= '0';
		s1 <= '1';
		s2 <= '0';
		
		wait for 10ns;
		s0 <= '1';
		s1 <= '1';
		s2 <= '0';
		
		wait for 10ns;
		s0 <= '0';
		s1 <= '0';
		s2 <= '1';
		
		wait for 10ns;
		s0 <= '1';
		s1 <= '0';
		s2 <= '1';
		
		wait for 10ns;
		s0 <= '0';
		s1 <= '1';
		s2 <= '1';
		
		wait for 10ns;
		s0 <= '1';
		s1 <= '1';
		s2 <= '1';
   end process;

END;
