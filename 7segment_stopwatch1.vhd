
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.12.2016 20:42:39
-- Design Name: 
-- Module Name: stopwatch - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity stopwatch is
    Port ( clk : in STD_LOGIC; --clk 100MHz
           seg : out STD_LOGIC_VECTOR(6 downto 0);
           an  : out STD_LOGIC_VECTOR(3 downto 0));
end stopwatch;

architecture Behavioral of stopwatch is

type stopwatch_type is array (5 downto 0) of integer range 0 to 9;
signal stopwatch : stopwatch_type := (0,0,0,0,0,0);
signal clk400hz : STD_LOGIC := '0';
signal clk100hz : STD_LOGIC := '0';


function int2sevenseg(i : integer range 0 to 9) return STD_LOGIC_VECTOR is
begin
     case i is
        when 0 => return "1000000";
        when 1 => return "1111001";
        when 2 => return "0100100";
        when 3 => return "0110000";
        when 4 => return "0011001";
        when 5 => return "0010010";
        when 6 => return "0000010";
        when 7 => return "1111000";
        when 8 => return "0000000";
        when 9 => return "0010000";
        when others => return "1111111";
     end case;
end int2sevenseg;

function inc_clock(stopwatch : stopwatch_type) return stopwatch_type is
begin
    if(stopwatch(0)/=9) then
        return stopwatch(5 downto 1) & (stopwatch(0)+1);
    elsif(stopwatch(1)/=9) then
        return stopwatch(5 downto 2) & (stopwatch(1)+1) & 0;
    elsif(stopwatch(2)/=9) then
        return stopwatch(5 downto 3) & (stopwatch(2)+1) & (0,0);
    elsif(stopwatch(3)/=5) then
        return stopwatch(5 downto 4) & (stopwatch(3)+1) & (0,0,0);
    else
        return stopwatch(5 downto 4) & (0,0,0,0);
    end if;
end inc_clock;

function dispnum2vect(dispnum : integer range 0 to 3) return STD_LOGIC_VECTOR is
variable result : STD_LOGIC_VECTOR(3 downto 0) := (others=>'1');
begin
   result(dispnum):='0';
   return result;
end dispnum2vect;

begin

    clk400hz_proc: process(clk)
    variable cnt : integer range 0 to 250000 :=0;
    variable displayed_num : integer range 0 to 3 :=0;
    begin
        if(rising_edge(clk)) then
          cnt:=cnt+1;
          if(cnt=250000) then
             cnt:=0;
             displayed_num:=displayed_num+1;             
             an<=dispnum2vect(displayed_num);            
             seg<=int2sevenseg(stopwatch(displayed_num));
             if(displayed_num=0) then
                stopwatch<=inc_clock(stopwatch);
             end if;
          end if;
        end if;
    end process;
    
    
    
end Behavioral;
