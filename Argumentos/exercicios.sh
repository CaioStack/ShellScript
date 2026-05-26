# ============================================================
# EXERCÍCIO 1
# Crie um script que receba dois números como argumento
# e exiba a soma, subtração, multiplicação e divisão.
# Se não receber os dois argumentos, exiba como usar.
# ============================================================
 
# RESOLUÇÃO:
if [ $# -lt 2 ]; then
    echo "Uso: $0 <número1> <número2>"
    exit 1
fi
 
N1=$1
N2=$2
 
echo "Soma        : $((N1 + N2))"
echo "Subtração   : $((N1 - N2))"
echo "Multiplicação: $((N1 * N2))"
 
if [ $N2 -ne 0 ]; then
    echo "Divisão     : $((N1 / N2))"
else
    echo "Divisão     : impossível (divisão por zero)"
fi
 
 
# ============================================================
# EXERCÍCIO 2
# Crie um script que receba um caminho como argumento.
# - Se for um arquivo: mostre o tamanho e a data
# - Se for uma pasta: mostre quantos itens tem dentro
# - Se não existir: avise o usuário
# ============================================================
 
# RESOLUÇÃO:
CAMINHO="${1:-}"
 
if [ -z "$CAMINHO" ]; then
    echo "Uso: $0 <caminho>"
    exit 1
fi
 
if [ -f "$CAMINHO" ]; then
    echo "É um arquivo."
    echo "Tamanho : $(du -sh "$CAMINHO" | cut -f1)"
    echo "Modificado: $(stat -c '%y' "$CAMINHO" | cut -d'.' -f1)"
elif [ -d "$CAMINHO" ]; then
    ITENS=$(ls "$CAMINHO" | wc -l)
    echo "É uma pasta com $ITENS item(ns) dentro."
else
    echo "Caminho '$CAMINHO' não existe."
fi
 
 
# ============================================================
# EXERCÍCIO 3
# Crie um script que receba vários nomes como argumentos
# e exiba cada um numerado:
#   1. João
#   2. Maria
#   3. Pedro
# ============================================================
 
# RESOLUÇÃO:
CONTADOR=1
for NOME in "$@"; do
    echo "$CONTADOR. $NOME"
    CONTADOR=$((CONTADOR + 1))
done