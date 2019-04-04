# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns Shifter.v

# Load simulation using adder as the top level simulation module.
vsim Shifter

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}
# force <signal_name> <initial_value> <initial_time>, <new_value> <new time> -repeat <repeat_time> cancel <cancel_time>
#----Case 1 + 2----
#Storage
#Reset SW[9], KEY[1] load_n, KEY[2] ShiftRight, KEY[3] ASR
force {SW[9]} 1 
force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 0
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 0
force {KEY[3]} 0
force {KEY[2]} 0
# alternates clock for every possible case by using its rising edge
force {KEY[0]} 0 0, 1 10 -repeat 20
run 40ns
#Case 2
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0
force {KEY[0]} 0 0, 1 10 -repeat 20
run 40ns
#----Case 1 + 3----
#Storage
force {SW[9]} 1
force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 0
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 0
force {KEY[3]} 0
force {KEY[2]} 0
# alternates clock for every possible case by using its rising edge
force {KEY[0]} 0 0, 1 10 -repeat 20
run 40ns
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
force {KEY[0]} 0 0, 1 10 -repeat 20
run 40ns
#Question 1 of Lab part 3
force {KEY[1]} 1
force {KEY[2]} 0
run 40 ns
