# Program the FPGA via a hw_server

if { $argc != 2 } {
	puts "Wrong number of arguments."
        puts "Usage: $argv0 [hw_server ip] [fpga bitstream file]"
} else {
	exec ipcrm -a
	puts "connection to [lindex $argv 0]"
	if { [ catch {connect -host [lindex $argv 0]} err] } {
		puts "Error connecting: $err"
		exit 1
	}
	if { [ catch {targets -set -filter {name == "PL"}} err] } {
		puts "Error setting target: $err"
		exit 1
	}
	puts "programming [lindex $argv 1]"
	if { [ catch {fpga [lindex $argv 1]} err] } {
		puts "Error programming bitstream: $err"
		exit 1
	}
	puts "[fpga -state]"
}


