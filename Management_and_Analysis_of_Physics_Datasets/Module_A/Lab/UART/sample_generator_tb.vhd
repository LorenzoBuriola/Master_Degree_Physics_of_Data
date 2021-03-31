library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sample_generator_tb is
end sample_generator_tb;

architecture tb of sample_generator_tb is

    signal clk : std_logic := '1';
    signal uart_rx : std_logic;
    signal baudrate_out : std_logic;

begin

    DUT : entity work.sample_generator
        port map
        (
            clk => clk,
            uart_rx => uart_rx,
            baudrate_out => baudrate_out
        ); 

    clk <= not clk after 0.5 ns;

    wavegen : process is
    begin
        uart_rx <= '1';
        wait for 600 ns;
        uart_rx <= '0';
        wait for 867 ns;
        uart_rx <= '1';
        wait for 7803 ns;

    end process wavegen;

end architecture tb;

        