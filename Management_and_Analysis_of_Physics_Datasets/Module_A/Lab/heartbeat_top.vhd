library ieee;
use ieee.std_logic_1164.all;

entity heartbeat_top is

end entity heartbeat_top;

architecture str of heartbeat_top is

  component heartbeat is
    port (
      clk : out std_logic);
  end component heartbeat;

  signal clk : std_logic;

begin  -- architecture str

  -- component instantiation
  DUT : heartbeat
    port map (
      clk => clk);

end architecture str;

