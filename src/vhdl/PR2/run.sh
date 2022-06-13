#!/bin/bash

# folders
f_vcd=../VCD

# script arguments
args=$@

# colors
reset=`tput sgr0`
red=`tput setaf 5`
blue=`tput setaf 6`
green=`tput setaf 2`

# provide a structure of command
function help {
	echo "Commandas( all make commands include test bench and vcd ):${reset}"
	echo "-> ${green}'count'	${reset}to analize and make counter entity"
	echo "-> ${green}'reg  '	${reset}to analize and make register entity"
	echo "-> ${green}'add  '	${reset}to analize and make adder entity"
	echo "-> ${green}'sqr  '	${reset}to analize and make square entity"
	echo "-> ${green}'topl '	${reset}to analize and make top level entity"
	echo "-> ${green}'clean'	${reset}to remove all .vcd and .cf files"
}

# analize and make counter entity
function compile_count {
	ghdl -a ./COUNTER.vhdl ./TB_COUNTER.vhdl 2> error

	if [[ "$(wc -l error)" != "0 error" ]]; then
		echo "${red}$(cat error)${reset}"
	else
		echo "${green}@ COUNTER: Correctly compiled${reset}"
		ghdl -e TB_COUNTER
		ghdl -r TB_COUNTER --vcd=COUNTER.vcd --stop-time=600ns
		cp ./COUNTER.vcd ${f_vcd}/
	fi

	rm error
}
# analize and make register entity
function compile_reg {
	ghdl -a ./REG.vhdl ./TB_REG.vhdl 2> error

	if [[ "$(wc -l error)" != "0 error" ]]; then
		echo "${red}$(cat error)${reset}"
	else
		echo "${green}@ REGISTER: Correctly compiled${reset}"
		ghdl -e TB_REG
		ghdl -r TB_REG --vcd=REG.vcd --stop-time=600ns
		cp ./REG.vcd ${f_vcd}/
	fi

	rm error
}
# analize and make adder entity
function compile_add {
	ghdl -a ./ADDER.vhdl ./TB_ADDER.vhdl 2> error

	if [[ "$(wc -l error)" != "0 error" ]]; then
		echo "${red}$(cat error)${reset}"
	else
		echo "${green}@ ADDER: Correctly compiled${reset}"
		ghdl -e TB_ADDER
		ghdl -r TB_ADDER --vcd=ADDER.vcd --stop-time=40ns
		cp ./ADDER.vcd ${f_vcd}/
	fi

	rm error
}
# analize and make adder entity
function compile_sqr {
	ghdl -a ./SQUARE.vhdl ./TB_SQUARE.vhdl 2> error

	if [[ "$(wc -l error)" != "0 error" ]]; then
		echo "${red}$(cat error)${reset}"
	else
		echo "${green}@ SQUARE: Correctly compiled${reset}"
		ghdl -e TB_SQUARE
		ghdl -r TB_SQUARE --vcd=SQUARE.vcd --stop-time=40ns
		cp ./SQUARE.vcd ${f_vcd}/
	fi

	rm error
}
# analize and make top level entity
function compile_topl {
	ghdl -a ./ADDER.vhdl ./COUNTER.vhdl ./MUX.vhdl ./REG.vhdl ./SQUARE.vhdl ./PR2.vhdl ./PR2.vhdl ./TB_PR2.vhdl 2> error

	if [[ "$(wc -l error)" != "0 error" ]]; then
		echo "${red}$(cat error)${reset}"
	else
		echo "${green}@ PR2: Correctly compiled${reset}"
		ghdl -e TB_PR2
		ghdl -r TB_PR2 --vcd=PR2.vcd --stop-time=400ns
		cp ./PR2.vcd ${f_vcd}/
	fi

	rm error
}

function main {
	case ${args[0]} in

		"help" | "h")
			help
	    ;;
	  	"count")
	    	compile_count
	    ;;
	  	"reg")
	    	compile_reg
	    ;;
	    "add")
	    	compile_add
	    ;;
	    "sqr")
	    	compile_sqr
	    ;;
	    "topl")
	    	topl
	    ;;
		"clean")
	    	rm *.vcd *.cf
	    ;;
	  	*)
	    	help
	    ;;
	esac
}

main
