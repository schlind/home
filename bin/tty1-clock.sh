#!/bin/bash
display="/dev/tty1"
#display=$(tty)
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
 if [ $(expr $i % 20) -eq 0 ]; then
  echo -en "\e[1m\e[33m $i\e[0m" > $display
  echo > $display
 elif [ $(expr $i % 10) -eq 0 ]; then
  echo -en "\e[1m\e[36m $i\e[0m" > $display
 else
  echo -en "\e[1m\e[32m $i\e[0m" > $display
 fi
}
function print_seconds {
 second=$((10#$(date +%S)))
 for (( i=1; i <= $second; ++i )); do print_second $i; done
 second=$(expr $second + 1)
 for (( i=$second; i <=59; ++i )); do print_second $i; sleep 1; done
}
function print_full_minute_action {
 cmatrix -o -b -u 2 -C white >  $display &
 sleep 2
 killall -q cmatrix
}
function print_reset {
 clear > $display
 echo -en "\e[0m" > $display
}
while [ 1 ]; do
 print_reset
 print_datetime
 print_seconds
 print_full_minute_action
done
