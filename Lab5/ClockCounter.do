vlib work

vlog -timescale 1ns/1ns ClockCounter.v

vsim ClockCounter

log {/*}

add wave {/*}
force {SW[1: 0]} 2#11
force {SW[3]} 0
force {SW[2]} 0 0, 1 50 -r 50
force {CLOCK_50} 0 0, 1 5 -repeat 10
run 1000000ns