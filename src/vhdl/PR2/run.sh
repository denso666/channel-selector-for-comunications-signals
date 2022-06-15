#!/bin/bash

# folders
f_vcd=./vcds
f_mod=./modules
f_tbs=./tbs

# script arguments
args=$@

# colors
reset=`tput sgr0`
red=`tput setaf 5`
blue=`tput setaf 6`
green=`tput setaf 2`

# module conf
MOD="unknown"
TIME=0ns

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

# analize and make single entity
function compile_single {
	if [[ MOD == "unknown" ]]; then
		echo "${red}@ ERROR: Module not found${reset}"
	else
		ghdl -a ${f_mod}/${MOD}.vhdl ${f_tbs}/TB_${MOD}.vhdl 2> error

		if [[ "$(wc -l error)" != "0 error" ]]; then
			echo "${red}$(cat error)${reset}"
		else
			echo "${green}@ ${MOD}: Correctly compiled${reset}"
			ghdl -e TB_${MOD}
			ghdl -r TB_${MOD} --vcd=${MOD}.vcd --stop-time=${TIME}
			mv ${MOD}.vcd ${f_vcd}/
		fi

		rm error
	fi
}

# analize and make top level entity
function compile_topl {
	ghdl -a ${f_mod}/*.vhdl ${f_tbs}/TB_PR2.vhdl 2> error

	if [[ "$(wc -l error)" != "0 error" ]]; then
		echo "${red}$(cat error)${reset}"
	else
		echo "${green}@ PR2: Correctly compiled${reset}"
		ghdl -e TB_PR2
		ghdl -r TB_PR2 --vcd=PR2.vcd --stop-time=500ns
		mv ./PR2.vcd ${f_vcd}/
	fi

	rm error
}

function main {
	case ${args[0]} in

		"help" | "h")
			help
	    ;;
	  	"count" | "c")
			MOD=COUNTER
			TIME=600ns
	    	compile_single
	    ;;
	  	"reg" | "r")
			MOD=REG
			TIME=200ns
	    	compile_single
	    ;;
	    "add" | "a")
			MOD=ADDER
			TIME=40ns
	    	compile_single
	    ;;
	    "sqr" | "s")
			MOD=SQUARE
			TIME=40ns
	    	compile_single
	    ;;
	    "topl" | "t")
	    	compile_topl
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