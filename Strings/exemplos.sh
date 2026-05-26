#!/bin/bash
# ============================================================
# 07 - STRINGS E MANIPULAÇÃO DE TEXTO
# ============================================================
 
 
# ============================================================
# EXEMPLO 1 - Tamanho de uma string
# ============================================================
 
TEXTO="Olá, mundo!"
echo "Texto: $TEXTO"
echo "Tamanho: ${#TEXTO} caracteres"
 
 
# ============================================================
# EXEMPLO 2 - Extrair parte de uma string
# ============================================================
 
TEXTO="Shell Script"
echo "Do início     : ${TEXTO:0:5}"
echo "A partir de 6 : ${TEXTO:6}"
echo "Últimos 6     : ${TEXTO: -6}"
 
 
# ============================================================
# EXEMPLO 3 - Maiúsculas e minúsculas
# ============================================================
 
NOME="joao silva"
echo "Maiúsculo : ${NOME^^}"
echo "Minúsculo : ${NOME,,}"
 
 
# ============================================================
# EXEMPLO 4 - Substituir texto
# ============================================================
 
FRASE="Eu gosto de gato"
echo "Trocado  : ${FRASE/gato/cachorro}"
echo "Trocado  : ${FRASE//o/0}"
 
 
# ============================================================
# EXEMPLO 5 - Remover parte de uma string
# ============================================================
 
ARQUIVO="documento.txt"
NOME="${ARQUIVO%.*}"
EXT="${ARQUIVO##*.}"
echo "Sem extensão: $NOME"
echo "Extensão: $EXT"
 
 
# ============================================================
# EXEMPLO 6 - Verificar se string contém texto
# ============================================================
 
EMAIL="joao@gmail.com"
if [[ "$EMAIL" == *"@"* ]]; then
    echo "'$EMAIL' parece um e-mail válido"
fi
 
 
# ============================================================
# EXEMPLO 7 - grep, cut, awk, sed
# ============================================================
 
grep "root" /etc/passwd
cut -d: -f1 /etc/passwd | head -5
awk -F: '{print $1, $7}' /etc/passwd | head -5
echo "root:x:0:0" | sed 's/root/ADMIN/'