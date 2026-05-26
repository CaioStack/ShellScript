#!/bin/bash
# ============================================================
# 06 - MANIPULAÇÃO DE ARQUIVOS E DIRETÓRIOS
# ============================================================
 
 
# ============================================================
# EXEMPLO 1 - Criar, copiar, mover e remover arquivos
# ============================================================
 
touch /tmp/teste.txt
echo "Linha 1" > /tmp/teste.txt
echo "Linha 2" >> /tmp/teste.txt
cat /tmp/teste.txt
cp /tmp/teste.txt /tmp/copia.txt
mv /tmp/copia.txt /tmp/renomeado.txt
rm /tmp/renomeado.txt
 
 
# ============================================================
# EXEMPLO 2 - Criar e remover pastas
# ============================================================
 
mkdir /tmp/minha_pasta
mkdir -p /tmp/pai/filho/neto
rmdir /tmp/minha_pasta
rm -rf /tmp/pai
 
 
# ============================================================
# EXEMPLO 3 - Ler arquivo linha por linha
# ============================================================
 
echo "João" > /tmp/nomes.txt
echo "Maria" >> /tmp/nomes.txt
echo "Pedro" >> /tmp/nomes.txt
 
while read -r linha; do
    echo "  Nome: $linha"
done < /tmp/nomes.txt
 
 
# ============================================================
# EXEMPLO 4 - Informações sobre arquivos
# ============================================================
 
ARQUIVO="/etc/passwd"
 
if [ -f "$ARQUIVO" ]; then
    echo "$ARQUIVO existe!"
fi
 
TAMANHO=$(du -sh "$ARQUIVO" | cut -f1)
echo "Tamanho: $TAMANHO"
 
DATA=$(stat -c '%y' "$ARQUIVO" | cut -d'.' -f1)
echo "Modificado em: $DATA"
 
PERM=$(stat -c '%A %a' "$ARQUIVO")
echo "Permissões: $PERM"
 
LINHAS=$(wc -l < "$ARQUIVO")
echo "Linhas: $LINHAS"
 
 
# ============================================================
# EXEMPLO 5 - Buscar arquivos com find
# ============================================================
 
echo "Arquivos .txt em /tmp:"
find /tmp -name "*.txt" 2>/dev/null
 
echo "Pastas em /tmp:"
find /tmp -type d 2>/dev/null
 
echo "Arquivos recentes em /tmp:"
find /tmp -type f -mtime -2 2>/dev/null
 
 
# ============================================================
# EXEMPLO 6 - Redirecionar saída
# ============================================================
 
ls -la > /tmp/lista.txt
date | tee /tmp/data.txt
ls /pasta/que/nao/existe 2>/dev/null