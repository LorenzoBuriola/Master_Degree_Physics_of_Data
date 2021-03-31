library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sample_generator is
    port (
        clk : in std_logic;
        uart_rx : in std_logic;
        baudrate_out : out std_logic
    );
end sample_generator;

architecture rtl of sample_generator is

    type state_t is (IDLE, COUNT);
    signal state : state_t := IDLE;
    signal enable : std_logic;
    signal pulse_out : std_logic;
    signal count1 : unsigned(3 downto 0) := (others => '0');
    signal count2 : unsigned(9 downto 0) := (others => '0');
    constant divisor : unsigned(9 downto 0) := to_unsigned(867, 10);
    constant halfdivisor : unsigned(9 downto 0) := to_unsigned(433, 10);
    signal count3 : unsigned(9 downto 0) := (others => '0');
    signal delay_enable : std_logic := '0';


begin

    pulse_gen : process(clk) is
    begin
        if rising_edge(clk) then
            if enable = '1' then
                if count2 = divisor then
                    count2 <= (others => '0');
                    pulse_out <= '1';
                else
                    count2 <= count2 + 1;
                    pulse_out <= '0';
                end if;
            end if;
        end if;
    end process pulse_gen;

    state_m : process(clk) is
    begin
        if rising_edge(clk) then
            case state is
                when IDLE =>
                    enable <= '0';
                    if uart_rx = '0' then
                        state <= COUNT;
                    end if;
                when COUNT =>
                    enable <= '1';
                    if pulse_out = '1' then
                        if count1 = 8 then
                            count1 <= (others => '0');
                            state <= IDLE;
                        else
                            count1 <= count1 + 1;
                            state <= COUNT;
                        end if;
                    end if;
                when others => null;
            end case;
        end if;
    end process state_m;

    delay_line : process(clk) is
    begin
        if rising_edge(clk) then
            if pulse_out = '1' then
                delay_enable <= '1';
            end if;
            if delay_enable = '1' then
                if count3 = halfdivisor then
                    count3 <= (others => '0');
                    baudrate_out <= '1';
                    delay_enable <= '0';
                else
                    count3 <= count3 + 1;
                    baudrate_out <= '0';
                end if;
            else
                baudrate_out <= '0';
            end if;
        end if;   
    end process delay_line;

end architecture;
