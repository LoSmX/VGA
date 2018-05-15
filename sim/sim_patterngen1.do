vsim -t ns -novopt -lib work work.tb_patterngen1 
view *
do wave_patterngen1.do
run 2 sec
