#!/bin/bash
# ============================================================
# 11 - ARRAYS (LISTAS)
# ============================================================
# Arrays guardam vários valores em uma só variável.
# Cada valor tem um índice que começa em 0.
# ============================================================
 
 
# ============================================================
# EXEMPLO 1 - Criar e acessar arrays
# ============================================================
 
FRUTAS=("maçã" "banana" "laranja" "uva" "melancia")
 
echo "Primeira fruta : ${FRUTAS[0]}"
echo "Segunda fruta  : ${FRUTAS[1]}"
echo "Última fruta   : ${FRUTAS[-1]}"
echo "Todas as frutas: ${FRUTAS[@]}"
echo "Total de frutas: ${#FRUTAS[@]}"
 
 
# ============================================================
# EXEMPLO 2 - Percorrer um array
# ============================================================
 
CORES=("vermelho" "verde" "azul" "amarelo")
 
for COR in "${CORES[@]}"; do
    echo "  - $COR"
done
 
for i in "${!CORES[@]}"; do
    echo "  $i: ${CORES[$i]}"
done
 
 
# ============================================================
# EXEMPLO 3 - Adicionar e remover elementos
# ============================================================
 
LISTA=("a" "b" "c")
LISTA+=("d" "e")
echo "Após adicionar: ${LISTA[@]}"
 
unset LISTA[1]
echo "Após remover: ${LISTA[@]}"
 
 
# ============================================================
# EXEMPLO 4 - Array associativo
# ============================================================
 
declare -A CAPITAIS
CAPITAIS["Brasil"]="Brasília"
CAPITAIS["França"]="Paris"
CAPITAIS["Japão"]="Tóquio"
 
echo "Capital do Brasil: ${CAPITAIS["Brasil"]}"
 
for PAIS in "${!CAPITAIS[@]}"; do
    echo "  $PAIS -> ${CAPITAIS[$PAIS]}"
done