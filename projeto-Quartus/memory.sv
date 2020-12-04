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

/*
module ram_single_port_ar_aw #(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WITDH = 3
)(
  input                       we,    // write enable
  input                       oe,    // output enable
  input  [(ADDR_WITDH-1):0]   waddr, // write address
  input  [(DATA_WIDTH-1):0]   wdata, // write data
  input                       raddr, // read adddress
  output [(DATA_WIDTH-1):0]   rdata  // read data
);

  reg [(DATA_WIDTH-1):0]      ram [0:2**ADDR_WITDH-1];
  reg [(DATA_WIDTH-1):0]      data_out;

  assign rdata = (oe && !we) ? data_out : {DATA_WIDTH{1'bz}};

  always @*
  begin : mem_write
    if (we) begin
      memory[address] = wdata;
    end
  end

  always @* // if anything below changes (i.e. we, oe, raddr), execute this    
  begin : mem_read
    if (!we) begin
      data_out = memory[address];
    end
  end

endmodule
*/