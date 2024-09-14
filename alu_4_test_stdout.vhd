library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_arith.all;
use STD.textio.all;

entity alu_4_test_stdout is

end alu_4_test_stdout;

architecture test of alu_4_test_stdout is

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
    signal create_input: std_logic_vector(8 downto 0):="000000000";
procedure print_output is
    variable out_line: line;
    
    begin
    write (out_line, string'(" Input1:"));
    write (out_line, A1);
    write (out_line, string'(" Input2:"));
    write (out_line, B1);

    write (out_line, string'(" Carry In:"));
    write (out_line, Ci);

    write (out_line, string'(" Signal 1:"));
    write (out_line, sig0);
    write (out_line, string'(" Signal 2:"));
    write (out_line, sig1);

    writeline(output, out_line);

    write (out_line, string'(" Output:"));
    write (out_line, op);
    write (out_line, string'(" Carry Out:"));
    write (out_line, Co);
    writeline(output, out_line);
    writeline(output, out_line);
end print_output;

begin
         
alu_4_1 : alu_4 port map (A1, B1, Ci, sig0, sig1, op, Co);

create_input <= unsigned(create_input)+ unsigned'("000000001") after 2 ns;

io_process: process
   variable out_line: line;

begin
       write(out_line, string'("Running all possible combinations. Will take some time to run !!!!"));
       writeline(output, out_line);
       write(out_line, string'("Type 'run 1024 ns' to continue or 'exit' to quit"));
       writeline(output, out_line);
       write(out_line, string'("Redirect output using > if required and multiple ^C's to quit"));
       writeline(output, out_line);

    for i in 0 to 511 loop
       wait for 1 ns;

       B1<= create_input(8 downto 5);
       A1<= create_input(4 downto 1);
       Ci<= create_input(0);
       sig0 <= create_input(0);
       sig1 <= create_input(0);
    
       wait for 1 ns;

       print_output;
   end loop;
end process io_process;

end test;

    