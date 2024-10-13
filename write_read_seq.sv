package write_read_sequence;
import sequence_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class write_read_seq extends uvm_sequence#(seq_item);
    `uvm_object_utils(write_read_seq)
    seq_item item;
    function new(string name = "write_read_seq");
        super.new(name);
    endfunction //new()
    task body();
        repeat(5000) begin
        item = seq_item::type_id::create("item");
        start_item(item);
        item.RD_EN_ON_DIST=30;
        item.WR_EN_ON_DIST=70;
        assert (item.randomize);
        finish_item(item);
        end
    endtask 
endclass //main_seq extends uvm_sequence
endpackage