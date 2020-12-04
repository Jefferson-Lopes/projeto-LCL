module core (mode, c_q, in, save, submit, debug1, debug2, out);
	input mode, c_q, save, submit;
	input [7:0] in;
	output reg [1:0] debug1 = 2'b00;
	output reg [1:0] debug2 = 2'b00;
	output [7:0] out;
	
	reg [7:0] code  = 8'b0;
	reg [7:0] quant = 8'b0;
	
	wire we_m;
	wire [7:0] address_m, quant_m, out_m;
	
	assign out = out_m;
		
	memory u0 (
		.we(we_m), 
		.address(address_m), 
		.data_in(quant_m), 
		.data_out(out_m),
		.debug(debug2)
	);
	
	always @ (negedge save) begin
		if (mode && c_q)         //add code
			code <= in;
		
		else if (mode && ~c_q)   //add quant
			quant <= in;
		
		else if (~mode && c_q)   //remove code
			code <= in;
		
		else if (~mode && ~c_q)  //remove quant
			quant <= in;
	end

	always @ (negedge submit) begin
		if (mode) begin       //add
			we_m <= 0; 
			address_m <= code;
			quant_m <= 8'b0;
			if ((out_m + quant) > 8'b11111111) begin
				we_m <= 1'b1;
				quant_m <= 8'b11111111;
				//debug1 <= 2'b01;
			end
			else begin
				we_m <= 1'b1;
				quant_m <= quant + out_m;
				//debug1 <= 2'b10;
			end
		end
		else begin             //remove
			we_m <= 0; 
			address_m <= code;
			quant_m <= 8'b0;
			if ((out_m - quant) < 8'b0) begin
				we_m <= 1'b1;
				quant_m <= 8'b0;
				debug1 <= 2'b01;
			end
			else begin
				we_m <= 1'b1;
				quant_m <= out_m - quant;
				debug1 <= 2'b10;
			end
		end
	end
	
endmodule
