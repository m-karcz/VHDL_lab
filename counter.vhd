----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2016 19:57:06
-- Design Name: 
-- Module Name: asdf - Behavioral
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
use ieee.numeric_std.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity asdf is
  Port  ( clk : in STD_LOGIC;
            led : inout STD_LOGIC_VECTOR(15 downto 0));
end asdf;

architecture Behavioral of asdf is
    
begin
    my_clk: process(clk)
    variable count : natural range 0 to 45000000;
    begin
        if(rising_edge(clk)) then
            count:=count+1;
            --if(count = 20000000) then
              --  myled<='1';
            if(count = 45000000) then
                count:=0;
                led<=std_logic_vector(unsigned(led)+1);
            end if;
        end if;
    end process;    
end Behavioral;

