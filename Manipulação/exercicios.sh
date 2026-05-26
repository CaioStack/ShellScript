# ============================================================
# EXERCÍCIO 1
# Crie um script que:
# 1. Crie uma pasta chamada "meus_arquivos" em /tmp
# 2. Crie 3 arquivos dentro dela (arquivo1.txt, arquivo2.txt, arquivo3.txt)
# 3. Escreva "Arquivo N" dentro de cada um
# 4. Liste o conteúdo da pasta
# ============================================================
 
# RESOLUÇÃO:
mkdir -p /tmp/meus_arquivos
 
echo "Arquivo 1" > /tmp/meus_arquivos/arquivo1.txt
echo "Arquivo 2" > /tmp/meus_arquivos/arquivo2.txt
echo "Arquivo 3" > /tmp/meus_arquivos/arquivo3.txt
 
echo "Conteúdo da pasta /tmp/meus_arquivos:"
ls /tmp/meus_arquivos
 
 
# ============================================================
# EXERCÍCIO 2
# Crie um script que leia um arquivo de texto
# e exiba quantas linhas ele tem,
# qual é a primeira linha e qual é a última.
# ============================================================
 
# RESOLUÇÃO:
ARQUIVO="/tmp/nomes.txt"
 
TOTAL=$(wc -l < "$ARQUIVO")
PRIMEIRA=$(head -1 "$ARQUIVO")
ULTIMA=$(tail -1 "$ARQUIVO")
 
echo "Total de linhas : $TOTAL"
echo "Primeira linha  : $PRIMEIRA"
echo "Última linha    : $ULTIMA"
 
 
# ============================================================
# EXERCÍCIO 3
# Crie um script que receba um diretório como argumento
# e liste separadamente:
# - Quantos arquivos tem
# - Quantas pastas tem
# - O tamanho total (du -sh)
# ============================================================
 
# RESOLUÇÃO:
DIR="${1:-/tmp}"
 
ARQUIVOS=$(find "$DIR" -maxdepth 1 -type f | wc -l)
PASTAS=$(find "$DIR" -maxdepth 1 -type d | wc -l)
TAMANHO=$(du -sh "$DIR" | cut -f1)
 
echo "Diretório : $DIR"
echo "Arquivos  : $ARQUIVOS"
echo "Pastas    : $PASTAS"
echo "Tamanho   : $TAMANHO"