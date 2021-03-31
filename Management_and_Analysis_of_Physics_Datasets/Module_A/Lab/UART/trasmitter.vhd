library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity trasmitter is
    port(
        clk : in std_logic;
        data : in std_logic_vector(7 downto 0);
        valid : in std_logic;
        busy : out std_logic;
        tx_out : out std_logic
    );
end entity trasmitter;

architecture rtl of trasmitter is
    component baudrate is
        port(
            clk : in std_logic;
            bau_out : out std_logic
        );
    end component baudrate;
   
    type state_t is (IDLE, Data_valid, START, BIT0, BIT1, BIT2, BIT3, BIT4, BIT5, BIT6, BIT7, STOP_t);
    signal state : state_t := IDLE;
    signal bau_in : std_logic;
    signal ascii : std_logic_vector(7 downto 0) := (others => '0');

begin

    baud : baudrate
    port map 
    (
        clk => clk,
        bau_out => bau_in
    );

    main : process(clk) is
    begin
        if rising_edge(clk) then
            case state is
                when IDLE =>
                    tx_out <= '1';
                    busy <= '0';
                    if valid = '1' then
                        state <= Data_valid;
                    end if;
                when Data_valid =>
                    ascii <= data;
                    if bau_in = '1' then
                        state <= START;
                    end if;
                when START =>
                    tx_out <= '0';
                    busy <= '1';
                    if bau_in = '1' then
                        state <= BIT0;
                    end if;
                when BIT0 =>
                    tx_out <= ascii(0);
                    if bau_in = '1' then
                        state <= BIT1;
                    end if;
                when BIT1 =>
                    tx_out <= ascii(1);
                    if bau_in = '1' then
                        state <= BIT2;
                    end if;
                when BIT2 =>
                    tx_out <= ascii(2);
                    if bau_in = '1' then
                        state <= BIT3;
                    end if;
                when BIT3 =>
                    tx_out <= ascii(3);
                    if bau_in = '1' then
                        state <= BIT4;
                    end if;
                when BIT4 =>
                    tx_out <= ascii(4);
                    if bau_in = '1' then
                        state <= BIT5;
                    end if;
                when BIT5 =>
                    tx_out <= ascii(5);
                    if bau_in = '1' then
                        state <= BIT6;
                    end if;
                when BIT6 =>
                    tx_out <= ascii(6);
                    if bau_in = '1' then
                        state <= BIT7;
                    end if;
                when BIT7 =>
                    tx_out <= ascii(7);
                    if bau_in = '1' then
                        state <= STOP_t;
                    end if;
                when STOP_t =>
                    tx_out <= '1';
                    if bau_in = '1' then
                        state <= IDLE;
                    end if;
                when others => null;
            end case;
        end if;
    end process main;

end architecture rtl; 
                    

    