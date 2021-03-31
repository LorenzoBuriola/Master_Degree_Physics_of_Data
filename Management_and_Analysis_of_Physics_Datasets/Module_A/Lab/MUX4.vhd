library IEEE;
use IEEE.std_logic_1164.all;
entity mux4 is
    port(
        a1, a2, a3, a4 : in std_logic_vector(2 downto 0);
        sel : in std_logic_vector(1 downto 0);
        b : out std_logic_vector(2 downto 0));
end mux4;

architecture rtl of mux4 is
    component mux2 is
        port (
            a1, a2 : in std_logic_vector(2 downto 0);
            sel : in std_logic;
            b : out std_logic_vector(2 downto 0));
    end component mux2;
    signal muxA_out, muxB_out : std_logic_vector(2 downto 0);
    begin
        muxA : mux2
        port map ( a1 => a1, a2 => a2,
            sel => sel(0),
            b => muxA_out);
        muxB : mux2
        port map ( a1 => a3, a2 => a4,
            sel => sel(0),
            b => muxB_out);
        muxOut : mux2
        port map ( a1 => muxA_out, a2 => muxB_out,
            sel => sel(1),
            b => b);
end rtl;