vsim -t ns -novopt -lib work work.tb_mem_ctl1
view *
do wave_mem_ctl1.do
run 2 sec
