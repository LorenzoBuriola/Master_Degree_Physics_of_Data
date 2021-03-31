library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end testbench; 

architecture tb of testbench is
    
    signal a1  : std_logic_vector(2 downto 0);
    signal a2  : std_logic_vector(2 downto 0);
    signal a3  : std_logic_vector(2 downto 0);
    signal a4  : std_logic_vector(2 downto 0);
    signal sel : std_logic_vector(1 downto 0);
    signal b   : std_logic_vector(2 downto 0);

begin
    DUT: entity work.mux4 
    port map (
      a1  => a1,
      a2  => a2,
      a3  => a3,
      a4  => a4,
      sel => sel,
      b   => b);

    wavegen_proc : process
    begin
    a1 <= "010";
    a2 <= "011";
    a3 <= "100";
    a4 <= "111";

    sel <= "00";
    wait for 1 ns;
    sel <= "01";
    wait;
  end process wavegen_proc;
end tb;

configuration mux4_tb_tb_cfg of testbench is
  for tb
  end for;
end mux4_tb_tb_cfg;


