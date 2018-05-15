vsim -t ns -novopt -lib work work.tb_mem_ctl2
view *
do wave_mem_ctl2.do
run 2 sec
