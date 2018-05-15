vsim -t ns -novopt -lib work work.tb_vga_ctl 
view *
do wave_vga_ctl.do
run 2 sec
