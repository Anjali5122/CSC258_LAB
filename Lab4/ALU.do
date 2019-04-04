# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in mux.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns ALU.v

# Load simulation using adder as the top level simulation module.
vsim ALU

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}
# force <signal_name> <initial_value> <initial_time>, <new_value> <new time> -repeat <repeat_time> cancel <cancel_time>
### case 1: general case, a = 1010, in order (case 000 to 111 to default), expect (note 2 per case, for clock edge):
#       ALUout: 0000 1011, 0000 1011, 0001 0101, 0000 1111, 0000 1111, 0000 1001, 1111 0101, 1111 1111, 0000 0001, 0000 0001, 0000 0000, 0000 0000, 0000 0000, 0000 0000, 0000 0000, 0000 0000.
#       REGout: xxxx xxxx, 0000 1011, 0000 1011, 0001 0101, 0001 0101, 0000 1111, 0000 1111, 1111 0101, 1111 0101, 0000 0001, 0000 0001, 0000 0000, 0000 0000, 0000 0000, 0000 0000, 0000 0000.
# 	tests general case with registry enabled
# for data(a)
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
# reset_n to see the register values
force {SW[9]} 1
# alternates clock for every possible case by using its rising edge
force {KEY[0]} 0 0, 1 10 -repeat 20
# values for ALU_function
force {SW[5]} 0 0, 1 20 -repeat 40
force {SW[6]} 0 0, 1 40 -repeat 80
force {SW[7]} 0 0, 1 80 -repeat 160
run 160ns
#NOTE THAT RESET_N HAS NOT BEEN RESET
### case 2: general case, a = 0011, in order (case 000 to 111 to default), expect (note 2 per case, for clock edge):
#       ALUout: 0000 0100, 0000 0100, 0000 0111, 0000 1010, 0000 1010, 0000 1101, 1011 1001, 1011 1010, 0000 0001, 0000 0001, 0000 1000, 0100 0000, 0000 0001, 0000 0000, 0000 0011, 0000 1001    
#       REGout: 0000 0000, 0000 0100, 0000 0100, 0000 0111, 0000 0111, 0000 1010, 0000 1010, 1011 1001, 1011 1001, 0000 0001, 0000 0001, 0000 1000, 0000 1000, 0000 0001, 0000 0001, 0000 0011
# 	tests general case with registry enabled and small value of a for testing shifts
# for data(a)
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
# reset_n to see the register values
force {SW[9]} 1
# alternates clock for every possible case by using its rising edge
force {KEY[0]} 0 0, 1 10 -repeat 20
# values for ALU_function
force {SW[5]} 0 0, 1 20 -repeat 40
force {SW[6]} 0 0, 1 40 -repeat 80
force {SW[7]} 0 0, 1 80 -repeat 160
run 160ns
# reset_n to reset registry for next test
# expect (note 2 per case, for clock edge):
#       ALUout: 0000 0100, 0000 0100 
#       REGout: 0000 0011, 0000 0000
# note that here, REGout is only reset upon rising clock edge.
force {SW[9]} 0
force {KEY[0]} 0 0, 1 10 -repeat 20
run 20ns