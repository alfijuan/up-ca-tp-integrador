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
	aux1=0 # First of serie
	aux2=1 # Second of serie
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

function reverse_num(){
	read -p "Ingrese un numero a revertir: " num
	# rev returns the reverse of the given parameters
	echo $num | rev
}

function is_palindrome(){
	read -p "Ingrese una cadena de texto: " text
	aux=$($text | rev)
#	echo $aux
#	if [ $aux == $text ]
#	then
#		echo "Es palindromo"
#	else
#		echo "No es palindromo"
#	fi
}

function file_lines_length(){
	read -p "Ingrese la ruta al archivo: " file
	echo $(wc -l $file)
}

function order_numbers(){
	echo "Order numbers"
	n=""
	# seq gives a range of numbers
	for i in `seq 1 5`;
	do
		read -p "Ingrese un numero: " num
		# Save all num in same string separate by space
		n="${n} ${num}"
	done
	# tr => replace spaces with line breaks and sort -g for numeric values
	echo $n | tr " " "\n" | sort -g
}

function show_files_directory(){
	read -p "Ingrese un directorio: " NOMBRE_DIR
	if [ -d "$NOMBRE_DIR" ]; then
		cd "$NOMBRE_DIR"
		echo "Archivos regulares: " `find . -maxdepth 1 -type f|wc -l`
		echo "Directorios: " `find . -maxdepth 1 -type d|wc -l`
		echo "Link simbólicos: " `find . -maxdepth 1 -type l|wc -l`
		echo "Pipes: " `find . -maxdepth 1 -type p|wc -l`
		echo "Archivos de caracteres: " `find . -maxdepth 1 -type c|wc -l`
		echo "Archivos de bloque: " `find . -maxdepth 1 -type b|wc -l`
		echo "Sockets: " `find . -maxdepth 1 -type s|wc -l`
	else
		echo "No existe directorio"
	fi
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

		7) exit_menu
		break;;

		*) echo "Opcion incorrecta"
	esac
	printf "\n\n"
done
