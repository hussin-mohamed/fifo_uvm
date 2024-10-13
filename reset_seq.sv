package reset_sequence;
import sequence_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
class reset_seq extends uvm_sequence#(seq_item);
    `uvm_object_utils(reset_seq)
    seq_item item;
    function new(string name = "reset_seq");
        super.new(name);
    endfunction //new()
    task body();
        item = seq_item::type_id::create("item");
        start_item(item);
        item.data_in=0;
        item.rst_n=0;
        item.rd_en=0;
        item.wr_en=0;
        finish_item(item);
    endtask 
endclass //main_seq extends uvm_sequence
endpackage