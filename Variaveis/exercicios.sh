# ============================================================
# EXERCÍCIO 1
# Crie variáveis com seu nome, curso e ano de início.
# Exiba uma frase usando as três variáveis.
# ============================================================
 
# RESOLUÇÃO:
NOME="João"
CURSO="Sistemas de Informação"
ANO=2023
 
echo "$NOME começou o curso de $CURSO em $ANO."
 
 
# ============================================================
# EXERCÍCIO 2
# Peça ao usuário para digitar dois números.
# Mostre a soma, subtração, multiplicação e divisão deles.
# ============================================================
 
# RESOLUÇÃO:
read -rp "Digite o primeiro número: " NUM1
read -rp "Digite o segundo número: " NUM2
 
echo "Soma        : $((NUM1 + NUM2))"
echo "Subtração   : $((NUM1 - NUM2))"
echo "Multiplicação: $((NUM1 * NUM2))"
echo "Divisão     : $((NUM1 / NUM2))"
 
 
# ============================================================
# EXERCÍCIO 3
# Guarde em uma variável a quantidade de arquivos
# que existe na sua pasta home ($HOME).
# Exiba: "Você tem X arquivos na sua pasta home."
# ============================================================
 
# RESOLUÇÃO:
TOTAL=$(ls "$HOME" | wc -l)
echo "Você tem $TOTAL arquivos na sua pasta home."
 
 
# ============================================================
# EXERCÍCIO 4
# Crie um script que calcule a média de 3 notas digitadas
# pelo usuário e exiba o resultado.
# ============================================================
 
# RESOLUÇÃO:
read -rp "Digite a nota 1: " NOTA1
read -rp "Digite a nota 2: " NOTA2
read -rp "Digite a nota 3: " NOTA3
 
MEDIA=$(( (NOTA1 + NOTA2 + NOTA3) / 3 ))
echo "Média: $MEDIA"