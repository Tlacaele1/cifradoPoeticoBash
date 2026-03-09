#!/bin/bash

#Para la Wera, origen y destino de toda la poesía que fluye en mí#

generarHash() {
    local pass="$1"
    echo -n "$pass" | sha256sum | awk '{print $1}' | tr -d '[:space:]-'
}

cipher() {
    local message="$1"
    local hashpass="$2"
    local salt="$3"
    echo -n "$message" | openssl enc -aes-256-cbc -a -A -K "$hashpass" -iv "$salt"
}

menu_cifrado() {
    while true; do
        echo -n "Introduce la contraseña (mínimo 20 caracteres):"
        read -r password
        if [ "${#password}" -ge 20 ]; then
            break
        fi
        echo -e "\n[!]Error: la contraseña debe contener más de 20 caracteres"
    done
    hashpass=$(generarHash "$password")
    while true; do
        echo -n "¿Deseas abrir un editor de texto para tu mensaje (recomendado para mensajes largos)? S/N?"
        read -r response
        case "$response" in
            [sS])
                temp_file=$(mktemp)
                echo "Abriendo editor de texto para tu mensaje..."
                sleep 1
                nano "$temp_file"
                message=$(cat "$temp_file")
                rm "$temp_file"
                break
                ;;
            [nN])
                echo -n "Escribe el mensaje que se cifrará\n"
                read -r message
                break
                ;;
            *)
                echo -e "\n[!] Opción no válida. Escribe S o N."
                ;;
        esac
    done
    salt=$(openssl rand -hex 16)
    cipherMessage=$(cipher "$message" "$hashpass" "$salt")
    echo -n "Este es el mensaje cifrado:\n"
    echo "${salt}:${cipherMessage}"
}

menu_descifrado() {
    echo -n "Introduce la contraseña:"
    read -r password
    hashpass=$(generarHash "$password")
    echo "Pega el mensaje que quieres descifrar:\n"
    read cipherMessage
    salt=$(echo "$cipherMessage" | cut -d ':' -f 1)
    message=$(echo "$cipherMessage" | cut -d ':' -f 2)
    decipherMessage=$(echo -n "$message" | openssl enc -aes-256-cbc -d -a -A -K "$hashpass" -iv "$salt")
    echo "El mensaje original es:\n"
    echo "$decipherMessage"
}

mostrar_ayuda() {
    echo -e "--- SCRIPT DE CIFRADO POÉTICO ---"
    echo "Uso: $0 [-c | -d | -h]"
    echo "  -c : Cifrar un mensaje"
    echo "  -d : Descifrar un mensaje"
    echo "  -h : Mostrar esta ayuda"
    echo -e "\nConsejo: Usa versos de poemas, canciones o líneas de libros como contraseña. Son seguros y fáciles de recordar.\n"
    echo -n "\n[!]La seguridad de este cifrado depende casi exclusivamente del usuario.\n[!]NUNCA COMPARTAS LA CONTRASEÑA POR EL MISMO MEDIO QUE EL MENSAJE"
}

main() {
    case "$1" in
    -c) menu_cifrado;;
    -d) menu_descifrado;;
    -h|--help|"") mostrar_ayuda;;
    *) echo "Opción no válida. Usa la opción -h o --help para ver la ayuda"; exit 1;
esac
}

main "$1"
