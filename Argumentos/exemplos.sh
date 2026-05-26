#!/bin/bash
# ============================================================
# 08 - ARGUMENTOS E PARÂMETROS
# ============================================================
# Argumentos são informações passadas para o script
# na hora de executar:
#   ./script.sh arg1 arg2 arg3
#
# Variáveis especiais:
#   $0  -> nome do script
#   $1  -> primeiro argumento
#   $2  -> segundo argumento
#   $@  -> todos os argumentos
#   $#  -> quantidade de argumentos
#   $?  -> código de saída do último comando (0 = sucesso)
# ============================================================
 
 
# ============================================================
# EXEMPLO 1 - Acessando argumentos
# ============================================================
 
echo "Nome do script : $0"
echo "1º argumento   : $1"
echo "2º argumento   : $2"
echo "Total de args  : $#"
echo "Todos os args  : $@"
 
 
# ============================================================
# EXEMPLO 2 - Verificar se argumentos foram passados
# ============================================================
 
if [ -z "$1" ]; then
    echo "Nenhum argumento passado."
fi
 
 
# ============================================================
# EXEMPLO 3 - Percorrer todos os argumentos
# ============================================================
 
echo "Argumentos recebidos:"
for ARG in "$@"; do
    echo "  - $ARG"
done
 
 
# ============================================================
# EXEMPLO 4 - Valor padrão quando argumento não é passado
# ============================================================
 
NOME="${1:-Visitante}"
CIDADE="${2:-Fortaleza}"
echo "Olá, $NOME de $CIDADE!"
 
 
# ============================================================
# EXEMPLO 5 - Código de saída ($?)
# ============================================================
 
ls /tmp > /dev/null 2>&1
echo "ls /tmp - Código: $?"
 
ls /pasta/inexistente > /dev/null 2>&1
echo "ls /inexistente - Código: $?"