library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity baudrate_tb is
end entity baudrate_tb;

architecture tb of baudrate_tb is
    signal clk : std_logic := '1';
    signal bau_out : std_logic;
begin

    DUT : entity work.baudrate
        port map
        (
            clk => clk,
            bau_out => bau_out
        );
    
    clk <= not clk after 1 ns;

    wavegen : process
    begin
        wait;
    end process wavegen;

end architecture tb;