
-----------------------------SEVENSEGMENT CODE----------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CA is
    Port ( B0 : in STD_LOGIC;
           B1 : in STD_LOGIC;
           B2 : in STD_LOGIC;
           B3 : in STD_LOGIC;
           ss_a : out STD_LOGIC;
           ss_b: out STD_LOGIC;
           ss_c: out STD_LOGIC;
           ss_d: out STD_LOGIC;
           ss_e: out STD_LOGIC;
           ss_f: out STD_LOGIC;
           ss_g: out STD_LOGIC);
end CA;

architecture Structural of CA is
begin
ss_a<=not((B1 AND NOT B0)OR ( NOT B0 AND B3)OR(B2 AND B1) OR (NOT B3 AND B1 AND B0) OR (B3 AND NOT B2 AND NOT B1)OR (NOT B2 AND NOT B1 AND NOT B0) OR (NOT B3 AND B2 AND B0));
ss_b<=not((NOT B2 AND NOT B3)OR (NOT B1 AND B0 AND B3) OR (NOT B0 AND NOT B1 AND NOT B3)OR (B1 AND B0 AND NOT B3) OR (B3 AND NOT B2 AND NOT B0));
ss_c<=not((NOT B1 AND B0) OR (NOT B3 AND B2)OR (NOT B2 AND B3) OR (NOT B3 AND NOT B1 AND NOT B0) OR (NOT B3 AND B1 AND B0));
ss_d<=not((NOT B1 AND B3) OR (NOT B2 AND B1 AND B0) OR (NOT B3 AND  NOT B2 AND NOT B0) OR (B1 AND NOT B0 AND B2) OR (NOT B1 AND B0 AND B2));
ss_e<=not((B1 AND NOT B0) OR (B1 AND B3) OR(B3 AND B2 AND NOT B1)OR (NOT B1 AND NOT B0 AND B3) OR (NOT B2 AND NOT B3 AND NOT B0));
ss_f<=not((NOT B1 AND NOT B0) OR (B1 AND B3) OR (B3 AND NOT B2) OR (NOT B3 AND B2 AND NOT B1) OR ( B1 AND NOT B0 AND B2));
ss_g<=not((NOT B0 AND B1) OR (B3 AND NOT B2) OR ( NOT B3 AND B2 AND NOT B1) OR (B0 AND B3) OR (NOT B3 AND NOT B2 AND B1));
end Structural;


--------------------------MUX CODE----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.all; 

entity mux4 is
port(d0,d1,d2,d3,s0,s1: in std_logic;
y :out std_logic);

end mux4;

architecture dataflow of mux4 is
--signal S0,S1: std_logic;
--S0<=clk_div;
--S1<=Q(16);
begin
y <= ((d0 and (not s0) and (not s1)) or (d1 and s1 and (not s0)) or (d2 and (not s1) and s0) or (d3 and s0 and s1));
end dataflow;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux_sup is 
port(Digit0,Digit1,digit2,digit3,digit4,Digit5,Digit6,digit7,digit8,digit9,Digit10,Digit11,digit12,digit13,digit14,digit15: in std_logic;
    S0,s1: in std_logic;
    Mux0_out,Mux1_out,Mux2_out,Mux3_out:out std_logic);
end mux_sup;
architecture Behavioral of  mux_sup is

component dataflow
port(d0,d1,d2,d3,s0,s1: in std_logic;
y :out std_logic);
end component;

for all:dataflow  use entity work.mux4(dataflow);
--signal Mux0_out,Mux1_out,Mux2_out,Mux3_out:std_logic;
--D_store(0)<=Mux0_out;
--D_store(1)<=Mux1_out;
--D_store(2)<=Mux2_out;
--D_store(3)<=Mux3_out;

begin
mux0:dataflow port map(d0=>Digit0,d1=>Digit4,d2=>Digit8,d3=>Digit12,s0=>s0,s1=>s1,y=>Mux0_out);
mux1:dataflow port map(d0=>Digit1,d1=>Digit5,d2=>Digit9,d3=>Digit13,s0=>s0,s1=>s1,y=>Mux1_out);
mux2:dataflow port map(d0=>Digit2,d1=>Digit6,d2=>Digit10,d3=>Digit14,s0=>s0,s1=>s1,y=>Mux2_out);
mux3:dataflow port map(d0=>Digit3,d1=>Digit7,d2=>Digit11,d3=>Digit15,s0=>s0,s1=>s1,y=>Mux3_out);
end Behavioral;








-----------------------------------Clock Code-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity clock is
port(clock_100Mhz:in std_logic;
reset:in std_logic;
enable: in std_logic;
LED_activating_counter: out std_logic_vector(19 downto 0));
end clock;
architecture behave of clock is

--signal refresh_counter: STD_LOGIC_VECTOR (19 downto 0);
-------------------
begin
 process(clock_100mhz, reset)
       variable refresh_counter:STD_LOGIC_VECTOR(19 downto 0):=(others=>'0');
       begin
        
       if (reset ='1') then
          refresh_counter:=(others=>'0');
       elsif enable='1' and clock_100mhz'event and clock_100mhz='1' then
          refresh_counter :=refresh_counter + 1;
       end if;
       LED_activating_counter<=refresh_counter;
       end process;

end Behave;


-------------------------ANODE CODE--------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Anode is
    Port (S1 : in STD_LOGIC;
          S0 : in STD_LOGIC;
           An0 : out STD_LOGIC;
           An1 : out STD_LOGIC;
           An2 : out STD_LOGIC;
           An3 : out STD_LOGIC);
end Anode;

architecture Behavioral of Anode is
begin


An3<=(S0 and S1);
An2<=(S0 and not S1);
An1<=(NOT S0 and S1);
An0<=(not S0 and not S1);


end Behavioral;

---------------------------------top code-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use work.all;
entity all_top is
Port (Slidder0:in std_logic;
Slidder1:in std_logic;
Slidder2:in std_logic;
Slidder3:in std_logic;
Slidder4:in std_logic;
Slidder5:in std_logic;
Slidder6:in std_logic;
Slidder7:in std_logic;
Slidder8:in std_logic;
Slidder9:in std_logic;
Slidder10:in std_logic;
Slidder11:in std_logic;
Slidder12:in std_logic;
Slidder13:in std_logic;
Slidder14:in std_logic;
Slidder15:in std_logic;
Led0:out std_logic;
Led1:out std_logic;
Led2:out std_logic;
Led3:out std_logic;
Led4:out std_logic;
Led5:out std_logic;
Led6:out std_logic;
Led7:out std_logic;
Led8:out std_logic;
Led9:out std_logic;
Led10:out std_logic;
Led11:out std_logic;
Led12:out std_logic;
Led13:out std_logic;
Led14:out std_logic;
Led15:out std_logic;
C0:out std_logic;
C1:out std_logic;
C2:out std_logic;
C3:out std_logic;
C4:out std_logic;
C5:out std_logic;
C6:out std_logic;
An0:out std_logic;
An1:out std_logic;
An2:out std_logic;
An3:out std_logic;
clock_100Mhz : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
PushButton:in std_logic
);
end all_top;

architecture Behavioral of all_top is
--signal Y0: std_logic_vector(3 downto 0);
--signal S0,S1: std_logic;
signal Ai: std_logic;
signal Bi:std_logic;
signal Ci: std_logic;
signal Di: std_logic;
signal s: std_logic_vector(1 downto 0);
signal switch: std_logic_vector(15 downto 0);
signal LED_activating_counter: std_logic_vector(19 downto 0);
COMPONENT mux_sup 
port(Digit0,Digit1,digit2,digit3,digit4,Digit5,Digit6,digit7,digit8,digit9,Digit10,Digit11,digit12,digit13,digit14,digit15:in std_logic;
    S0,s1: in std_logic;
    Mux0_out,Mux1_out,Mux2_out,Mux3_out:out std_logic);
end component;

component CA_top
 Port ( B0 : in STD_LOGIC;
           B1 : in STD_LOGIC;
           B2 : in STD_LOGIC;
           B3 : in STD_LOGIC;
           ss_a : out STD_LOGIC;
           ss_b: out STD_LOGIC;
           ss_c: out STD_LOGIC;
           ss_d: out STD_LOGIC;
           ss_e: out STD_LOGIC;
           ss_f: out STD_LOGIC;
           ss_g: out STD_LOGIC);
end component;

component clk_divider_top
port(clock_100Mhz:in std_logic;
reset:in std_logic;
enable: in std_logic;
LED_activating_counter: out std_logic_vector(19 downto 0));
end component;


component Anode_top
Port ( S1 : in STD_LOGIC;
           S0 : in STD_LOGIC;
           An0 : out STD_LOGIC;
           An1 : out STD_LOGIC;
           An2 : out STD_LOGIC;
           An3 : out STD_LOGIC);
end component;

for all: Mux_sup use entity work.mux_sup(behavioral);
for all: CA_top use entity work.CA(structural);
for all: Anode_top use entity work.Anode(behavioral);
for all:clk_divider_top use entity work.clock(Behave);


begin

Led0<=Slidder0;
Led1<=Slidder1;
Led2<=Slidder2;
Led3<=Slidder3;
Led4<=Slidder4;
Led5<=Slidder5;
Led6<=Slidder6;
Led7<=Slidder7;
Led8<=Slidder8;
Led9<=Slidder9;
Led10<=Slidder10;
Led11<=Slidder11;
Led12<=Slidder12;
Led13<=Slidder13;
Led14<=Slidder14;
Led15<=Slidder15;


 process(clock_100mhz,pushbutton)
    begin 
    if  (clock_100mhz'event and clock_100mhz ='1' and PushButton = '1') then
                  
    l1: switch(0)<=slidder0;
    l2: switch(1)<=slidder1;
    l3: switch(2)<=slidder2;
    l4: switch(3)<=slidder3;
    l5: switch(4)<=slidder4;
    l6: switch(5)<=slidder5;
    l7:switch(6)<=slidder6;
    l8:switch(7)<=slidder7;
    l9:switch(8)<=slidder8;
    l10:switch(9)<=slidder9;
    l11:switch(10)<=slidder10;
    l12:switch(11)<=slidder11;
    l13:switch(12)<=slidder12;
    l14:switch(13)<=slidder13;
    l15:switch(14)<=slidder14;
    l16:switch(15)<=slidder15;

    end if;
end process;

statement1: clk_divider_top port map ( clock_100Mhz=>clock_100mhz,reset=>'0',enable=>'1',LED_activating_counter=>led_activating_counter);
statement2 : mux_sup port map (digit0=>Switch(0),digit1=>Switch(1),digit2=>Switch(2),digit3=>Switch(3),digit4=>Switch(4),digit5=>Switch(5),digit6=>Switch(6),
digit7=>Switch(7),digit8=>Switch(8),digit9=>Switch(9),digit10=>Switch(10),digit11=>Switch(11),digit12=>Switch(12),digit13=>Switch(13),digit14=>Switch(14),digit15=>Switch(15),
    s0=>LED_activating_counter(12),s1=>LED_activating_counter(11),Mux0_out=>Ai,Mux1_out=>Bi,Mux2_out=>Ci,Mux3_out=>Di );
statement3 : CA_top port map (b0=>Ai,b1=>BI,b2=>CI,b3=>DI,ss_a=>C0,ss_b=>C1,ss_c=>C2,ss_d=>C3,ss_e=>C4,ss_f=>C5,ss_g=>C6 ); 
statement4 : anode_top port map (s0=>LED_activating_counter(12),s1=>LED_activating_counter(11),An0=>An0,An1=>An1,An2=>An2,an3=>an3 ); 




end behavioral;




-------------------------Test Bench-----------------------------------
--I used this test bench to check my codes. On the test bench, I am getting the correct output.

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity testbench is
--end testbench;

--architecture test_bench of testbench is
--component all_top is
--Port (Slidder0:in std_logic;
--Slidder1:in std_logic;
--Slidder2:in std_logic;
--Slidder3:in std_logic;
--Slidder4:in std_logic;
--Slidder5:in std_logic;
--Slidder6:in std_logic;
--Slidder7:in std_logic;
--Slidder8:in std_logic;
--Slidder9:in std_logic;
--Slidder10:in std_logic;
--Slidder11:in std_logic;
--Slidder12:in std_logic;
--Slidder13:in std_logic;
--Slidder14:in std_logic;
--Slidder15:in std_logic;
--Led0:out std_logic;
--Led1:out std_logic;
--Led2:out std_logic;
--Led3:out std_logic;
--Led4:out std_logic;
--Led5:out std_logic;
--Led6:out std_logic;
--Led7:out std_logic;
--Led8:out std_logic;
--Led9:out std_logic;
--Led10:out std_logic;
--Led11:out std_logic;
--Led12:out std_logic;
--Led13:out std_logic;
--Led14:out std_logic;
--Led15:out std_logic;
--C0:out std_logic;
--C1:out std_logic;
--C2:out std_logic;
--C3:out std_logic;
--C4:out std_logic;
--C5:out std_logic;
--C6:out std_logic;
--An0:out std_logic;
--An1:out std_logic;
--An2:out std_logic;
--An3:out std_logic;
----clk:in std_logic;
--clock_100Mhz : in STD_LOGIC:='0';-- 100Mhz clock on Basys 3 FPGA board
----reset : in STD_LOGIC; -- reset
--PushButton:in std_logic);
--end component ;

--signal Slidder0: std_logic;
--signal Slidder1: std_logic;
--signal Slidder2: std_logic;
--signal Slidder3: std_logic;
--signal Slidder4: std_logic;
--signal Slidder5: std_logic;
--signal Slidder6: std_logic;
--signal Slidder7: std_logic;
--signal Slidder8: std_logic;
--signal Slidder9: std_logic;
--signal Slidder10: std_logic;
--signal Slidder11: std_logic;
--signal Slidder12: std_logic;
--signal Slidder13: std_logic;
--signal Slidder14: std_logic;
--signal Slidder15: std_logic;
--signal Led0: std_logic;
--signal Led1: std_logic;
--signal Led2: std_logic;
--signal Led3:std_logic;
--signal Led4: std_logic; 
--signal Led5: std_logic;
--signal Led6: std_logic;
--signal Led7: std_logic;
--signal Led8:std_logic;
--signal Led9: std_logic;
--signal Led10: std_logic;
--signal Led11: std_logic;
--signal Led12: std_logic;
--signal Led13:std_logic;
--signal Led14: std_logic;
--signal Led15: std_logic;
--signal C0: std_logic;
--signal C1: std_logic;
--signal C2: std_logic;
--signal C3: std_logic;
--signal C4: std_logic;
--signal C5: std_logic;
--signal C6: std_logic;
--signal An0: std_logic;
--signal An1: std_logic;
--signal An2: std_logic;
--signal An3: std_logic;
----clk:in std_logic;
--signal clock_100Mhz : STD_LOGIC:='0';-- 100Mhz clock on Basys 3 FPGA board
----reset : in STD_LOGIC; -- reset
--signal PushButton: std_logic;
--constant clk_period:time:= 2 ps;
--begin

--uut:all_top port map(Slidder0=>Slidder0,Slidder1=>Slidder1,Slidder2=>Slidder2,
--Slidder3=>Slidder3,Slidder4=>Slidder4,Slidder5=>Slidder5,Slidder6=>Slidder6,Slidder7=>Slidder7,Slidder8=>Slidder8,
--slidder9=>slidder9,Slidder10=>Slidder10,Slidder11=>Slidder11,Slidder12=>Slidder12,Slidder13=>Slidder13,
--Slidder14=>Slidder14,Slidder15=>Slidder15,led0=>led0,led1=>led1,led2=>led2,led3=>led3,
--led4=>led4,led5=>led5,led6=>led6,led7=>led7,led8=>led8,led9=>led9,led10=>led10,
--led11=>led11,led12=>led12,led13=>led13,led14=>led14,led15=>led15,c0=>c0,c1=>c1,c2=>c2,
--c3=>c3,c4=>c4,c5=>c5,c6=>c6,an0=>an0,an1=>an1,an2=>an2,an3=>an3,clock_100mhz=>clock_100mhz,pushbutton=>pushbutton);
--clk_process:process
--begin
--clock_100mhz<='0';
--wait for clk_period/2;
--clock_100mhz<='1';
--wait for clk_period/2;
--end process;

--stim_proc:process
--begin
--slidder0<='0';
--Slidder1<='0';
--Slidder2<='1';
--Slidder3<='0';
--Slidder4<='0';
--Slidder5<='0';
--Slidder6<='0';
--Slidder7<='0';
--slidder8<='0';
--Slidder9<='1';
--Slidder10<='0';
--Slidder11<='0';
--Slidder12<='0';
--Slidder13<='0';
--Slidder14<='0';
--Slidder15<='0';
--pushbutton<='1';
--wait for 2ps;
--slidder0<='0';
--Slidder1<='0';
--Slidder2<='0';
--Slidder3<='0';
--Slidder4<='0';
--Slidder5<='0';
--Slidder6<='0';
--Slidder7<='0';
--slidder8<='0';
--Slidder9<='0';
--Slidder10<='0';
--Slidder11<='0';
--Slidder12<='0';
--Slidder13<='0';
--Slidder14<='0';
--Slidder15<='0';
--pushbutton<= '0';
----q_n <='0';
------rst<='0';
------d<= '0';
----wait for 100 ns;

------rst<='0';
------d<= '0';
----wait for 50 ns;

----rst<='0';
----d<= q_n;
----wait for 100ns;
---- d<= q_n;
---- wait for 100ns;
---- d<= q_n;
---- wait for 100ns;
---- d<= q_n;
---- wait for 100ns;
---- d<= q_n;
--wait;
--end process;
--end;