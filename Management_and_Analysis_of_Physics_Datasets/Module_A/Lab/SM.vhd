library IEEE;
use IEEE.std_logic_1164.all;

entity RNAstop_detect is
    port (
        a : in std_logic_vector(1 downto 0);
        clk : in std_logic;
        rst : in std_logic;
        y : out std_logic
    );
end entity RNAstop_detect;

architecture rtl of RNAstop_detect is
    type state_t is (S0, S1, S2, S3, Detect);
    signal state : state_t := S0;    
begin
    main: process(clk) is
    begin
        if rising_edge(clk) then      
            if rst = '0' then
                state <= S0;
                y <= '0';
            else
                case state is
                    when S0 =>
                        y <= '0';
                        if a = "11" then
                            state <= S1;
                        end if;
                    when S1 =>
                        y <= '0';
                        if a = "11" then
                            state <= S1;
                        elsif a = "01" then
                            state <= S2;
                        elsif a = "10" then
                            state <= S3;
                        else
                            state <= S0;
                        end if;
                    when S2 =>
                        y <= '0';
                        if a = "01" or a = "10" then
                            state <= Detect;
                        else
                            state  <= S0;
                        end if;
                    when S3 =>
                        if a = "01" then
                            state <= Detect;
                        else 
                            state <= S0;
                        end if;
                    when Detect =>
                        y <= '1';
                        state <= S0;
                    when others => null;
                end case;
            end if;
        end if;
    end process main;
end architecture rtl;
