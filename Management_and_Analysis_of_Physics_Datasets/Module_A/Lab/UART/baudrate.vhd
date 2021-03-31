library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity baudrate is
    port (
        clk : in std_logic;
        bau_out : out std_logic
    );
end entity baudrate;

architecture rtl of baudrate is

    signal count : unsigned(9 downto 0) := (others => '0');
    constant divisor : unsigned(9 downto 0) := to_unsigned(867, 10); 

begin

    main : process(clk) is
        
    begin
        if rising_edge(clk) then
            if count = divisor then
                count <= (others => '0');
                bau_out <= '1';
            else
                count <= count + 1;
                bau_out <= '0';
            end if;
        end if;
    end process main;

end architecture rtl;
    
