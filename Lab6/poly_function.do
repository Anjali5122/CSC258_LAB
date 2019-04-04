vlib work
vlog -timescale 1ns/1ns poly_function.v
vsim poly_function
log {/*}
add wave {/*}

force {KEY[0]} 0
force {KEY[1]} 1
run 10ns
force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns
force {KEY[0]} 1
run 10ns

# load A: DEC=11, BIN=1011
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
run 10ns
force {KEY[1]} 0
run 10ns
force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns
force {KEY[1]} 1
run 10ns
force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns
# load B: DEC=5, BIN=0101
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
run 10ns
force {KEY[1]} 0
run 10ns
force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns
force {KEY[1]} 1
run 10ns
force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns
# load C: DEC=13, BIN=1101
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
run 10ns
force {KEY[1]} 0
run 10ns
force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns
force {KEY[1]} 1
run 10ns
force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns
# load X: DEC=4, BIN=0100
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 0
force {SW[8]} 0
run 10ns
force {KEY[1]} 0
run 10ns
force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns
force {KEY[1]} 1
run 10ns
force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns
# Compute the value: DEC=209, BIN=1101 0001, HEX=d1
force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns
force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns
force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns
force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns
force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns
force {CLOCK_50} 0
run 10ns
force {CLOCK_50} 1
run 10ns