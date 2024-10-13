module sva (
    fifo_inter.DUT fifo_test_vif
);
    parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8; 
    `ifdef assertion
always_comb begin : blockName
	if (!fifo_test_vif.rst_n) begin
		RESET:assert final(FIFO_corrected.count==3'b0 && !fifo_test_vif.full && fifo_test_vif.empty && !fifo_test_vif.almostempty && !fifo_test_vif.almostfull && !FIFO_corrected.rd_ptr && !FIFO_corrected.wr_ptr && !fifo_test_vif.overflow && !fifo_test_vif.underflow );
	end
end
WR_ACK : assert property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.wr_en==1'b1 && !fifo_test_vif.full |=> fifo_test_vif.wr_ack==1'b1);
WR_ACK_cover :cover  property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.wr_en==1'b1 && !fifo_test_vif.full |=> fifo_test_vif.wr_ack==1);
full : assert property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) (FIFO_corrected.count)==FIFO_DEPTH |-> fifo_test_vif.full==1'b1);
full_cover :cover property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) (FIFO_corrected.count)==FIFO_DEPTH |-> fifo_test_vif.full==1'b1);
empty : assert property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) (FIFO_corrected.count)==3'b0 |-> fifo_test_vif.empty==1'b1);
empty_cover : cover property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) (FIFO_corrected.count)==3'b0 |-> fifo_test_vif.empty==1'b1);
almostfull : assert property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) (FIFO_corrected.count)==FIFO_DEPTH-1'b1 |-> fifo_test_vif.almostfull==1'b1);
almostfull_cover :cover property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) (FIFO_corrected.count)==FIFO_DEPTH-1'b1 |-> fifo_test_vif.almostfull==1'b1);
almostempty : assert property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) (FIFO_corrected.count)==3'b1 |-> fifo_test_vif.almostempty==1);
almostempty_cover : cover property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) (FIFO_corrected.count)==3'b1 |-> fifo_test_vif.almostempty==1);
countER_UP : assert property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.wr_en==1'b1 && fifo_test_vif.rd_en==1'b0 && !fifo_test_vif.full |=> FIFO_corrected.count==$past(FIFO_corrected.count)+1'b1);
countER_UP_cover : cover property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.wr_en==1'b1 && fifo_test_vif.rd_en==1'b0 && !fifo_test_vif.full |=> FIFO_corrected.count==$past(FIFO_corrected.count)+1'b1);
countER_DOWN : assert property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.wr_en==1'b0 && fifo_test_vif.rd_en==1'b1 && !fifo_test_vif.empty |=> FIFO_corrected.count==$past(FIFO_corrected.count)-1'b1);
countER_DOWN_cover : cover property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.wr_en==1'b0 && fifo_test_vif.rd_en==1'b1 && !fifo_test_vif.empty |=> FIFO_corrected.count==$past(FIFO_corrected.count)-1'b1);
countER_FULL : assert property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.wr_en==1'b1 && fifo_test_vif.rd_en==1'b1 && fifo_test_vif.full |=> FIFO_corrected.count==$past(FIFO_corrected.count)-1'b1);
countER_FULL_cover : cover property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.wr_en==1'b1 && fifo_test_vif.rd_en==1'b1 && fifo_test_vif.full |=> FIFO_corrected.count==$past(FIFO_corrected.count)-1'b1);
countER_EMPTY : assert property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.wr_en==1'b1 && fifo_test_vif.rd_en==1'b1 && fifo_test_vif.empty |=> FIFO_corrected.count==$past(FIFO_corrected.count)+1'b1);
countER_EMPTY_cover : cover property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.wr_en==1'b1 && fifo_test_vif.rd_en==1'b1 && fifo_test_vif.empty |=> FIFO_corrected.count==$past(FIFO_corrected.count)+1'b1);
OVERFLOW : assert property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.wr_en==1'b1 && fifo_test_vif.full |=> fifo_test_vif.overflow==1);
OVERFLOW_cover : cover property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.wr_en==1'b1 && fifo_test_vif.full |=> fifo_test_vif.overflow==1);
UNDERFLOW : assert property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.rd_en==1'b1 && fifo_test_vif.empty |=> fifo_test_vif.underflow==1);
UNDERFLOW_cover : cover property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.rd_en==1'b1 && fifo_test_vif.empty |=> fifo_test_vif.underflow==1);
RD_POfifo_inter : assert property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.rd_en==1'b1 && FIFO_corrected.FIFO_corrected.count != 1'b0 |=> FIFO_corrected.rd_ptr==$past(FIFO_corrected.rd_ptr)+1'b1);
RD_POfifo_inter_cover : cover property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.rd_en==1'b1 && FIFO_corrected.FIFO_corrected.count != 1'b0 |=> FIFO_corrected.rd_ptr==$past(FIFO_corrected.rd_ptr)+1'b1);
WR_POfifo_inter : assert property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.wr_en==1'b1 && FIFO_corrected.count < FIFO_DEPTH |=> FIFO_corrected.wr_ptr==$past(FIFO_corrected.wr_ptr)+1'b1);
WR_POfifo_inter_cover : cover property (@(posedge fifo_test_vif.clk) disable iff(!fifo_test_vif.rst_n) fifo_test_vif.wr_en==1'b1 && FIFO_corrected.count < FIFO_DEPTH |=> FIFO_corrected.wr_ptr==$past(FIFO_corrected.wr_ptr)+1'b1);
`endif 
endmodule