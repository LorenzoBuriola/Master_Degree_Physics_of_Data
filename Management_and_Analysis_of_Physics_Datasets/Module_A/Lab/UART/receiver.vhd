library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity receiver is
    port (
        clk : in std_logic;
        uart_rx : in std_logic;
        data : out std_logic_vector(7 downto 0);
        valid : out std_logic
    );
end entity receiver;

architecture rtl of receiver is
    component sample_generator is
        port
        (
            clk : in std_logic;
            uart_rx : in std_logic;
            baudrate_out : out std_logic  
        );
    end component sample_generator;

    type state_t is (IDLE, BIT0, BIT1, BIT2, BIT3, BIT4, BIT5, BIT6, BIT7, Data_s);
    signal state : state_t := IDLE;
    signal baudrate : std_logic;
    signal ascii : std_logic_vector(7 downto 0);
    
begin
    
    sg : sample_generator
    port map
    (
        clk => clk,
        uart_rx => uart_rx,
        baudrate_out => baudrate
    );

    main : process(clk) is
    begin
        if rising_edge(clk) then
            case state is
                when IDLE =>
                    valid <= '0';
                    ascii <= (others => '0')
                    data <= (others => '0');
                    if uart_rx = '0' then
                        state <= BIT0;
                    end if;
                when BIT0 =>
                    if baudrate = '1' then
                        ascii(0) <= uart_rx;
                        state <= BIT1;
                    end if;
                when BIT1 =>
                    if baudrate = '1' then
                        ascii(1) <= uart_rx;
                        state <= BIT2;
                    end if;
                when BIT2 =>
                    if baudrate = '1' then
                        ascii(2) <= uart_rx;
                        state <= BIT3;
                    end if;
                when BIT3 =>
                    if baudrate = '1' then
                        ascii(3) <= uart_rx;
                        state <= BIT4;
                    end if;
                when BIT4 =>
                    if baudrate = '1' then
                        ascii(4) <= uart_rx;
                        state <= BIT5;
                    end if;
                when BIT5 =>
                    if baudrate = '1' then
                        ascii(5) <= uart_rx;
                        state <= BIT6;
                    end if;
                when BIT6 =>
                    if baudrate = '1' then
                        ascii(6) <= uart_rx;
                        state <= BIT7;
                    end if;
                when BIT7 =>
                    if baudrate = '1' then
                        ascii(7) <= uart_rx;
                        state <= Data_s;
                    end if;
                when Data_s =>
                    data <= ascii;
                    valid <= '1';
                    if baudrate = '1' then
                        state <= IDLE;
                    end if;
                when others => null;
            end case;
        end if;
    end process main;
    
end architecture rtl;