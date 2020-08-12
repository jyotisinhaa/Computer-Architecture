library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std.all;
use work.all;
entity Project2 is
 port( sw: in std_logic_vector(3 downto 0);
       seg: out std_logic_vector(6 downto 0);
       btnL: in std_logic;
       btnU: in std_logic;
       btnD: in std_logic;
       btnR: in std_logic;
       btnC: in  std_logic;
       led:out std_logic_vector(15 downto 0);
       an: out std_logic_vector(3 downto 0);
      clock_100Mhz: in std_logic;   
       disp_point: out std_logic
       );
       
end Project2;

architecture Behavioral of Project2 is

signal player1: std_logic_vector(15 downto 0);
signal player2: std_logic_vector(15 downto 0):="0000000000000000";
signal d0: std_logic_vector(3 downto 0):="0000";
signal d1: std_logic_vector(3 downto 0):="0000";
signal d2: std_logic_vector(3 downto 0):="0000";
signal d3: std_logic_vector(3 downto 0):="0000";

signal xyz: integer :=0;
signal state:integer:=1;
signal tries_count:integer:=0;
signal slow_clock: std_logic ;


begin
div: entity work.clock port map(clock_100mhz=>clock_100mhz,slow_clock=>slow_clock);

p1:process(slow_clock,sw,btnL,btnU,btnD,btnR,btnC)

begin
if rising_edge(slow_clock) then

if state = 1 then
--show PL 1 on screen
    case xyz is
        when 0=> seg <= "1111001"; an <= "1110"; xyz <= xyz + 1; -- 1 
        when 1=> seg <= "0111111"; an <= "1101"; xyz <= xyz + 1;-- -
        when 2=> seg <= "1000111"; an <= "1011"; xyz <= xyz + 1;-- L
        when 3=> seg <= "0001100"; an <= "0111"; xyz <= 0;-- P
        when others=>null;
    end case;
end if;    
if (btnL = '1') then --If Left button is high  then only value of switch will come in the d0
d0<=sw(3 downto 0);
end if;
if (btnU = '1') then --If Upper button is high  then only value of switch will come in the d1
d1<=sw(3 downto 0);
end if;
if (btnD = '1') then --If Down button is high  then only value of switch will come in the d2
d2<=sw(3 downto 0);
end if;
if (btnR = '1') then --If Right button is high  then only value of switch will come in the d3
d3<=sw(3 downto 0);
end if;


if (btnC = '1') then
  if (state =1)then
    Player1(3 downto 0)<= d0;
    Player1(7 downto 4)<=d1;
    Player1(11 downto 8)<=d2;
    Player1(15 downto 12)<=d3;
  state<=2;  
  elsif tries_count=5 then 
  state<=7;
  elsif state = 2 or state =3 or state =4 or state=5 or state=6 then
    tries_count <=tries_count + 1;
    
    player2(3 downto 0)<= d0;
    player2(7 downto 4)<=d1;
    player2(11 downto 8)<=d2;
    player2(15 downto 12)<=d3;
    
      if player2 < player1 then
         state<=3;   --2 LO
      elsif player2 > player1 then
         state<=4;   --2 High
       else 
          state<=5;   --WIN
      
       end if;
end if;

elsif state = 2 then
--show PL 2 on screen
    case xyz is
        when 0=> seg <= "0100100"; an <= "1110"; xyz <= xyz + 1; -- 2 
        when 1=> seg <= "0111111"; an <= "1101"; xyz <= xyz + 1;-- -
        when 2=> seg <= "1000111"; an <= "1011"; xyz <= xyz + 1;-- L
        when 3=> seg <= "0001100"; an <= "0111"; xyz <= 0;-- P
        when others=>null;
    end case;
state<=6;
elsif state = 3 then
---show 2 LO on screen
case xyz is
    when 0=> seg <= "1000000"; an <= "1110"; xyz <= xyz + 1; -- o 
    when 1=> seg <= "1000111"; an <= "1101"; xyz <= xyz + 1;-- -l
    when 2=> seg <= "1111111"; an <= "1011"; xyz <= xyz + 1;-- space
    when 3=> seg <= "0100100"; an <= "0111"; xyz <= 0;-- 2
    when others=>null;
end case;

state<=6;
elsif state = 4 then
--show 2 HI on screen
case xyz is
    when 0=> seg <= "1001111"; an <= "1110"; xyz <= xyz + 1; -- i 
    when 1=> seg <= "0001001"; an <= "1101"; xyz <= xyz + 1;-- -h
    when 2=> seg <= "1111111"; an <= "1011"; xyz <= xyz + 1;-- space
    when 3=> seg <= "0100100"; an <= "0111"; xyz <= 0;-- 2
    when others=>null;
end case;
state<=6;

elsif state = 5 then 
-----Win state-------
led<= "0000000000000000";
case xyz is
    
    when 0=> 
    an<="1110";
        case tries_count is
        when 1=>
        seg<="1111001";
       
        when 2=>
        seg<="0100100";
        
        when 3=>
        seg<="0110000";
           
        when 4=>
        seg<="0011001";
        
        when 5=>
        seg<="0010010";
        when others => null;
        end case;
      xyz<= xyz+1;
 
   when 1=> 
    an<="1101";
    seg<= "1111111";
    xyz<= xyz+1;
   
   when 2=> 
    an<="1011";
    seg<= "1111111";
    xyz<= xyz+1;
   
   when 3=> 
    an<="0111";
    seg<= "1111111";
    xyz<= 0;
when others =>null;
end case;
elsif state = 6 then
 ---Display to seven segment
case xyz is
    
    when 0=> 
   
    an<="1110";
    case d0 is
    when "0000" => seg<="1000000";
    when "0001" => seg<="1111001";
    when "0010" => seg<="0100100";
    when "0011" => seg<="0110000";
    when "0100" => seg<="0011001";
    when "0101" => seg<="0010010";
    when "0110" => seg<="0000010";
    when "0111" => seg<="1111000";
    when "1000" => seg<="0000000";
    when "1001" => seg<="0011000";
    when "1010" => seg<="0001000";
    when "1011" => seg<="0000011";
    when "1100" => seg<="1000110";
    when "1101" => seg<="0100001";
    when "1110" => seg<="0000110";
    when "1111" => seg<="0001110";
    
    when others=>null;
    end case;
    xyz <= xyz + 1; -- (space)
    
    when 1=>
    
    an<="1101";
    
    case d1 is
    when "0000" => seg<="1000000";
    when "0001" => seg<="1111001";
    when "0010" => seg<="0100100";
    when "0011" => seg<="0110000";
    when "0100" => seg<="0011001";
    when "0101" => seg<="0010010";
    when "0110" => seg<="0000010";
    when "0111" => seg<="1111000";
    when "1000" => seg<="0000000";
    when "1001" => seg<="0011000";
    when "1010" => seg<="0001000";
    when "1011" => seg<="0000011";
    when "1100" => seg<="1000110";
    when "1101" => seg<="0100001";
    when "1110" => seg<="0000110";
    when "1111" => seg<="0001110";
    
    when others=>null;
    end case;
    xyz <= xyz + 1;-- Y
    
    when 2=> 
    
    an<="1011";
    case d2 is
    when "0000" => seg<="1000000";
    when "0001" => seg<="1111001";
    when "0010" => seg<="0100100";
    when "0011" => seg<="0110000";
    when "0100" => seg<="0011001";
    when "0101" => seg<="0010010";
    when "0110" => seg<="0000010";
    when "0111" => seg<="1111000";
    when "1000" => seg<="0000000";
    when "1001" => seg<="0011000";
    when "1010" => seg<="0001000";
    when "1011" => seg<="0000011";
    when "1100" => seg<="1000110";
    when "1101" => seg<="0100001";
    when "1110" => seg<="0000110";
    when "1111" => seg<="0001110";
    
    when others=>null;
    end case;
    xyz <= xyz + 1;-- A
    
    when 3=> 
    
    an<="0111";
    
    case d3 is
    when "0000" => seg<="1000000";
    when "0001" => seg<="1111001";
    when "0010" => seg<="0100100";
    when "0011" => seg<="0110000";
    when "0100" => seg<="0011001";
    when "0101" => seg<="0010010";
    when "0110" => seg<="0000010";
    when "0111" => seg<="1111000";
    when "1000" => seg<="0000000";
    when "1001" => seg<="0011000";
    when "1010" => seg<="0001000";
    when "1011" => seg<="0000011";
    when "1100" => seg<="1000110";
    when "1101" => seg<="0100001";
    when "1110" => seg<="0000110";
    when "1111" => seg<="0001110";
    when others=>null;
    end case;
     xyz <= 0;-- Y
    when others=>null;
end case;

elsif state = 7 then
--show Lose on screen and after 3sec the process will be reset
case xyz is
    when 0=> seg <= "0000110"; an <= "1110"; xyz <= xyz + 1; -- E 
    when 1=> seg <= "0010010"; an <= "1101"; xyz <= xyz + 1;-- -S
    when 2=> seg <= "1000000"; an <= "1011"; xyz <= xyz + 1;-- 0
    when 3=> seg <= "1000111"; an <= "0111"; xyz <= 0;-- L
    when others=>null;
    seg<="1111111" after 3sec;
    an<="1111" after 3 sec;
end case;
end if;
--Calculate the number of tries on the seven segment
if tries_count =1 then
disp_point<= '0';
an<="1110";
elsif tries_count=2 then
disp_point<='0';
an<="1100";
elsif tries_count=3 then
disp_point<='0';
an<="1000";
elsif tries_count=4 then
disp_point<='0';
an<="0000";

end if;
end if;
  
end process;
end behavioral;