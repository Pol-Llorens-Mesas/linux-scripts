#!/bin/bash

# Aquest script realitza tres funcions que donen la benvinguda
# a l'alumne, comproven si un usuari existeix a /etc/passwd
# i mostren l'espai lliure del disc.
# També permet executar les opcions mitjançant paràmetres.


# Farem una funció de Benvinguda

benvinguda() {
    local nom="$1"

    echo "Hola $nom, anem a comprovar el sistema."
}


# Ara farem la funció de comprovar l'usuari

comprova_usuari() {
    local usuari="$1"

    if grep -q "^$usuari:" /etc/passwd; then
        echo "L'usuari '$usuari' si està al sistema."
    else
        echo "L'usuari '$usuari' no està al sistema."
    fi
}

# El -q del grep fa que no es mostri el resultat de la cerca.
# El ^ fa que el usuari s'hagi de trobar al inici de la línia.


# Ara fem una funció que calcula l'espai lliure del disc.

calculadora_espai() {
    local particio="/"

    echo ""
    echo "--- Espai de la partició principal ($particio) ---"
    df -h "$particio"
}

# df serveix per saber l'espai lliure del disc.
# El -h mostra les unitats d'una manera més fàcil de llegir,
# com ara MB o GB, segons la mida.


# Ara fem una funció per mostrar les opcions del menú.

mostrar_menu() {
    echo ""
    echo "=================================="
    echo "       MENÚ D'UTILITATS           "
    echo "=================================="
    echo "1. Mostrar missatge de benvinguda"
    echo "2. Comprovar si un usuari existeix"
    echo "3. Mostrar espai de disc de (/)"
    echo "4. Sortir"
    echo "=================================="
}


# Aquesta funció executa la opció que ha escollit l'usuari.
# Rep com a paràmetre el número de l'opció.

executar_opcio() {
    local opcio="$1"
    local nom_alumne
    local usuari_sistema

    case "$opcio" in
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
            return 1
            ;;
        *)
            echo "Error: Opció no vàlida. Has de triar un número entre l'1 i el 4."
            ;;
    esac

    return 0
}


# Aquesta funció executa una opció mitjançant paràmetres.
# $1 és l'opció i $2 és el argument, si és necessari.

executar_parametre() {
    local opcio="$1"
    local argument="$2"

    case "$opcio" in
        1)
            benvinguda "$argument"
            ;;
        2)
            comprova_usuari "$argument"
            ;;
        3)
            calculadora_espai
            ;;
        -a)
            benvinguda "$argument"
            ;;
        *)
            echo "Error: Opció no vàlida."
            echo "Exemple: ./menu.sh 1 \"Salvador Rueda\""
            echo "Exemple: ./menu.sh -a \"Salvador Rueda\""
            return 1
            ;;
    esac

    return 0
}


# A partir d'aquí comença la part principal de el script.

# Si s'han introduït paràmetres, executem directament la opció.

if [ "$#" -gt 0 ]; then
    executar_parametre "$1" "$2"
    exit $?
fi


# Si no s'han introduït paràmetres, mostrem el menú interactiu.
# El menú es repetirà fins que l'usuari esculli la opció de sortir.

while true; do
    clear
    mostrar_menu

    read -p "Tria una opció (1-4): " opcio

    executar_opcio "$opcio"
    resultat=$?

    if [ "$resultat" -eq 1 ]; then
        break
    fi

    echo ""
    read -p "Prem ENTER per continuar..."
done
