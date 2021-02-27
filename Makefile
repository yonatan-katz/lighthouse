VERSION = 1
build:
	yosys -p "synth_ice40 -blif uart.blif" uart.v transmitter.v receiver.v baud_rate_gen.v led.v
	arachne-pnr -d 5k -P sg48 -p common/io.pcf uart.blif -o uart.asc
	python3 /mnt/c/Users/yonic/repos/lighthouse-fpga/tools/update_bitstream_comment.py uart.asc "$(VERSION)"
	icepack uart.asc uart.bin