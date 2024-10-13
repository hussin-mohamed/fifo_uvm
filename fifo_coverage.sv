package coverage_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
import sequence_item::*;
class fifo_cover extends uvm_component;
`uvm_component_utils(fifo_cover)
uvm_analysis_export #(seq_item) cov_export;
uvm_tlm_analysis_fifo #(seq_item) cov_fifo;
seq_item item;
parameter maxpos=3, maxneg=-4, zero=0 ;
covergroup g1 ;
        rd_enable: coverpoint item.rd_en iff(item.rst_n);
            wr_enable: coverpoint item.wr_en iff(item.rst_n);
            wr_acknowledge: coverpoint item.wr_ack iff(item.rst_n);
            overfloww: coverpoint item.overflow iff(item.rst_n);
            underfloww: coverpoint item.underflow iff(item.rst_n);
            fulll: coverpoint item.full iff(item.rst_n);
            almostfulll: coverpoint item.almostfull iff(item.rst_n);
            emptyy: coverpoint item.empty iff(item.rst_n);
            almostemptyy: coverpoint item.almostempty iff(item.rst_n);
            rd_enable_with_empty:cross rd_enable,emptyy;
            rd_enable_with_almostempty:cross rd_enable,almostemptyy;
            rd_enable_with_underflow : cross rd_enable,underfloww {
                option.cross_auto_bin_max=0;
                bins rd_on_under_off = binsof(rd_enable) intersect {1} && binsof(underfloww) intersect {0};
                bins rd_off_under_off = binsof(rd_enable) intersect {0} && binsof(underfloww) intersect {0};
                bins rd_on_under_on = binsof(rd_enable) intersect {1} && binsof(underfloww) intersect {1};
            }
            wr_enable_with_full : cross wr_enable,fulll;
            wr_enable_with_almostfull : cross wr_enable,almostfulll;
            wr_enable_with_overflow : cross wr_enable,overfloww{
                option.cross_auto_bin_max=0;
                bins wr_on_over_off = binsof(wr_enable) intersect {1} && binsof(overfloww) intersect {0};
                bins wr_off_over_off = binsof(wr_enable) intersect {0} && binsof(overfloww) intersect {0};
                bins wr_on_over_on = binsof(wr_enable) intersect {1} && binsof(overfloww) intersect {1};
            }
            wr_enable_with_wr_acknowledge : cross wr_enable,wr_acknowledge{
                option.cross_auto_bin_max=0;
                bins wr_on_wr_acknowledge_off = binsof(wr_enable) intersect {1} && binsof(wr_acknowledge) intersect {0};
                bins wr_off_wr_acknowledge_off = binsof(wr_enable) intersect {0} && binsof(wr_acknowledge) intersect {0};
                bins wr_on_wr_acknowledge_on = binsof(wr_enable) intersect {1} && binsof(wr_acknowledge) intersect {1};
            }
        endgroup

   function new(string name = "fifo_cover" , uvm_component parent = null);
        super.new(name,parent);
        g1=new();
    endfunction
    
      function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        cov_export=new("sb_export",this);
        cov_fifo=new("sb_fifo",this);
    endfunction 

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        cov_export.connect(cov_fifo.analysis_export);
    endfunction 
     task  run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
        cov_fifo.get(item);
        g1.sample();
        end
    endtask
endclass 
    
endpackage