package cfg;
import uvm_pkg::*;
`include "uvm_macros.svh"
class fifo_confg extends uvm_object;
    `uvm_object_utils(fifo_confg)
        virtual fifo_inter fifo_test_vif;
        function new(string name = "fifo_confg" );
        super.new(name);
        endfunction
endclass //className extends superClass
endpackage