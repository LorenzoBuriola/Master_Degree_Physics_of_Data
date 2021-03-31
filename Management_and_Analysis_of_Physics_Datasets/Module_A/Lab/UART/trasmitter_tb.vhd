library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity trasmitter_tb is
end entity trasmitter_tb;

architecture tb of trasmitter_tb is

    signal clk : std_logic := '1';
    signal data : std_logic_vector(7 downto 0);
    signal valid : std_logic;
    signal busy : std_logic;
    signal tx_out : std_logic;

begin

    DUT : entity work.trasmitter
        port map
        (
            clk => clk,
            data => data,
            valid => valid,
            busy => busy,
            tx_out => tx_out
        );

    clk <= not clk after 1 ns;
    
    wavegen : process
    begin
        valid <= '0';
        data <= "11010010";
        wait for 4 ns;
        wait until rising_edge(clk);
        valid <= '1';
        wait until rising_edge(clk);
        valid <= '0';
        wait for 10 us;
        data <= "11111111";
        wait for 10 us;
    end process wavegen;
end architecture tb; 