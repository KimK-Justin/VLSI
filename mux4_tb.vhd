library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_arith.all;
use STD.textio.all;

entity mux4_tb is

end mux4_tb;

architecture test of mux4_tb is

    component mux4
        port(
            S01 :in std_logic;
            S10 :in std_logic;
            B1   :in std_logic_vector(3 downto 0);
            output  :out std_logic_vector(3 downto 0));
    end component;

    for mux4_1: mux4 use entity work.mux4(structural);
        signal sig1, sig2: std_logic;
        signal B2, op   :std_logic_vector(3 downto 0);
        signal clock    :std_logic;

    begin

    mux4_1  :mux4 port map (sig1, sig2, B2, op);

    clk : process
    begin  -- process clk

        clock<='0','1' after 5 ns;
        wait for 10 ns;

    end process clk;

    io_process: process

        file infile :text is in "mux4_in.txt";
        file outfile :text is out "mux4_out.txt";
        variable s1, s2   :std_logic;
        variable i1, op1    :std_logic_vector(3 downto 0);
        variable buf    :line;

    begin
        while not (endfile(infile)) loop
            readline(infile,buf);
            read (buf,s1);
            sig1 <= s1;

            readline(infile,buf);
            read (buf,s2);
            sig2 <= s2;

            readline(infile,buf);
            read (buf,i1);
            B2 <= i1;

            wait until falling_edge(clock);

            op1:=op;

            write(buf,op1);
            writeline(outfile,buf);

        end loop;

    end process io_process;

end test;