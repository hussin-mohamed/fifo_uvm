package fifo_monitorr;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import sequence_item::*;
    class fifo_monitor extends uvm_monitor;
        `uvm_component_utils(fifo_monitor)
        seq_item item;
        virtual fifo_inter fifo_test_vif;
        uvm_analysis_port #(seq_item) mon_ap;
        function new(string name = "fifo_monitor",uvm_component parent = null);
            super.new(name,parent);
        endfunction //new()
        function void build_phase (uvm_phase phase);
            super.build_phase(phase);
            mon_ap=new("mon_ap",this);
        endfunction 
        task  run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            item = seq_item::type_id::create("item");
            @(negedge fifo_test_vif.clk);
            item.data_in=fifo_test_vif.data_in;
            item.rst_n=fifo_test_vif.rst_n; 
            item.wr_en=fifo_test_vif.wr_en; 
            item.rd_en=fifo_test_vif.rd_en;
            item.data_out=fifo_test_vif.data_out;
            item.wr_ack=fifo_test_vif.wr_ack; 
            item.overflow=fifo_test_vif.overflow;
            item.full=fifo_test_vif.full; 
            item.empty=fifo_test_vif.empty; 
            item.almostfull=fifo_test_vif.almostfull; 
            item.almostempty=fifo_test_vif.almostempty; 
            item.underflow=fifo_test_vif.underflow;
            mon_ap.write(item);
        end
    endtask //
    endclass //className extends superClass
endpackage