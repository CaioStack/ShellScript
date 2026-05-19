#!/bin/bash
# TEMA 01 - Organizador de arquivos por extensão

# Diretório que vai ser organizado (o usuário passa como argumento)
DIRETORIO=$1

# Se não passou nenhum diretório, usa o atual
if [ -z "$DIRETORIO" ]; then
    DIRETORIO="."
fi

# Verifica se o diretório existe
if [ ! -d "$DIRETORIO" ]; then
    echo "Erro: diretório não encontrado!"
    exit 1
fi

# Arquivo de log com data no nome
LOG="organizador_$(date '+%Y%m%d_%H%M%S').log"

# Contadores
count_imagens=0
count_documentos=0
count_videos=0
count_outros=0

echo "Iniciando organização em: $DIRETORIO"
echo "Início: $(date)" >> $LOG

# Cria as subpastas se não existirem
if [ ! -d "$DIRETORIO/imagens" ]; then
    mkdir "$DIRETORIO/imagens"
    echo "Pasta imagens criada"
fi

if [ ! -d "$DIRETORIO/documentos" ]; then
    mkdir "$DIRETORIO/documentos"
    echo "Pasta documentos criada"
fi

if [ ! -d "$DIRETORIO/videos" ]; then
    mkdir "$DIRETORIO/videos"
    echo "Pasta videos criada"
fi

if [ ! -d "$DIRETORIO/outros" ]; then
    mkdir "$DIRETORIO/outros"
    echo "Pasta outros criada"
fi

# Percorre cada arquivo do diretório
for ARQUIVO in "$DIRETORIO"/*; do

    # Ignora se for uma pasta
    if [ -d "$ARQUIVO" ]; then
        continue
    fi

    # Pega o nome do arquivo
    NOME=$(basename "$ARQUIVO")

    # Pega a extensão (tudo depois do último ponto)
    EXTENSAO="${NOME##*.}"

    # Converte para minúsculas
    EXTENSAO=$(echo "$EXTENSAO" | tr '[:upper:]' '[:lower:]')

    # Verifica se é imagem
    if [ "$EXTENSAO" = "jpg" ] || [ "$EXTENSAO" = "jpeg" ] || [ "$EXTENSAO" = "png" ] || [ "$EXTENSAO" = "gif" ] || [ "$EXTENSAO" = "bmp" ]; then
        mv "$ARQUIVO" "$DIRETORIO/imagens/$NOME"
        echo "$(date '+%d/%m/%Y %H:%M:%S') - MOVIDO para imagens: $NOME" >> $LOG
        count_imagens=$((count_imagens + 1))

    # Verifica se é documento
    elif [ "$EXTENSAO" = "pdf" ] || [ "$EXTENSAO" = "doc" ] || [ "$EXTENSAO" = "docx" ] || [ "$EXTENSAO" = "txt" ] || [ "$EXTENSAO" = "xls" ] || [ "$EXTENSAO" = "xlsx" ]; then
        mv "$ARQUIVO" "$DIRETORIO/documentos/$NOME"
        echo "$(date '+%d/%m/%Y %H:%M:%S') - MOVIDO para documentos: $NOME" >> $LOG
        count_documentos=$((count_documentos + 1))

    # Verifica se é vídeo
    elif [ "$EXTENSAO" = "mp4" ] || [ "$EXTENSAO" = "avi" ] || [ "$EXTENSAO" = "mkv" ] || [ "$EXTENSAO" = "mov" ]; then
        mv "$ARQUIVO" "$DIRETORIO/videos/$NOME"
        echo "$(date '+%d/%m/%Y %H:%M:%S') - MOVIDO para videos: $NOME" >> $LOG
        count_videos=$((count_videos + 1))

    # Qualquer outro arquivo vai para outros
    else
        mv "$ARQUIVO" "$DIRETORIO/outros/$NOME"
        echo "$(date '+%d/%m/%Y %H:%M:%S') - MOVIDO para outros: $NOME" >> $LOG
        count_outros=$((count_outros + 1))
    fi

done

# Mostra o resumo final
echo ""
echo "===== RESUMO ====="
echo "Imagens   : $count_imagens arquivo(s)"
echo "Documentos: $count_documentos arquivo(s)"
echo "Videos    : $count_videos arquivo(s)"
echo "Outros    : $count_outros arquivo(s)"
echo "Log salvo em: $LOG"
