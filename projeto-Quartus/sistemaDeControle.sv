module sistemaDeControle (SW, KEY, LED);
	input [9:0] SW;
	input [3:2] KEY;
	output [7:0] LED;
	
	  ///////////////////////
	 //No Verilog Warnings//
	///////////////////////
	
	core u0 (
		.mode(SW[9]), 
		.c_q(SW[8]), 
		.in(SW[7:0]), 
		.save(KEY[3]),
		.submit(KEY[2]),
		.out(LED)
	);
	
endmodule
