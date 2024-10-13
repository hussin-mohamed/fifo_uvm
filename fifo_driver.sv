package drive;
    import uvm_pkg::*;
    import sequence_item::*;
    `include "uvm_macros.svh"
    class fifo_driver extends uvm_driver#(seq_item);
    `uvm_component_utils(fifo_driver)
    seq_item item;
    virtual fifo_inter fifo_test_vif;
        function new(string name="fifo_driver",uvm_component parent = null);
            super.new(name,parent);
        endfunction //new()
        function void build_phase (uvm_phase phase);
        super.build_phase(phase);
    endfunction 
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            forever begin
                item = seq_item::type_id::create("item");
                seq_item_port.get_next_item(item);
                fifo_test_vif.data_in=item.data_in;
                fifo_test_vif.rst_n=item.rst_n;
                fifo_test_vif.wr_en=item.wr_en;
                fifo_test_vif.rd_en=item.rd_en;
                @(negedge fifo_test_vif.clk);
                seq_item_port.item_done();
            end
        endtask //run_phase
    endclass //className extends superClass
endpackage