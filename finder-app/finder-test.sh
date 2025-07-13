#!/bin/sh
# Configuración
NUMFILES=10
WRITESTR=AELD_IS_FUN
WRITEDIR=/tmp/aeld-data
username=$(cat ../conf/username.txt)

# Limpieza y compilación
make clean
make

# Crear directorio
mkdir -p "$WRITEDIR"

# Escribir archivos
for i in $(seq 1 $NUMFILES); do
    ./writer "$WRITEDIR/${username}$i.txt" "$WRITESTR"
done

# Verificar resultados
OUTPUTSTRING=$(./finder.sh "$WRITEDIR" "$WRITESTR")
MATCHSTR="The number of files are ${NUMFILES} and the number of matching lines are ${NUMFILES}"

# Mostrar éxito/fallo
if echo "$OUTPUTSTRING" | grep -q "$MATCHSTR"; then
    echo "success"
    exit 0
else
    echo "failed: expected '$MATCHSTR' but got '$OUTPUTSTRING'"
    exit 1
fi