library IEEE;
use IEEE.std_logic_1164.all;
entity Double_flip is
    port (
        clk : in std_logic;
        d : in std_logic;
        q : out std_logic
    );
end entity Double_flip;

architecture rtl of Double_flip is
    component dff is
        port (
            clk : in std_logic;
            d : in std_logic;
            q : out std_logic 
        );
    end component dff;
    signal internal : std_logic;
begin
    D1_flip : dff
    port map(
        clk => clk,
        d => d,
        q => internal
    );
    D2_flip : dff
    port map(
        clk => clk,
        d => internal,
        q => q
    );   
end architecture rtl;