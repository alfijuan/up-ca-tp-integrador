#!/bin/bash

clear

function show_menu(){

	echo "Menu"
	echo "1. Pedir un numero entero y mostrar esa cantidad de elementos de la sucesion de Fibo"
	echo "2. Pedir un numero y mostrar por pantalla ese numero en forma invertida"
	echo "3. Pedir una cadena de caracteres y evaular si es palindomo o no"
	echo "4. Pedir el path a un archivo de texto y mostrar por pantalla la cantidad de lineas que tiene"
	echo "5. Pedir el ingreso de 5 numeros enteros y mostrarlos por pantalla en forma ordenada"
	echo "6. Pedir el path a un directorio y mostrar por pantalla cuantos archivos de cada tipo contiene"
	echo "7. Salir"

}

function fibonacci(){
	aux1=0 #Primero de la serie
	aux2=1 #Segundo de la serie
	read -p "Ingrese el numero para ver la serie: " val
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
	read -p "Ingrese un numero a revertir: " num
	echo $num | rev
}

function is_palindrome(){
	read -p "Ingrese cualquier tipo de texto: " $text
	
}

function file_lines_length(){
	echo "File lines length"
}

function order_numbers(){
	echo "Order numbers"
}

function show_files_directory(){
	echo "Files in directory"
}

function exit_menu(){
	echo "Saludos $USER"
}

while true;do
	show_menu

	read -p "Selecccione una opcion: " num

	case $num in
		1) fibonacci ;;

		2) reverse_num ;;

		3) is_palindrome ;;

		4) file_lines_length ;;

		5) order_numbers ;;

		6) show_files_directory ;;

		7) exit_menu break ;;

		8) echo "Opcion incorrecta" ;;
	esac
done
