#!/bin/bash
#Aquest script realitza tres funcions que donen la benvinguda al alumne que l'executa havent
#previament demanat el seu nom d'alumne, després li demana el nom de usuari per comprovar si existeix
#en /etc/passwd i després calcula l'espai restant lliure del disc amb df -h per mostrar en MB.
#Al final creo una funció final que engloba les altres tres per fer una interacció més neta amb l'usuari.

#Farem una funció de Benvinguda

benvinguda () {
	local nom="$1"
	echo "Hola $nom, anem a comprovar el sistema."
}

#Ara farem la funció de comprovar l'usuari

comprova_usuari () {
	local usuari="$1"
	if grep -q "^$usuari:" /etc/passwd; then
		echo "L'usuari '$usuari' si està al sistema."
	else
		echo "L'usuari '$usuari' no està al sistema."
	fi
}
#M'he informat amb la IA i he descobert que el -q amb el grep fa que no mostri el resultat del grep.
#grep serveix per poder buscar per les linies d'un fitxer un patró i cuan el troba el mostra.
#El ^ de la variable usuari fa que cuan es busqui l'usuari sigui si o si inici de linia.

#Ara fem una funció que calcula l'espai lliure del disc.
calculadora_espai () {
	echo ""
	echo "--- Espai de la partició principal (/) ---"
	df -h /
}
#df serveix per saber el espai de disc lliure (disk free).
# -h transforma les unitats de mesura de bytes a megabytes o gigabytes.

menu() {
    echo ""
    echo "=================================="
    echo "       MENÚ D'UTILITATS           "
    echo "=================================="
    echo "1. Mostrar missatge de benvinguda"
    echo "2. Comprovar si un usuari existeix"
    echo "3. Mostrar espai de disc de (/) "
    echo "4. Sortir"
    read -p "Tria una opció (1-4): " opcio

    case $opcio in
        1)
            read -p "Introdueix el teu nom: " nom_alumne
            benvinguda "$nom_alumne"
            ;;
        2)
            read -p "Introdueix el nom d'usuari a comprovar: " usuari_sistema
            comprova_usuari "$usuari_sistema"
            ;;
        3)
            calculadora_espai
            ;;
        4)
            echo "Sortint de l'script..."
            exit 0
            ;;
        *)
            echo "Error: Opció no vàlida. Has de triar un número entre l'1 i el 4."
            ;;
    esac
}

menu

#He creat una macrofucnió de menu que inclou les altres 3 i afegeix una opcio de sortir, si no es
#tria cap opcio que dono a escollir dona error, per ultim truquem la funcio menu per que s'activi.
