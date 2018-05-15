vsim -t ns -novopt -lib work work.tb_io_ctl 
view *
do wave_io_ctl.do
run 3 sec
