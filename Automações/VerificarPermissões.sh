#!/bin/bash
# TEMA 06 - Verificador de permissões de arquivos

DIRETORIO=$1

if [ -z "$DIRETORIO" ]; then
    DIRETORIO="."
fi

if [ ! -d "$DIRETORIO" ]; then
    echo "Erro: diretório não encontrado!"
    exit 1
fi

RELATORIO="relatorio_permissoes_$(date '+%Y%m%d_%H%M%S').txt"

echo "================================" | tee $RELATORIO
echo "VERIFICADOR DE PERMISSÕES"       | tee -a $RELATORIO
echo "Data: $(date '+%d/%m/%Y %H:%M:%S')" | tee -a $RELATORIO
echo "Diretório: $DIRETORIO"           | tee -a $RELATORIO
echo "================================" | tee -a $RELATORIO

# ===== PARTE 1: arquivos com escrita para todos (o+w) =====
echo "" | tee -a $RELATORIO
echo "===== ARQUIVOS COM ESCRITA PARA TODOS (777 ou o+w) =====" | tee -a $RELATORIO

count_ow=0

for ARQUIVO in $(find "$DIRETORIO" -type f -perm -o+w); do
    PERMISSAO=$(stat -c '%A %a' "$ARQUIVO")
    echo "  Arquivo   : $ARQUIVO"       | tee -a $RELATORIO
    echo "  Permissão : $PERMISSAO"     | tee -a $RELATORIO

    # Pergunta se quer corrigir
    read -rp "  Deseja corrigir? (s/N): " RESPOSTA

    if [ "$RESPOSTA" = "s" ] || [ "$RESPOSTA" = "S" ]; then
        ANTES=$(stat -c '%a' "$ARQUIVO")
        chmod 644 "$ARQUIVO"
        DEPOIS=$(stat -c '%a' "$ARQUIVO")
        echo "  CORRIGIDO: $ANTES -> $DEPOIS" | tee -a $RELATORIO
    else
        echo "  IGNORADO" | tee -a $RELATORIO
    fi

    echo "" | tee -a $RELATORIO
    count_ow=$((count_ow + 1))
done

if [ $count_ow -eq 0 ]; then
    echo "  Nenhum arquivo com esse problema." | tee -a $RELATORIO
fi

# ===== PARTE 2: arquivos sem permissão para o dono =====
echo "" | tee -a $RELATORIO
echo "===== ARQUIVOS SEM PERMISSÃO PARA O DONO =====" | tee -a $RELATORIO

count_sem=0

for ARQUIVO in $(find "$DIRETORIO" -type f); do
    # Pega o número da permissão
    PERM=$(stat -c '%a' "$ARQUIVO")
    # O primeiro dígito é a permissão do dono
    DONO=${PERM:0:1}

    # Se o dono não tem nenhuma permissão (0)
    if [ "$DONO" = "0" ]; then
        PERMISSAO=$(stat -c '%A %a' "$ARQUIVO")
        echo "  Arquivo   : $ARQUIVO"       | tee -a $RELATORIO
        echo "  Permissão : $PERMISSAO"     | tee -a $RELATORIO

        read -rp "  Deseja corrigir? (s/N): " RESPOSTA

        if [ "$RESPOSTA" = "s" ] || [ "$RESPOSTA" = "S" ]; then
            ANTES=$(stat -c '%a' "$ARQUIVO")
            chmod 644 "$ARQUIVO"
            DEPOIS=$(stat -c '%a' "$ARQUIVO")
            echo "  CORRIGIDO: $ANTES -> $DEPOIS" | tee -a $RELATORIO
        else
            echo "  IGNORADO" | tee -a $RELATORIO
        fi

        echo "" | tee -a $RELATORIO
        count_sem=$((count_sem + 1))
    fi
done

if [ $count_sem -eq 0 ]; then
    echo "  Nenhum arquivo com esse problema." | tee -a $RELATORIO
fi

# ===== RESUMO =====
echo "" | tee -a $RELATORIO
echo "===== RESUMO =====" | tee -a $RELATORIO
echo "Com escrita para todos : $count_ow" | tee -a $RELATORIO
echo "Sem permissão do dono  : $count_sem" | tee -a $RELATORIO
echo "Relatório salvo em: $RELATORIO"
