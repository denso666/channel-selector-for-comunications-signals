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
