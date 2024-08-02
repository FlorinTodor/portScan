#!/bin/bash



  
function ctrl_c(){
  echo -e "\n\n[!] Saliendo....\n"
  tput cnorm;exit 1
  
}

# Ctrl+ C
trap ctrl_c INT
declare -a ports=($(seq 1 65535))
tput civis # Ocultamos el curso

## Ejemplo de funcionamiento
#for port in $(seq 1 65535); do 
  # Vamos a usar una bash shell y fijarnos en el caso de que sea exitoso 
 # (echo '' > /dev/tcp/127.0.0.1/$port) 2>/dev/null && echo "[+] El puerto $port está abierto" &
#done; wait


function checkPort(){
  host=$1;
  port=$2;
  (exec 3<> /dev/tcp/$host/$port) 2>/dev/null

  if [ $? -eq 0 ];then
    echo -e "[+] Host $host - Port $2 (OPEN)"
  fi 
  exec 3<&- 
  exec 3>&-
}


if [ $1 ]; then
  for port in ${ports[@]}; do 
    checkPort $1 $port &
  done
else 
  echo -e "\n\n [!] Uso: $0 <ip-address> \n"

fi

tput cnorm #Recuperamos el cursor
