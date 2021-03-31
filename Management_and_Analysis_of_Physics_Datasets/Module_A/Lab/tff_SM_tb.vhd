library IEEE;
use IEEE.std_logic_1164.all;

entity tff_SM_tb is
end entity tff_SM_tb; 

architecture tb of tff_SM_tb is

    signal TOG_EN : std_logic;
    signal CLK : std_logic := '1';
    signal CLR : std_logic;
    signal Z1 : std_logic;
    
begin

    DUT : entity work.my_fsm1
        port map(
            CLK => CLK,
            TOG_EN => TOG_EN,
            CLR => CLR,
            Z1 => Z1 
        );

    CLK <= not CLK after 1 ns;  
    
    wavegen: process
    begin
        CLR <= '1';
        wait for 4 ns;
        CLR <= '0';
        TOG_EN <= '0';
        wait for 8 ns;
        TOG_EN <= '1';
        wait for 20 ns;        
    end process wavegen;
    
end architecture tb;
