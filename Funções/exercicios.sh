# ============================================================
# EXERCÍCIO 1
# Crie uma função chamada separador() que exiba uma linha
# de 40 traços: ----------------------------------------
# Use-a para separar seções na tela.
# ============================================================
 
# RESOLUÇÃO:
separador() {
    echo "----------------------------------------"
}
 
separador
echo "Seção 1"
separador
echo "Seção 2"
separador
 
 
# ============================================================
# EXERCÍCIO 2
# Crie uma função chamada eh_par() que recebe um número
# e diz se ele é par ou ímpar.
# ============================================================
 
# RESOLUÇÃO:
eh_par() {
    NUM=$1
    if [ $((NUM % 2)) -eq 0 ]; then
        echo "$NUM é par."
    else
        echo "$NUM é ímpar."
    fi
}
 
eh_par 4
eh_par 7
eh_par 10
 
 
# ============================================================
# EXERCÍCIO 3
# Crie uma função calcular_media() que recebe 3 notas
# como parâmetros e retorna a média.
# ============================================================
 
# RESOLUÇÃO:
calcular_media() {
    MEDIA=$(( ($1 + $2 + $3) / 3 ))
    echo $MEDIA
}
 
RESULTADO=$(calcular_media 8 6 10)
echo "Média: $RESULTADO"
 
 
# ============================================================
# EXERCÍCIO 4
# Crie um script com um menu interativo usando funções:
#   1 - Mostrar data e hora  -> função mostrar_data()
#   2 - Mostrar usuário      -> função mostrar_usuario()
#   3 - Listar arquivos      -> função listar_arquivos()
#   4 - Sair
# ============================================================
 
# RESOLUÇÃO:
mostrar_data() {
    echo "Data e hora: $(date '+%d/%m/%Y %H:%M:%S')"
}
 
mostrar_usuario() {
    echo "Usuário: $USER"
    echo "Home   : $HOME"
}
 
listar_arquivos() {
    echo "Arquivos na pasta atual:"
    ls
}
 
while true; do
    echo ""
    echo "1 - Mostrar data e hora"
    echo "2 - Mostrar usuário"
    echo "3 - Listar arquivos"
    echo "4 - Sair"
    read -rp "Escolha: " OPCAO
 
    if [ "$OPCAO" = "1" ]; then
        mostrar_data
    elif [ "$OPCAO" = "2" ]; then
        mostrar_usuario
    elif [ "$OPCAO" = "3" ]; then
        listar_arquivos
    elif [ "$OPCAO" = "4" ]; then
        echo "Saindo..."
        break
    else
        echo "Opção inválida!"
    fi
done