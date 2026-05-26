# ============================================================
# EXERCÍCIO 1
# Peça um e-mail ao usuário e verifique se ele contém "@" e ".".
# Exiba se parece válido ou inválido.
# ============================================================
 
# RESOLUÇÃO:
read -rp "Digite um e-mail: " EMAIL
 
if [[ "$EMAIL" == *"@"* ]] && [[ "$EMAIL" == *"."* ]]; then
    echo "E-mail válido!"
else
    echo "E-mail inválido!"
fi
 
 
# ============================================================
# EXERCÍCIO 2
# Peça um nome completo ao usuário.
# Exiba o nome em maiúsculas e a quantidade de caracteres.
# ============================================================
 
# RESOLUÇÃO:
read -rp "Digite seu nome completo: " NOME
 
echo "Maiúsculas : ${NOME^^}"
echo "Caracteres : ${#NOME}"
 
 
# ============================================================
# EXERCÍCIO 3
# Dado o texto "2024-05-26", extraia e exiba separadamente:
# - O ano (2024)
# - O mês (05)
# - O dia (26)
# ============================================================
 
# RESOLUÇÃO:
DATA="2024-05-26"
 
ANO=$(echo "$DATA" | cut -d- -f1)
MES=$(echo "$DATA" | cut -d- -f2)
DIA=$(echo "$DATA" | cut -d- -f3)
 
echo "Ano: $ANO"
echo "Mês: $MES"
echo "Dia: $DIA"
 
 
# ============================================================
# EXERCÍCIO 4
# Leia o arquivo /etc/passwd e exiba apenas:
# - O nome do usuário (campo 1)
# - O diretório home (campo 6)
# Apenas para usuários comuns (UID >= 1000, campo 3)
# ============================================================
 
# RESOLUÇÃO:
echo "Usuários comuns e seus homes:"
awk -F: '$3 >= 1000 && $1 != "nobody" {print "Usuario: "$1" | Home: "$6}' /etc/passwd