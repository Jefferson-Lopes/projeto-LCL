module memory (set, address, value, out, debug);
	input set;
	input [7:0] address, value;
	output reg [7:0] out;
	output reg [1:0] debug = 2'b0;
	
	reg [7:0] memory [7:0]; //128 addresses with 8 bits each
	
	always @ (address or set or value) begin
		if (set) begin                  //modify
			memory[address] <= value;
			out <= value;
			debug <= 2'b01;
		end
		else begin
			out <= memory[address];
			debug <= 2'b10;
		end
	end

endmodule
