#!/bin/bash
# ============================================================
# 04 - LAÇOS DE REPETIÇÃO (for / while / until)
# ============================================================
# Laços repetem um bloco de comandos várias vezes.
# Úteis para processar listas, arquivos, contar, etc.
# ============================================================
 
 
# ============================================================
# EXEMPLO 1 - for com lista de valores
# ============================================================
 
for FRUTA in maçã banana laranja uva; do
    echo "Fruta: $FRUTA"
done
 
 
# ============================================================
# EXEMPLO 2 - for com sequência de números
# ============================================================
 
for i in $(seq 1 5); do
    echo "Contando: $i"
done
 
for ((i=1; i<=5; i++)); do
    echo "Valor: $i"
done
 
 
# ============================================================
# EXEMPLO 3 - for percorrendo arquivos de uma pasta
# ============================================================
 
echo "Arquivos na pasta atual:"
for ARQUIVO in *; do
    if [ -f "$ARQUIVO" ]; then
        echo "  $ARQUIVO"
    fi
done
 
 
# ============================================================
# EXEMPLO 4 - while
# ============================================================
 
CONTADOR=1
 
while [ $CONTADOR -le 5 ]; do
    echo "Contagem: $CONTADOR"
    CONTADOR=$((CONTADOR + 1))
done
 
 
# ============================================================
# EXEMPLO 5 - while com input do usuário
# ============================================================
 
while true; do
    read -rp "Digite 'sair' para parar: " RESPOSTA
    if [ "$RESPOSTA" = "sair" ]; then
        echo "Encerrando..."
        break
    fi
    echo "Você digitou: $RESPOSTA"
done
 
 
# ============================================================
# EXEMPLO 6 - until
# ============================================================
 
NUMERO=0
 
until [ $NUMERO -ge 5 ]; do
    echo "Número ainda menor que 5: $NUMERO"
    NUMERO=$((NUMERO + 1))
done
 
 
# ============================================================
# EXEMPLO 7 - continue
# ============================================================
 
echo "Números de 1 a 10, pulando os pares:"
for i in $(seq 1 10); do
    if [ $((i % 2)) -eq 0 ]; then
        continue
    fi
    echo "  $i"
done