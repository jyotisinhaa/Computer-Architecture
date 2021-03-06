-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/15/2017 07:09:23 PM
-- Design Name: 
-- Module Name: d_flip_flop - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity d_flip_flop is
    Port ( d : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           q : out STD_LOGIC
           );
end d_flip_flop;

architecture Behavioral of d_flip_flop is
signal temp_out:std_logic:='1';
begin
change: process(clk, rst)
begin

if rst = '1' then
q<='1';
elsif rising_edge(clk) then
--q<=d;
q<= temp_out;
temp_out<=not temp_out;
end if;


end process;
end Behavioral;