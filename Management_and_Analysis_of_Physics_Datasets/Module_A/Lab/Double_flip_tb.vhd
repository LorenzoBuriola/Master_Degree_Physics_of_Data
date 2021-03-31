library IEEE;
use IEEE.std_logic_1164.all;

entity Double_flip_tb is
end entity Double_flip_tb;

architecture tb of Double_flip_tb is

    signal clk : std_logic := '1';
    signal d : std_logic;
    signal q : std_logic;
    
begin

    DUT : entity work.Double_flip
        port map(
            clk => clk,
            d => d,
            q => q
        );

    clk <= not clk after 1 ns;
    
    wavegen: process
    begin
        d <= '0';
        wait for 3 ns;
        d <= '1';
        wait for 6 ns;
        d <= '0';
        wait for 6 ns;
        d <= '1';
        wait for 5 ns;          
    end process wavegen;
    
end architecture tb;