library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity receiver_tb is
end entity receiver_tb;

architecture tb of receiver_tb is

    signal clk : std_logic := '1';
    signal uart_rx : std_logic;
    signal data : std_logic_vector(7 downto 0) := (others => '0');
    signal valid : std_logic := '0';
    
begin
    
    DUT : entity work.receiver
        port map
        (
            clk => clk,
            uart_rx => uart_rx,
            data => data,
            valid => valid
        );
    
    clk <= not clk after 0.5 ns;

    wavegen: process is 
    begin
        uart_rx <= '1';
        wait for 800 ns;
        uart_rx <= '0';
        wait for 867 ns;
        uart_rx <= '1';
        wait for 7803 ns;
    end process wavegen;
    
end architecture tb;