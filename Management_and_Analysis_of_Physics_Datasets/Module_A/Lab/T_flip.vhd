library IEEE;
use IEEE.std_logic_1164.all;
entity tff is
    port (
        clk : in std_logic;
        t : in std_logic;
        qout : out std_logic
    );
end entity tff;

architecture rtl of tff is

    signal q : std_logic := '0';
    
begin

    flipflop: process(clk) is
    begin
        if rising_edge(clk) then
            q <= t xor q; 
        end if;        
    end process flipflop;

    qout <= q;
    
end architecture rtl;