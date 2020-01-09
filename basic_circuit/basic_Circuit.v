// Title: basic_Circuit.v
// Author: Wilmer Silva
// Last Modified: 11/23/2019
// Purpose: A basic combinational circuit is created as function F.
//          This code confirms that the equation was generated correctly,
//			    and gives a truth table used for debugging.

//***********************************************************************************
module basic_Circuit (
input A, B, C, D,	// inputs for combinational circuit
output F	        // output that represents the function F
);

wire A,B,C,D; // need to declare wires for each input, output, & internal signal
wire nB, nC, A_nC_nD, A_nB, B_D;
wire F;

// Instantiate gates in for an "architectural" solution
or (A_nC_nD,A,nC,nD);    // the leftmost variable is output...
or (A_nB,A,nB);          // all other variables are inputs...
or (B_D,B,D);
// F = (A+B')*(B+D)*(A+C'+D')
and (F,A_nC_nD,A_nB,B_D);
not (nA, A);
not (nB,B);
not (nC,C);
// Note that order doesn't matter here. These lines describe a
// physical arrangement, not an ordered list of operations.
endmodule
//***********************************************************************************

module basic_Circuit_tb;  // Note, no interface to test benches
 reg wA,wB,wC,wD;         // signals to be commanded by assignment statements must be "reg"
 wire wF;			            // output from unit-under-test is "wire"


initial begin       // This will allow us to graph the output
    $dumpfile ("basic_Circuit.vcd");
	  $dumpvars;
end

initial begin // within an “initial” block, code executes sequentially ONCE
	// $display acts like a common printf
	$display("  A B C D | nB nC A+nC+nD A+nB B+D  | F");
	$display(" ---------+-------------------------+---");
	// $monitor is like printf, AND, whenever one of the listed
	// variables changes again, it re-executes automatically
  // thus, creating a truth table to confirm output of circuit
  $monitor("  %b %b %b %b | %2b %2b   %2b    %2b   %2b   | %b",wA, wB, wC, wD, uut.nB, uut.nC, uut.A_nC_nD, uut.A_nB, uut.B_D, wF);
	wA = 0; wB = 0; wC = 0; wD = 0; #1;
	wA = 0; wB = 0; wC = 0; wD = 1; #1;
	wA = 0; wB = 0; wC = 1; wD = 0; #1;
	wA = 0; wB = 0; wC = 1; wD = 1; #1;
	wA = 0; wB = 1; wC = 0; wD = 0; #1;
	wA = 0; wB = 1; wC = 0; wD = 1; #1;
	wA = 0; wB = 1; wC = 1; wD = 0; #1;
	wA = 0; wB = 1; wC = 1; wD = 1; #1;
	wA = 1; wB = 0; wC = 0; wD = 0; #1;
	wA = 1; wB = 0; wC = 0; wD = 1; #1;
	wA = 1; wB = 0; wC = 1; wD = 0; #1;
	wA = 1; wB = 0; wC = 1; wD = 1; #1;
	wA = 1; wB = 1; wC = 0; wD = 0; #1;
	wA = 1; wB = 1; wC = 0; wD = 1; #1;
	wA = 1; wB = 1; wC = 1; wD = 0; #1;
	wA = 1; wB = 1; wC = 1; wD = 1; #1;
	$finish; // tells simulator to stop and return to the command prompt

end

// Connect UUT to test bench signals
basic_Circuit uut(
.A	(wA),
.B	(wB),
.C	(wC),
.D	(wD),
.F	(wF)
);
endmodule
