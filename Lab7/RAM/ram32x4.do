vlib work

vlog -timescale 1ns/1ns ram32x4.v

vsim -L altera_mf_ver ram32x4

log {/*}

add wave {/*}

force {clock} 0 0,1 5 -r 10
force {address} 5'b 00000 0, 5'b00001 10, 5'b00010 20, 5'b00011 30 -r 40
force {data} 4'b0001 0, 4'b0010 10, 4'b0011 20, 4'b0100 30 -r 40
force {wren} 1 0,0 120 -r 240
run 480ns



