module core (mode, c_q, in, save, submit, debug, out);
	input mode, c_q, save, submit;
	input [7:0] in;
	output reg [1:0] debug = 2'b00;
	output [7:0] out;
	
	reg [7:0] code  = 8'b0;
	reg [7:0] quant = 8'b0;
	
	wire set_m;
	wire [7:0] address_m, value_m, out_m;
		
	assign out = out_m;
		
	memory u0 (
		.set(set_m), 
		.address(address_m), 
		.value(value_m), 
		.out(out_m)
	);
	
	always @ (negedge save) begin
		if (mode && c_q) begin          //add code
			code <= in;
			debug <= 2'b00;
		end
		
		else if (mode && ~c_q) begin    //add quant
			quant <= in;
			debug <= 2'b01;
		end
		
		else if (~mode && c_q) begin    //remove code
			code <= in;
			debug <= 2'b10;
		end
		
		else if (~mode && ~c_q) begin   //remove quant
			quant <= in;
			debug <= 2'b11;
		end
	end

	always @ (negedge submit) begin
		if (mode) begin //add
			set_m <= 0; 
			address_m <= code;
			value_m <= 8'b0;
			if ((out_m + quant) > 8'b11111111) begin
				set_m <= 1'b1;
				value_m <= 8'b11111111;
			end
			else begin
				set_m <= 1'b1;
				value_m <= quant;
			end
		end
		else begin      //remove
		
		end
	end
	
endmodule
