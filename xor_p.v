// Title: xor_p.v
// Author: Wilmer Silva
// Last Modified: 11/23/2019
// Purpose: A basic combinational circuit is created as function P.
//          This code confirms that the equation was generated correctly,
//			    and gives a truth table used for debugging.

//***********************************************************************************
module xor_p (
input W, X, Y, Z,	// inputs for combinational circuit
output P	        // output that represents the function P
);

wire W, X, Y, Z; // need to declare wires for each input, output, & internal signal
wire nX, nY, WnYZ, YZ, nXY;
wire P;

// Instantiate gates in for an "architectural" solution
and (WnYZ,W,nY,nZ);    // the leftmost variable is output...
and (YZ,Y,Z);          // all other variables are inputs...
and (nXY,nX,Y);
// P = (W*Y'*X)^(Y*Z)^(X'*Y)
xor (P,WnYZ,YZ,nXY);
not (nX, X);
not (nY,Y);

// Note that order doesn't matter here. These lines describe a
// physical arrangement, not an ordered list of operations.
endmodule
//***********************************************************************************

module xor_p_tb;  // Note, no interface to test benches
 reg wW,wX,wY,wZ;         // signals to be commanded by assignment statements must be "reg"
 wire wP;			            // output from unit-under-test is "wire"


initial begin       // This will allow us to graph the output
    $dumpfile ("xor_p.vcd");
	  $dumpvars;
end

initial begin // within an “initial” block, code executes sequentially ONCE
	// $display acts like a common printf
	$display("  W X Y Z |  nX nY  WnYZ  YZ   nXY  | P");
	$display(" ---------+-------------------------+---");
	// $monitor is like printf, AND, whenever one of the listed
	// variables changes again, it re-executes automatically
  // thus, creating a truth table to confirm output of circuit
  $monitor("  %b %b %b %b | %2b %2b   %2b    %2b   %2b   | %b",wW, wX, wY, wZ, uut.nX, uut.nY, uut.WnYZ, uut.YZ, uut.nXY, wP);
	wW = 0; wX = 0; wY = 0; wZ = 0; #1;
	wW = 0; wX = 0; wY = 0; wZ = 1; #1;
	wW = 0; wX = 0; wY = 1; wZ = 0; #1;
	wW = 0; wX = 0; wY = 1; wZ = 1; #1;
	wW = 0; wX = 1; wY = 0; wZ = 0; #1;
	wW = 0; wX = 1; wY = 0; wZ = 1; #1;
	wW = 0; wX = 1; wY = 1; wZ = 0; #1;
	wW = 0; wX = 1; wY = 1; wZ = 1; #1;
	wW = 1; wX = 0; wY = 0; wZ = 0; #1;
	wW = 1; wX = 0; wY = 0; wZ = 1; #1;
	wW = 1; wX = 0; wY = 1; wZ = 0; #1;
	wW = 1; wX = 0; wY = 1; wZ = 1; #1;
	wW = 1; wX = 1; wY = 0; wZ = 0; #1;
	wW = 1; wX = 1; wY = 0; wZ = 1; #1;
	wW = 1; wX = 1; wY = 1; wZ = 0; #1;
	wW = 1; wX = 1; wY = 1; wZ = 1; #1;
	$finish; // tells simulator to stop and return to the command prompt

end

// Connect UUT to test bench signals
xor_p uut(
.W	(wW),
.X	(wX),
.Y	(wY),
.Z	(wZ),
.P	(wP)
);
endmodule
