library ieee;
use ieee.std_logic_1164.all;

entity dff_tb is
end entity dff_tb;

architecture tb of dff_tb is
    
    signal clk : std_logic := '1';
    signal rst : std_logic;
    signal d : std_logic;
    signal q : std_logic;

begin
    
    DUT : entity work.dff
        port map(
            clk => clk,
            rst => rst,
            d => d,
            q => q
        );

    clk <= not clk after 2 ns;
    
    wavegen : process
    begin
        d <= '1';
        rst <= '0';
        wait for 6 ns;
        rst <= '1';
        wait until rising_edge(clk);
        d <= '0';
        wait until rising_edge(clk);
    end process wavegen;
    
end architecture tb;