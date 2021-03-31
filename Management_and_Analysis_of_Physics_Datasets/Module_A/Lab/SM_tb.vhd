library IEEE;
use IEEE.std_logic_1164.all;

entity RNAstop_detect_tb is
end entity RNAstop_detect_tb;

architecture tb of RNAstop_detect_tb is
    signal a : std_logic_vector(1 downto 0);
    signal clk : std_logic := '1';
    signal rst : std_logic;
    signal y : std_logic;
begin
    DUT : entity work.RNAstop_detect
        port map
        (
            a => a,
            clk => clk,
            rst => rst,
            y => y
        );

    clk <= not clk after 1 ns;
    
    wavegen: process
    begin
        a <= "11";
        rst <= '1'; 
        wait for 5 ns; 
        wait until rising_edge(clk);
        rst <= '0'; 
        wait for 7 ns; 
        wait until rising_edge(clk);
        rst <= '1';
        wait until rising_edge(clk);
        a <= "01";
        wait until rising_edge(clk);
        a <= "11";
        wait until rising_edge(clk);
        a <= "11";
        wait until rising_edge(clk);
        a <= "01";
        wait until rising_edge(clk);
        a <= "10";
        wait until rising_edge(clk);
        a <= "11";
        wait until rising_edge(clk);
        a <= "10";
        wait until rising_edge(clk);
        a <= "01";
        wait until rising_edge(clk);
    end process wavegen;
end architecture tb;