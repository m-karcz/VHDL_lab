----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2016 21:10:54
-- Design Name: 
-- Module Name: display - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display is
   Port (clk : in STD_LOGIC;
         sw : in STD_LOGIC_VECTOR(12 downto 0);
         seg : out STD_LOGIC_VECTOR(6 downto 0);
         an : out STD_LOGIC_VECTOR(3 downto 0));
end display;

architecture Behavioral of display is
function int2disp(i : integer range 0 to 9) return STD_LOGIC_VECTOR is
begin
     if i=0 then
        return "1000000";
     elsif i=1 then
        return "1111001";
     elsif i=2 then
        return "0100100";
     elsif i=3 then
        return "0110000";
     elsif i=4 then
        return "0011001";
     elsif i=5 then
        return "0010010";
     elsif i=6 then
        return "0000010";
     elsif i=7 then
        return "1111000";
     elsif i=8 then
        return "0000000";
     else
        return "0010000";
     end if; 
end int2disp;

begin
    prescaler: process(clk)
    variable prsc : integer range 0 to 125000 :=0;
    variable rotate : STD_LOGIC_VECTOR(3 downto 0) := "0001";
    variable value : integer range 0 to 9999 :=0;
    
    procedure make_rotate is
    begin
        rotate:=rotate(2 downto 0) & "1";
        if(rotate="1111") then
            rotate:="1110";
        end if;
        an<=rotate;
    end procedure;
    
    procedure display_num is
    variable i : integer range 0 to 9;
    begin
        if(rotate="1110") then
           i:=value mod 10;
        elsif(rotate="1101") then
           i:=(value/10) mod 10;
        elsif(rotate="1011") then
           i:=(value/100) mod 10;
        else
           i:=value/1000;
        end if;
        seg<=int2disp(i);
    end procedure;
    
    begin
        value:=to_integer(unsigned(sw));
        if(rising_edge(clk)) then
            prsc:=prsc+1;
            if(prsc=125000) then
                make_rotate;
                display_num;
            end if;
        end if;
    end process;
end Behavioral;
