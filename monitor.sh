#!/usr/bin/env bash

while true; do
	 clear
	echo " =========================================="
	echo " |  MONITOR EM TEMPO REAL  -- $(date +%H:%M:%S) -- |"
    	echo " =========================================="
	echo "Usuario: $(whoami)"
	echo "Computador: $(hostname)"


    	# CPU (usando o comando top para pegar a média)
    	echo -e "\n[CPU]"
	cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2+$4)}')
    	echo "Uso atual: ${cpu}%"
	
	if [ "$cpu" -gt 90 ]; then
		echo "ALERTA: CPU acima de 90%!"
	fi


    	# RAM
    	echo -e "\n[MEMÓRIA RAM]"
    	ram=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')
	echo "Uso atual: ${ram}%"

	if [ "$ram" -gt 85 ]; then
		echo "ALERTA: RAM acima de 85%!"
	fi


    	# DISCO
    	echo -e "\n[DISCO]"
    	disco=$(df -h --total | awk '/total/ {gsub("%"," ",$5); print $5}')
	echo "Uso total: ${disco}%"

	if [ "$disco" -gt 95 ]; then
		echo "ALERTA: Disco acima de 95%!"
	fi

    

    	# PROCESSOS
    	echo -e "\n[TOP 3 PROCESSOS (MEM)]"
    	ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 4

        echo -e "\n------------------------------------------"
        echo "|           (Ctrl+C para parar)          |"
        echo "------------------------------------------"

    	sleep 1
done
