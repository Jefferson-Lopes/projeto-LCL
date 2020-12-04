module memory (we, address, data_in, data_out, debug);
	input we;                          //write enable
	input [7:0] address;
	input [7:0] data_in;
	output [7:0] data_out;
	output reg [1:0] debug = 2'b0;
	
	reg [7:0] memory [0:7];            //128 addresses with 8 bits each

	always @ * begin
		if (we) begin                   //modify
			memory[address] <= data_in;
			data_out <= memory[address];
			//debug <= 2'b01;
		end
		else begin
			data_out <= memory[address];
			//debug <= 2'b10;
		end
	end
	
endmodule
