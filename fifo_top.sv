import fifo_test_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
module top ();
    bit clk ;
    initial begin
        forever begin
            #10;
            clk=!clk;
        end
    end
    fifo_inter fifo_test_vif(clk);
    FIFO_corrected dut (fifo_test_vif);
    bind FIFO_corrected sva sva_inst(fifo_test_vif);
    initial begin
    uvm_config_db#(virtual fifo_inter)::set(null,"*","fifo_test_vif",fifo_test_vif);
    run_test("fifo_test");
    end

endmodule