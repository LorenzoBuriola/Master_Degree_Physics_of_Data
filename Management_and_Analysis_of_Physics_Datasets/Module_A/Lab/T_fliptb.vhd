library IEEE;
use IEEE.std_logic_1164.all;

entity tff_tb is
end entity tff_tb;

architecture tb of tff_tb is

    signal clk : std_logic := '1';
    signal t : std_logic;
    signal qout : std_logic;
    signal q : std_logic;
    
begin
    
    DUT : entity work.tff
        port map(
            clk => clk,
            t => t,
            qout => qout
        );

    clk <= not clk after 1 ns;
    
    wavegen : process
        variable count : integer := 0;
    begin
        wait until falling_edge(clk);
        count := count + 1;
        if count <= 50 then
            t <= '0';
        else
            t <= '1';
        end if;
        if count = 100 then
            count :=0;
        end if;
    end process wavegen;

end architecture tb;       