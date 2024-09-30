#!/bin/bash
for (( ; ; ))
do
echo "Which command do you want to execute?"
echo "1. apt-get update"
echo "2. apt-get dist-upgrade"
echo "3. apt-get upgrade"
echo "4. Fast update with following commands: update, dist-upgrade and autoremove."
echo "5. apt autoremove"
echo "6. Go back to terminal."
read option
case "$option" in 
	"1") clear; sudo apt-get update; echo ; echo "The command apt update has been executed"; echo;;
	"2") clear; sudo apt-get dist-upgrade; echo; echo "The command apt-get dist-upgrade has been executed"; echo;;
	"3") clear; sudo apt-get upgrade; echo; echo "The command apt-get upgrade has been executed"; echo;;
	"4") clear; sudo apt-get update; sudo apt-get dist-upgrade; sudo apt autoremove; echo; echo "The following three commands were executed: update, dist-upgrade and autoremove."; echo;;
	"5") clear; sudo apt autoremove; echo; echo "The command apt autoremove has been executed"; echo;;
	"6") clear; exit;;
	*) clear; echo "Incorrect selection. Please, select the appropriate options."; echo;;
esac
done
