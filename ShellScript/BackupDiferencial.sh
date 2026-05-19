#!/bin/bash
# TEMA 04 - Backup diferencial

ORIGEM=$1
DESTINO=$2

if [ -z "$ORIGEM" ] || [ -z "$DESTINO" ]; then
    echo "Uso: $0 <origem> <destino>"
    echo "     Para registrar backup completo: $0 <origem> <destino> --set-full"
    exit 1
fi

if [ ! -d "$ORIGEM" ]; then
    echo "Erro: diretório de origem não encontrado!"
    exit 1
fi

if [ ! -d "$DESTINO" ]; then
    mkdir "$DESTINO"
fi

# Arquivo que guarda a data do último backup COMPLETO
REFERENCIA="$DESTINO/.ultimo_backup_completo"

# Arquivo de log
LOG="$DESTINO/diferencial.log"

# Se o usuário passou --set-full, registra a data do backup completo e sai
if [ "$3" = "--set-full" ]; then
    date '+%Y%m%d_%H%M%S' > "$REFERENCIA"
    echo "Data do backup completo registrada: $(cat $REFERENCIA)"
    exit 0
fi

# Verifica se existe referência de backup completo
if [ ! -f "$REFERENCIA" ]; then
    echo "Nenhum backup completo registrado ainda."
    echo "Execute primeiro: $0 $ORIGEM $DESTINO --set-full"
    echo "Registrando data atual e copiando tudo..."
    date '+%Y%m%d_%H%M%S' > "$REFERENCIA"
fi

echo "Referência do último backup completo: $(cat $REFERENCIA)"
echo "$(date '+%d/%m/%Y %H:%M:%S') - Iniciando backup diferencial" >> $LOG

# Pasta onde os arquivos desta execução serão salvos
PASTA_ATUAL="$DESTINO/diff_$(date '+%Y%m%d_%H%M%S')"
mkdir "$PASTA_ATUAL"

# Cria um arquivo temporário com a data da referência
ARQUIVO_TEMP=$(mktemp)
touch -t "$(cat $REFERENCIA | tr -d '_' | sed 's/\(.\{8\}\)\(.\{6\}\)/\1\2/')" "$ARQUIVO_TEMP" 2>/dev/null || touch "$ARQUIVO_TEMP"

count=0

echo "Copiando arquivos alterados desde o último backup completo..."

# Copia tudo que foi modificado desde o backup completo
for ARQUIVO in $(find "$ORIGEM" -type f -newer "$ARQUIVO_TEMP"); do
    cp "$ARQUIVO" "$PASTA_ATUAL/"
    echo "$(date '+%d/%m/%Y %H:%M:%S') - COPIADO: $ARQUIVO" >> $LOG
    echo "Copiado: $ARQUIVO"
    count=$((count + 1))
done

rm "$ARQUIVO_TEMP"

# Tamanho do diferencial atual
TAMANHO_ATUAL=$(du -sb "$PASTA_ATUAL" | cut -f1)

# Tamanho total da origem (para calcular percentual)
TAMANHO_ORIGEM=$(du -sb "$ORIGEM" | cut -f1)

# Calcula o percentual
if [ $TAMANHO_ORIGEM -gt 0 ]; then
    PERCENTUAL=$((TAMANHO_ATUAL * 100 / TAMANHO_ORIGEM))
    echo "O diferencial representa $PERCENTUAL% do backup completo."

    # Alerta se passar de 80%
    if [ $PERCENTUAL -ge 80 ]; then
        echo "ALERTA: O diferencial está em $PERCENTUAL%! Considere fazer um novo backup completo."
        echo "$(date '+%d/%m/%Y %H:%M:%S') - ALERTA: diferencial em $PERCENTUAL%" >> $LOG
    fi
fi

echo ""
echo "===== RESUMO ====="
echo "Arquivos copiados: $count"
echo "Salvo em         : $PASTA_ATUAL"
echo "Log salvo em     : $LOG"
