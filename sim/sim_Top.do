vsim -t ns -novopt -lib work work.tb_Top
view *
do wave_Top.do
run 2 sec
