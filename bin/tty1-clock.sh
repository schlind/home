#!/bin/bash
display="/dev/tty1"
display=$(tty)
function print_datetime {
 echo  > $display
 echo -en "\e[1m\e[32m" > $display
 date  +"%A" | figlet -f bigascii9 > $display
 sleep 1
 clear > $display
 echo  > $display
 echo -en "\e[1m\e[36m" > $display
 date  +"%d.%m.%y" | figlet -f bigmono9 > $display
 echo -en "\e[0m" > $display
 sleep 1
 clear > $display
 echo  > $display
 echo -en "\e[1m\e[33m" > $display
 date  +"%H:%M"    | figlet -f bigascii12  > $display
 echo -en "\e[0m" > $display
}
function print_second {
 if [ $(expr $1 % 10) -eq 0 ]; then
  echo -en "\e[1m\e[33m$1\e[0m " > $display
  #echo > $display
 elif [ $(expr $1 % 5) -eq 0 ]; then
  echo -en "\e[1m\e[36m$1\e[0m " > $display
 else
  echo -en "\e[1m\e[32m$1\e[0m " > $display
 fi
}
function print_seconds {
 now=$((10#$(date +%S)))
 for (( second=1; second <= $now; ++second )); do print_second $second; done
 second=$(expr $second + 1)
 for (( ; second <=59; ++second )); do print_second $second; sleep 1; done
}
function print_reset {
 clear > $display
 echo -en "\e[0m" > $display
}
while [ 1 ]; do
 print_reset
 print_datetime
 print_seconds
done
