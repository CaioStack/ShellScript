# ============================================================
# EXERCÍCIO 1
# Crie um array com 5 nomes de cidades.
# Exiba cada cidade numerada de 1 a 5.
# Exiba também quantas cidades tem no total.
# ============================================================
 
# RESOLUÇÃO:
CIDADES=("Fortaleza" "São Paulo" "Rio de Janeiro" "Recife" "Salvador")
 
for i in "${!CIDADES[@]}"; do
    echo "$((i + 1)). ${CIDADES[$i]}"
done
 
echo "Total: ${#CIDADES[@]} cidades"
 
 
# ============================================================
# EXERCÍCIO 2
# Crie um array com 5 números.
# Calcule e exiba a soma e a média dos valores.
# ============================================================
 
# RESOLUÇÃO:
NUMEROS=(10 20 30 40 50)
 
SOMA=0
for NUM in "${NUMEROS[@]}"; do
    SOMA=$((SOMA + NUM))
done
 
MEDIA=$((SOMA / ${#NUMEROS[@]}))
 
echo "Soma  : $SOMA"
echo "Média : $MEDIA"
 
 
# ============================================================
# EXERCÍCIO 3
# Crie um array associativo com nome e nota de 4 alunos.
# Exiba os alunos aprovados (nota >= 7) e reprovados.
# ============================================================
 
# RESOLUÇÃO:
declare -A NOTAS
NOTAS["João"]=8
NOTAS["Maria"]=5
NOTAS["Pedro"]=7
NOTAS["Ana"]=4
 
echo "Aprovados:"
for ALUNO in "${!NOTAS[@]}"; do
    if [ "${NOTAS[$ALUNO]}" -ge 7 ]; then
        echo "  $ALUNO - Nota: ${NOTAS[$ALUNO]}"
    fi
done
 
echo "Reprovados:"
for ALUNO in "${!NOTAS[@]}"; do
    if [ "${NOTAS[$ALUNO]}" -lt 7 ]; then
        echo "  $ALUNO - Nota: ${NOTAS[$ALUNO]}"
    fi
done
 
 
# ============================================================
# EXERCÍCIO 4
# Leia a lista de usuários do /etc/passwd,
# armazene os nomes em um array e exiba:
# - Total de usuários
# - O primeiro e o último da lista
# ============================================================
 
# RESOLUÇÃO:
mapfile -t USUARIOS < <(cut -d: -f1 /etc/passwd)
 
echo "Total de usuários : ${#USUARIOS[@]}"
echo "Primeiro          : ${USUARIOS[0]}"
echo "Último            : ${USUARIOS[-1]}"