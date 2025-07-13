#!/bin/sh

# Verificar argumentos
if [ $# -ne 2 ]; then
    echo "Error: Se requieren 2 argumentos - <directorio> <cadena>"
    exit 1
fi

filesdir="$1"
searchstr="$2"

# Verificar si el directorio existe
if [ ! -d "$filesdir" ]; then
    echo "Error: El directorio $filesdir no existe"
    exit 1
fi

# Contar archivos y líneas coincidentes
filecount=$(find "$filesdir" -type f | wc -l)
linecount=$(grep -r "$searchstr" "$filesdir" | wc -l)

# Mostrar resultados
echo "The number of files are $filecount and the number of matching lines are $linecount"