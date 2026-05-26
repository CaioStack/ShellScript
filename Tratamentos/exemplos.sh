#!/bin/bash
# ============================================================
# 12 - TRATAMENTO DE ERROS E BOAS PRÁTICAS
# ============================================================
 
 
# ============================================================
# EXEMPLO 1 - Verificar código de saída ($?)
# ============================================================
 
mkdir /tmp/pasta_teste 2>/dev/null
 
if [ $? -eq 0 ]; then
    echo "Pasta criada com sucesso!"
else
    echo "Erro ao criar a pasta (já existe?)"
fi
 
 
# ============================================================
# EXEMPLO 2 - Verificar antes de executar
# ============================================================
 
ARQUIVO="/tmp/dados.txt"
 
if [ ! -f "$ARQUIVO" ]; then
    echo "Erro: arquivo '$ARQUIVO' não encontrado!"
    exit 1
fi
 
 
# ============================================================
# EXEMPLO 3 - Mensagens de erro para stderr
# ============================================================
 
echo "Mensagem normal"
echo "Mensagem de erro" >&2
 
 
# ============================================================
# EXEMPLO 4 - Trap
# ============================================================
 
trap 'echo "Script encerrado em: $(date)"' EXIT
trap 'echo "Interrompido pelo usuário!"; exit 1' INT
 
 
# ============================================================
# EXEMPLO 5 - Arquivo temporário com limpeza automática
# ============================================================
 
TEMP=$(mktemp)
trap 'rm -f "$TEMP"' EXIT
 
echo "dados importantes" > "$TEMP"
cat "$TEMP"
 
 
# ============================================================
# EXEMPLO 6 - Verificar dependências
# ============================================================
 
for CMD in grep awk curl; do
    if ! command -v "$CMD" > /dev/null 2>&1; then
        echo "Erro: '$CMD' não está instalado!"
        exit 1
    fi
done
 
echo "Todas as dependências estão OK!"