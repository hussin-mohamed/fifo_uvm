package write_sequence;
import sequence_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class write_seq extends uvm_sequence#(seq_item);
    `uvm_object_utils(write_seq)
    seq_item item;
    function new(string name = "write_seq");
        super.new(name);
    endfunction //new()
    task body();
        repeat(9) begin
        item = seq_item::type_id::create("item");
        start_item(item);
        item.rand_mode(0);
        item.data_in.rand_mode(1);
        item.constraint_mode(0);
        assert (item.randomize);
        item.rst_n=1;
        item.wr_en=1;
        item.rd_en=0;
        finish_item(item);
        end
    endtask 
endclass //main_seq extends uvm_sequence
endpackage