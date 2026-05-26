# ============================================================
# EXERCÍCIO 1
# Exiba a tabuada de um número digitado pelo usuário (de 1 a 10).
# Exemplo para o número 5:
#   5 x 1 = 5
#   5 x 2 = 10 ...
# ============================================================
 
# RESOLUÇÃO:
read -rp "Digite um número para ver a tabuada: " NUM
 
for i in $(seq 1 10); do
    echo "$NUM x $i = $((NUM * i))"
done
 
 
# ============================================================
# EXERCÍCIO 2
# Peça ao usuário um número N.
# Some todos os números de 1 até N e exiba o resultado.
# ============================================================
 
# RESOLUÇÃO:
read -rp "Digite o número N: " N
 
SOMA=0
for i in $(seq 1 $N); do
    SOMA=$((SOMA + i))
done
 
echo "A soma de 1 até $N é: $SOMA"
 
 
# ============================================================
# EXERCÍCIO 3
# Liste todos os arquivos .sh da pasta atual usando for.
# Mostre o nome de cada arquivo encontrado.
# ============================================================
 
# RESOLUÇÃO:
echo "Arquivos .sh encontrados:"
for ARQUIVO in *.sh; do
    if [ -f "$ARQUIVO" ]; then
        echo "  $ARQUIVO"
    fi
done
 
 
# ============================================================
# EXERCÍCIO 4
# Crie um menu que fique rodando até o usuário escolher sair:
#   1 - Mostrar data
#   2 - Mostrar usuário
#   3 - Sair
# ============================================================
 
# RESOLUÇÃO:
while true; do
    echo ""
    echo "1 - Mostrar data"
    echo "2 - Mostrar usuário"
    echo "3 - Sair"
    read -rp "Escolha: " OPCAO
 
    if [ "$OPCAO" = "1" ]; then
        echo "Data: $(date '+%d/%m/%Y %H:%M:%S')"
    elif [ "$OPCAO" = "2" ]; then
        echo "Usuário: $USER"
    elif [ "$OPCAO" = "3" ]; then
        echo "Saindo..."
        break
    else
        echo "Opção inválida!"
    fi
done