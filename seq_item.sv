package sequence_item;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    class seq_item extends uvm_sequence_item;
        `uvm_object_utils(seq_item)
        // define variables and constraints
        parameter FIFO_WIDTH = 16;
        function new(string name = "seq_item");
            super.new(name);
        endfunction //new()
        rand logic [FIFO_WIDTH-1:0] data_in;
        rand logic  rst_n, wr_en, rd_en;
        logic clk;
        logic [FIFO_WIDTH-1:0] data_out;
        logic wr_ack, overflow;
        logic full, empty, almostfull, almostempty, underflow;
        integer RD_EN_ON_DIST ,  WR_EN_ON_DIST  ;
    constraint rando{
        rst_n dist {1:=90,0:=10};
        wr_en dist {1:=(WR_EN_ON_DIST),0:=(100-WR_EN_ON_DIST)};
        rd_en dist {1:=(RD_EN_ON_DIST),0:=(100-RD_EN_ON_DIST)};
    }
    endclass //seq_item extends superClass
endpackage