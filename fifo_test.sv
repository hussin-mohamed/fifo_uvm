package fifo_test_pkg;
import env_pac::*;
import uvm_pkg::*;
import write_sequence::*;
import write_read_sequence::*;
import read_sequence::*;
import reset_sequence::*;
import cfg::*;
`include "uvm_macros.svh"
class fifo_test extends uvm_test;
    `uvm_component_utils(fifo_test)
    fifo_confg cfgg;
    fifo_env env;
    write_seq wseq;
    read_seq rseq;
    reset_seq resetseq;
    write_read_seq wrseq;
    function new(string name = "fifo_test",uvm_component parent = null);
        super.new(name,parent);
    endfunction 

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        env = fifo_env::type_id::create("env",this);
        cfgg = fifo_confg::type_id::create("cfgg",this);
        rseq = read_seq::type_id::create("rseq",this);
        resetseq=reset_seq::type_id::create("resetseq",this);
        wseq = write_seq::type_id::create("wseq",this);
        wrseq = write_read_seq::type_id::create("wrseq",this);
        if(!uvm_config_db#(virtual fifo_inter)::get(this,"","fifo_test_vif",cfgg.fifo_test_vif))
        `uvm_fatal("build_phase","a333333333");
        uvm_config_db#(fifo_confg)::set(null,"*","CFG",cfgg);
    endfunction 

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        `uvm_info("run_phase", "reset asserted",UVM_MEDIUM)
        resetseq.start(env.agt.sqr);
        `uvm_info("run_phase", "reset desserted",UVM_MEDIUM)
        `uvm_info("run_phase", "writing fifo and then reading it started",UVM_MEDIUM)
        repeat(5000)begin
        wseq.start(env.agt.sqr);
        rseq.start(env.agt.sqr);
        end
        `uvm_info("run_phase", "writing fifo and then reading it finished",UVM_MEDIUM)
        `uvm_info("run_phase", "writing fifo and reading it randomizely the order started",UVM_MEDIUM)
            wrseq.start(env.agt.sqr);
        `uvm_info("run_phase", "writing fifo and reading it randomizely the order finished",UVM_MEDIUM)
        
        
        `uvm_info("run_phase", $sformatf("correct_count=%0d , wrong_count = %0d",env.sb.right_count,env.sb.error_count),UVM_MEDIUM)

        phase.drop_objection(this);
    endtask
    

endclass 

endpackage