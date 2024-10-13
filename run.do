vlib work
vlog +define+assertion -f src_files.list +cover -covercells
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all -cover
add wave -position insertpoint sim:/top/fifo_test_vif/*
coverage save fifo_tb.ucdb -onexit
run -all
#vcover report fifo_tb.ucdb -details -all -output coverage_rpt_fifo.txt