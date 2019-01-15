#!/bin/bash

if [ "$1" = "test" ]; then
        display=$(tty)
else
        display="/dev/tty1"
fi

foregrounds=("32" "33" "35" "36" "39")
RANDOM=1711

function random_color () {
        rfg=${foregrounds[$RANDOM % ${#foregrounds[@]}]}
        echo -en "\e[${rfg}m" > $display
}

while [ 1 ]; do

        # dayname
        clear > $display
        random_color
        date +"%A" | figlet -f bigmono9 > $display
        sleep 1

        # date
        clear > $display
        random_color
        date +" %d %m" | figlet -f mono9 > $display
        random_color
        date +"  %Y" | figlet -f mono9 > $display
        sleep 1

        # time
        clear > $display
        random_color
        date +" %H:%M" | figlet -f bigmono12  > $display

        # seconds
        now=$((10#$(date +%S)))
        for (( second = 1; second <= 59; ++second )); do
                if [ $second -lt 10 ]; then
                        fixed_second="0$second"
                else
                        fixed_second="$second"
                fi
                random_color
                echo -en " $fixed_second " > $display
                if [ $second -gt $now ]; then
                        sleep 1
                fi
        done
done
