library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity mux4 is
  port(
    S01 :in std_logic;
    S10 :in std_logic;
    B1 :in std_logic_vector(3 downto 0);
    output :out std_logic_vector(3 downto 0));
end mux4;

architecture structural of mux4 is
  
component mux2
  port(
    S0  :in std_logic;
    S1  :in std_logic;
    B :in std_logic;
    outp  :out std_logic);
end component;

for mux2_1, mux2_2, mux2_3, mux2_4: mux2 use entity work.mux2(structural);

begin

  mux2_1: mux2 port map (S01, S10, B1(0), output(0));
  mux2_2: mux2 port map (S01, S10, B1(1), output(1));
  mux2_3: mux2 port map (S01, S10, B1(2), output(2));
  mux2_4: mux2 port map (S01, S10, B1(3), output(3));

end structural;
