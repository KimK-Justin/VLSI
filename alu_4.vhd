library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity alu_4 is
    port(
        A   : in std_logic_vector(3 downto 0);
        B   : in std_logic_vector(3 downto 0);
        Cin : in std_logic;
        S0  : in std_logic;
        S1  : in std_logic;
        G   : out std_logic_vector(3 downto 0);
        Cout: out std_logic
    );
end alu_4;

architecture structural of alu_4 is

component adder4
    port(
        input1  : in std_logic_vector(3 downto 0);
        input2  : in std_logic_vector(3 downto 0);
        carryin : in std_logic;
        sum     : out std_logic_vector(3 downto 0);
        carryout: out std_logic
    );
end component;

component mux4
    port(
        S01 : in std_logic;
        S10 : in std_logic;
        B1  : in std_logic_vector(3 downto 0);
        output  : out std_logic_vector(3 downto 0)
    );
end component;

for adder4_1: adder4 use entity work.adder4(structural);
for mux4_1: mux4 use entity work.mux4(structural);
signal tempB: std_logic_vector(3 downto 0);

begin

    mux4_1: mux4 port map (S0, S1, B, tempB);
    adder4_1: adder4 port map (A, tempB, Cin, G, Cout);

end structural;
