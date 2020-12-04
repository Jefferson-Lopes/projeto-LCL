module sistemaDeControle (SW, KEY, LED, debug1, debug2);
	input [9:0] SW;
	input [3:0] KEY;
	output [7:0] LED;
	output [1:0] debug1;
	output [1:0] debug2;
	
	core u0 (
		.mode(SW[9]), 
		.c_q(SW[8]), 
		.in(SW[7:0]), 
		.save(KEY[3]),
		.submit(KEY[2]),
		.debug1(debug1),
		.debug2(debug2),
		.out(LED)
	);
	
	//mostrar entrada em tempo real junto com botao de show
	
endmodule
