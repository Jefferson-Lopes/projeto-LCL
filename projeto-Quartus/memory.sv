module memory (we, address, data_in, data_out);
	input we;                  //write enable
	input [7:0] address;
	input [7:0] data_in;
	output [7:0] data_out;
	
	reg [7:0] memory [0:7];   //128 addresses with 8 bits each

	always @ * begin
		if (we) begin          //write data
			memory[address] <= data_in;
			data_out <= memory[address];
		end
		else begin             //read data
			data_out <= memory[address];
		end
	end
	
endmodule
