#!/bin/bash
clear

while true;do
	menu()
	read -p "Selecccione una opcion" num
	case $num in
		1) fibonacci() ;;

		2) reverse_num() ;;

		3) is_palindrome() ;;

		7) exit_menu() break ;;

		8) echo "Opcion incorrecta"
	esac
done

function menu(){

	echo "Menu"
	echo "1. Pedir un numero entero y mostrar esa cantidad de elementos de la sucesion de Fibo"
	echo "2. Pedir un numero y mostrar por pantalla ese numero en forma invertida"
	echo "3. Pedir una cadena de caracteres y evaular si es palindomo o no"
	echo "4. Pedir el path a un archivo de texto y mostrar por pantalla la cantidad de lineas que tiene"
	echo "7. Salir"

}

function fibonacci(){
	aux1=0 #Primero de la serie
	aux2=1 #Segundo de la serie
	echo "Ingrese el numero para ver la serie: "
	read val
	echo "La serie es: "
	for ((i=0; i<$val; i++))
	do
		echo $aux1
		sec=$((aux1 + aux2))
		aux1=$aux2
		aux2=$sec
	done
}

function revert_num(){
	echo "Ingrese un numero a revertir"
	read num
	echo $num | rev
}

function exit_menu(){
	echo "Saludos $USER"
}
