#!/bin/bash
# Backup completo com rotação

# Diretório de origem (o que vai ser copiado)
ORIGEM=$1

# Diretório de destino (onde salvar o backup)
DESTINO=$2

# Se não passou os argumentos, mostra como usar
if [ -z "$ORIGEM" ] || [ -z "$DESTINO" ]; then
    echo "Uso: $0 <origem> <destino>"
    exit 1
fi

# Verifica se a origem existe
if [ ! -d "$ORIGEM" ]; then
    echo "Erro: diretório de origem não encontrado!"
    exit 1
fi

# Cria o destino se não existir
if [ ! -d "$DESTINO" ]; then
    mkdir "$DESTINO"
fi

# Arquivo de log
LOG="$DESTINO/backup.log"

# Nome do arquivo de backup com data e hora
NOME_BACKUP="backup_$(date '+%Y%m%d_%H%M%S').tar.gz"

echo "Iniciando backup de: $ORIGEM"
echo "Salvando em: $DESTINO/$NOME_BACKUP"

# Mostra espaço em disco ANTES da limpeza
echo ""
echo "===== ESPAÇO EM DISCO ANTES ====="
df -h "$DESTINO"

# Compacta o diretório de origem
tar -czf "$DESTINO/$NOME_BACKUP" "$ORIGEM"

# Verifica se o backup foi criado com sucesso
if [ $? -eq 0 ]; then
    echo "$(date '+%d/%m/%Y %H:%M:%S') - SUCESSO: $NOME_BACKUP criado" >> $LOG
    echo "Backup criado com sucesso!"
else
    echo "$(date '+%d/%m/%Y %H:%M:%S') - ERRO: falha ao criar $NOME_BACKUP" >> $LOG
    echo "Erro ao criar o backup!"
    exit 1
fi

# Mantém apenas as 5 cópias mais recentes
# Lista todos os backups do mais novo para o mais antigo
TOTAL=$(ls -t "$DESTINO"/backup_*.tar.gz 2>/dev/null | wc -l)

echo "Total de backups encontrados: $TOTAL"

# Se tiver mais de 5, remove os mais antigos
if [ $TOTAL -gt 5 ]; then
    echo "Removendo backups antigos..."

    # Pega os backups antigos (a partir do 6º)
    ls -t "$DESTINO"/backup_*.tar.gz | tail -n +6 | while read ARQUIVO_ANTIGO; do
        rm "$ARQUIVO_ANTIGO"
        echo "$(date '+%d/%m/%Y %H:%M:%S') - REMOVIDO: $(basename $ARQUIVO_ANTIGO)" >> $LOG
        echo "Removido: $(basename $ARQUIVO_ANTIGO)"
    done
fi

# Mostra espaço em disco DEPOIS da limpeza
echo ""
echo "===== ESPAÇO EM DISCO DEPOIS ====="
df -h "$DESTINO"

echo ""
echo "Log salvo em: $LOG"
