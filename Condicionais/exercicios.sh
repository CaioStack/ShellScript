# ============================================================
# EXERCÍCIO 1
# Peça ao usuário para digitar um número.
# Diga se o número é positivo, negativo ou zero.
# ============================================================
 
# RESOLUÇÃO:
read -rp "Digite um número: " NUM
 
if [ $NUM -gt 0 ]; then
    echo "O número é positivo."
elif [ $NUM -lt 0 ]; then
    echo "O número é negativo."
else
    echo "O número é zero."
fi
 
 
# ============================================================
# EXERCÍCIO 2
# Peça uma senha ao usuário.
# Se for "admin123", exiba "Acesso permitido!".
# Caso contrário, exiba "Senha incorreta!".
# ============================================================
 
# RESOLUÇÃO:
read -rp "Digite a senha: " SENHA
 
if [ "$SENHA" = "admin123" ]; then
    echo "Acesso permitido!"
else
    echo "Senha incorreta!"
fi
 
 
# ============================================================
# EXERCÍCIO 3
# Peça ao usuário um caminho.
# Verifique e informe se é um arquivo, uma pasta ou se não existe.
# ============================================================
 
# RESOLUÇÃO:
read -rp "Digite um caminho: " CAMINHO
 
if [ -f "$CAMINHO" ]; then
    echo "'$CAMINHO' é um arquivo."
elif [ -d "$CAMINHO" ]; then
    echo "'$CAMINHO' é uma pasta."
else
    echo "'$CAMINHO' não existe."
fi
 
 
# ============================================================
# EXERCÍCIO 4
# Peça a idade do usuário.
# - Menor de 12: criança
# - Entre 12 e 17: adolescente
# - Entre 18 e 59: adulto
# - 60 ou mais: idoso
# ============================================================
 
# RESOLUÇÃO:
read -rp "Digite sua idade: " IDADE
 
if [ $IDADE -lt 12 ]; then
    echo "Criança"
elif [ $IDADE -lt 18 ]; then
    echo "Adolescente"
elif [ $IDADE -lt 60 ]; then
    echo "Adulto"
else
    echo "Idoso"
fi