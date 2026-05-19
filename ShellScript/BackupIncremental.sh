#!/bin/bash
# TEMA 03 - Backup incremental

ORIGEM=$1
DESTINO=$2

if [ -z "$ORIGEM" ] || [ -z "$DESTINO" ]; then
    echo "Uso: $0 <origem> <destino>"
    exit 1
fi

if [ ! -d "$ORIGEM" ]; then
    echo "Erro: diretório de origem não encontrado!"
    exit 1
fi

if [ ! -d "$DESTINO" ]; then
    mkdir "$DESTINO"
fi

# Arquivo que guarda a data da última execução
CONTROLE="$DESTINO/.ultima_execucao"

# Arquivo de log
LOG="$DESTINO/incremental.log"

# Pasta onde os arquivos desta execução serão salvos
PASTA_ATUAL="$DESTINO/inc_$(date '+%Y%m%d_%H%M%S')"
mkdir "$PASTA_ATUAL"

echo "Iniciando backup incremental..."
echo "$(date '+%d/%m/%Y %H:%M:%S') - Iniciando backup incremental" >> $LOG

# Contador de arquivos copiados
count=0

# Verifica se existe uma execução anterior
if [ -f "$CONTROLE" ]; then
    echo "Última execução: $(cat $CONTROLE)"
    echo "Copiando apenas arquivos modificados desde a última execução..."

    # Copia apenas arquivos mais novos que o arquivo de controle
    for ARQUIVO in $(find "$ORIGEM" -type f -newer "$CONTROLE"); do
        cp "$ARQUIVO" "$PASTA_ATUAL/"
        echo "$(date '+%d/%m/%Y %H:%M:%S') - COPIADO: $ARQUIVO" >> $LOG
        echo "Copiado: $ARQUIVO"
        count=$((count + 1))
    done

else
    echo "Primeira execução! Copiando todos os arquivos..."

    # Copia todos os arquivos
    for ARQUIVO in $(find "$ORIGEM" -type f); do
        cp "$ARQUIVO" "$PASTA_ATUAL/"
        echo "$(date '+%d/%m/%Y %H:%M:%S') - COPIADO: $ARQUIVO" >> $LOG
        echo "Copiado: $ARQUIVO"
        count=$((count + 1))
    done
fi

# Calcula o tamanho total copiado
TAMANHO=$(du -sh "$PASTA_ATUAL" | cut -f1)

# Salva a data atual no arquivo de controle para a próxima execução
date '+%d/%m/%Y %H:%M:%S' > "$CONTROLE"

echo ""
echo "===== RESUMO ====="
echo "Arquivos copiados: $count"
echo "Tamanho total    : $TAMANHO"
echo "Salvo em         : $PASTA_ATUAL"
echo "Log salvo em     : $LOG"

echo "$(date '+%d/%m/%Y %H:%M:%S') - FIM: $count arquivo(s) copiados, tamanho: $TAMANHO" >> $LOG
