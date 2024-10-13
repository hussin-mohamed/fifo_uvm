////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: FIFO Design 
// 
////////////////////////////////////////////////////////////////////////////////
module FIFO_corrected(fifo_inter.DUT fifo_test_vif);
parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8; 
localparam max_fifo_addr = $clog2(FIFO_DEPTH);
reg [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0];
reg [max_fifo_addr-1:0] wr_ptr, rd_ptr;
reg [max_fifo_addr:0] count;

always @(posedge fifo_test_vif.clk or negedge fifo_test_vif.rst_n) begin
	if (!fifo_test_vif.rst_n) begin
		wr_ptr <= 0;
		//
		fifo_test_vif.overflow <= 0;
		fifo_test_vif.wr_ack <= 0;
	end
	else if (fifo_test_vif.wr_en && count < FIFO_DEPTH) begin
		mem[wr_ptr] <= fifo_test_vif.data_in;
		fifo_test_vif.wr_ack <= 1;
		wr_ptr <= wr_ptr + 1;
		//
		fifo_test_vif.overflow <= 0;
	end
	else begin 
		fifo_test_vif.wr_ack <= 0; 
		if (fifo_test_vif.full && fifo_test_vif.wr_en) begin
			fifo_test_vif.overflow <= 1;
		end
			
		else begin
			fifo_test_vif.overflow <= 0;
		end
			
	end
end

always @(posedge fifo_test_vif.clk or negedge fifo_test_vif.rst_n) begin
	if (!fifo_test_vif.rst_n) begin
		rd_ptr <= 0;
		//
		fifo_test_vif.underflow <= 0;
	end
	else if (fifo_test_vif.rd_en && count != 0) begin
		fifo_test_vif.data_out <= mem[rd_ptr];
		rd_ptr <= rd_ptr + 1;
		//
		fifo_test_vif.underflow <= 0;
	end
	//
	else begin 
		if (fifo_test_vif.empty && fifo_test_vif.rd_en) begin
			fifo_test_vif.underflow <= 1;
		end
			
		else begin
			fifo_test_vif.underflow <= 0;
		end
			
	end
end

always @(posedge fifo_test_vif.clk or negedge fifo_test_vif.rst_n) begin
	if (!fifo_test_vif.rst_n) begin
		count <= 0;
	end
	else begin
		//
		if (({fifo_test_vif.wr_en, fifo_test_vif.rd_en} == 2'b11)) begin
			if (fifo_test_vif.full) begin
				count<=count-1;
			end
			if (fifo_test_vif.empty) begin
				count<=count+1;
			end
		end
		else begin
			if	( ({fifo_test_vif.wr_en, fifo_test_vif.rd_en} == 2'b10) && !fifo_test_vif.full) 
			count <= count + 1;
		else if ( ({fifo_test_vif.wr_en, fifo_test_vif.rd_en} == 2'b01) && !fifo_test_vif.empty)//
			count <= count - 1;
		end
	end
end
//

assign fifo_test_vif.full = (count == FIFO_DEPTH)? 1 : 0;
assign fifo_test_vif.empty = (count == 0)? 1 : 0;
assign fifo_test_vif.almostfull = (count == FIFO_DEPTH-1)? 1 : 0; //
assign fifo_test_vif.almostempty = (count == 1)? 1 : 0;
///////////////////////////////////////////////////////
endmodule