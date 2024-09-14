library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_arith.all;
use STD.textio.all;

entity alu_4_test is

end alu_4_test;

architecture test of alu_4_test is
    
    component alu_4
        port(
            A   : in std_logic_vector(3 downto 0);
            B   : in std_logic_vector(3 downto 0);
            Cin : in std_logic;
            S0  : in std_logic;
            S1  : in std_logic;
            G   : out std_logic_vector(3 downto 0);
            Cout: out std_logic
        );
    end component;

    for alu_4_1: alu_4 use entity work.alu_4(structural);
        signal sig0, sig1, Ci, Co: std_logic;
        signal A1, B1, op   :std_logic_vector(3 downto 0);
        signal clock    :std_logic;
    
    begin

    alu_4_1 : alu_4 port map (A1, B1, Ci, sig0, sig1, op, Co);

    clk : process
    begin  -- process clk

        clock<='0','1' after 5 ns;
        wait for 10 ns;

    end process clk;

    io_process: process

        file infile : text is in "alu_4_in.txt";
        file outfile : text is out "alu_4_out.txt";
        variable s00,s01, carrin, carrout : std_logic;
        variable i1, i2, op1 : std_logic_vector(3 downto 0);
        variable buf : line;
    
    begin
        while not (endfile(infile)) loop
            readline(infile, buf);
            read(buf, s00);
            sig0 <= s00;

            readline(infile, buf);
            read(buf, s01);
            sig1 <= s01;

            readline(infile, buf);
            read(buf, carrin);
            Ci <= carrin;

            readline(infile, buf);
            read(buf, i1);
            A1 <= i1;

            readline(infile, buf);
            read(buf, i2);
            B1 <= i2;

            wait until falling_edge(clock);

            op1:= op;
            write(buf, op1);
            writeline(outfile, buf);

            carrout := Co;
            write(buf, carrout);
            writeline(outfile, buf);
        
        end loop;
    end process;
end test; 