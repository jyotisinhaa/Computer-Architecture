----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/05/2020 11:17:06 PM
-- Design Name: 
-- Module Name: CAFinal - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CAFinal is
    Port ( Input : in STD_LOGIC_VECTOR (3 downto 0);
           SevensegmentA : out STD_LOGIC;
           SevensegmentB : out STD_LOGIC;
           SevensegmentC : out STD_LOGIC;
           SevensegmentD : out STD_LOGIC;
           SevensegmentE : out STD_LOGIC;
           SevensegmentF : out STD_LOGIC;
           SevensegmentG : out STD_LOGIC;
           Answer : inout std_logic_vector(6 downto 0);
           clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_out : out STD_LOGIC_VECTOR (15 downto 0)
           );
end CAFinal;

architecture Behavioral of CAFinal is

begin
 with Input select Answer <=
      "1111110" when "0000",
      "0110000" when  "0001",--1
      "1101101" when "0010",--2
      "1111001" when "0011", --3
      "0110011" when "0100", --4
      "1011011" when "0101", --5
      "1011111" when "0110", --6       
      "1110000" when "0111", --7
      "1111111" when "1000", --8
      "1111011" when "1001", --9
      "1110111" when "1010", --A
      "0011111" when "1011", --B
      "1001110" when "1100", --C
      "0111101" when "1101", --D
      "1001111" when "1110", --E
      "1000111"  when "1111", --F
      "0000000" when others;
      SevensegmentA <= not  Answer(6);
      SevensegmentB <= not Answer(5);
      SevensegmentC <= not  Answer(4);
      SevensegmentD  <= not Answer(3);
      SevensegmentE  <= not Answer(2);
      SevensegmentF <= not Answer(1);
      SevensegmentG  <= not  Answer(0);
      
        process(clk, reset)
       variable count:STD_LOGIC_VECTOR(15 downto 0):=(others=>'0');
       begin
        
       if reset ='1' then
          count:=(others=>'0');
       elsif enable='1' and clk'event and clk='1' then
          count :=count + 1;
       end if;
       clk_out<=count;
       end process;
end Behavioral;
