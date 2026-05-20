#!/bin/bash
# Para agendar via cron (rodar todo dia às 02:00), execute:
#   crontab -e
# E adicione a linha:
#   0 2 * * * /caminho/para/tema12_simples.sh >> /var/log/limpeza.log 2>&1

LOG="/tmp/limpeza_$(date '+%Y%m%d_%H%M%S').log"

# Pastas que serão limpas
PASTAS="/tmp /var/tmp"

# Arquivos com mais de quantos dias serão removidos
DIAS=7

echo "================================"
echo "LIMPEZA DE ARQUIVOS TEMPORÁRIOS"
echo "Data: $(date '+%d/%m/%Y %H:%M:%S')"
echo "================================"
echo ""
echo "$(date '+%d/%m/%Y %H:%M:%S') - Iniciando limpeza" >> $LOG

# Primeiro mostra o que vai ser removido (prévia)
echo "===== PRÉVIA DO QUE SERÁ REMOVIDO ====="

count_total=0
espaco_total=0

for PASTA in $PASTAS; do

    if [ ! -d "$PASTA" ]; then
        echo "  Pasta não encontrada: $PASTA"
        continue
    fi

    count=0
    espaco=0

    for ARQUIVO in $(find "$PASTA" -maxdepth 2 -type f -mtime +$DIAS 2>/dev/null); do
        TAM=$(stat -c%s "$ARQUIVO" 2>/dev/null || echo 0)
        espaco=$((espaco + TAM))
        count=$((count + 1))
    done

    espaco_mb=$((espaco / 1024 / 1024))
    echo "  $PASTA: $count arquivo(s) | $espaco_mb MB a liberar"

    count_total=$((count_total + count))
    espaco_total=$((espaco_total + espaco))
done

espaco_total_mb=$((espaco_total / 1024 / 1024))
echo ""
echo "TOTAL: $count_total arquivo(s) | $espaco_total_mb MB a liberar"
echo ""

# Se rodar pelo terminal, pede confirmação
# Se rodar pelo cron, não tem terminal, então pula a pergunta
if [ -t 0 ]; then
    read -rp "Confirma a remoção? (s/N): " CONFIRMA
    if [ "$CONFIRMA" != "s" ] && [ "$CONFIRMA" != "S" ]; then
        echo "Operação cancelada."
        exit 0
    fi
fi

# Remove os arquivos
echo ""
echo "===== REMOVENDO ARQUIVOS ====="

count_removidos=0
espaco_removido=0

for PASTA in $PASTAS; do

    if [ ! -d "$PASTA" ]; then
        continue
    fi

    for ARQUIVO in $(find "$PASTA" -maxdepth 2 -type f -mtime +$DIAS 2>/dev/null); do
        TAM=$(stat -c%s "$ARQUIVO" 2>/dev/null || echo 0)

        rm "$ARQUIVO"

        if [ $? -eq 0 ]; then
            espaco_removido=$((espaco_removido + TAM))
            count_removidos=$((count_removidos + 1))
            echo "$(date '+%d/%m/%Y %H:%M:%S') - REMOVIDO: $ARQUIVO" >> $LOG
        fi
    done

done

espaco_removido_mb=$((espaco_removido / 1024 / 1024))

echo ""
echo "===== RESUMO ====="
echo "Arquivos removidos: $count_removidos"
echo "Espaço liberado   : $espaco_removido_mb MB"
echo "Log salvo em      : $LOG"

echo "$(date '+%d/%m/%Y %H:%M:%S') - FIM: $count_removidos arquivo(s), $espaco_removido_mb MB liberados" >> $LOG

echo ""
echo "DICA CRON - Para agendar automaticamente, execute: crontab -e"
echo "Adicione esta linha para rodar todo dia às 02:00:"
echo "  0 2 * * * $(realpath $0) >> /var/log/limpeza.log 2>&1"
