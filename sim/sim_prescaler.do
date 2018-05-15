vsim -t ns -novopt -lib work work.tb_prescaler 
view *
do wave_prescaler.do
run 1000 ns
