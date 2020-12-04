module memory (set, address, value, out);
	input set;
	input [7:0] address, value;
	output reg [7:0] out;
	
	reg [7:0] memory [7:0]; //128 addresses with 8 bits each
	
	always @ (address or set or value) begin
		if (set) begin                  //modify
			memory[address] <= value;
			out <= value;
		end
		else begin
			out <= memory[address];
		end
	end

endmodule
