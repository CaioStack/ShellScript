#!/bin/bash
# Cadastro de usuários em lote
# ATENÇÃO: precisa rodar com sudo

LISTA=$1
GRUPO="alunos"
SENHA_PADRAO="Senha@123"
LOG="cadastro_$(date '+%Y%m%d_%H%M%S').log"

if [ -z "$LISTA" ]; then
    echo "Uso: sudo $0 <arquivo_com_nomes.txt>"
    exit 1
fi

if [ ! -f "$LISTA" ]; then
    echo "Erro: arquivo '$LISTA' não encontrado!"
    exit 1
fi

# Verifica se está rodando como root
if [ "$EUID" -ne 0 ]; then
    echo "Erro: execute com sudo!"
    exit 1
fi

count_criados=0
count_existentes=0
count_erros=0

echo "$(date '+%d/%m/%Y %H:%M:%S') - Iniciando cadastro" >> $LOG

# Cria o grupo se não existir
if ! getent group "$GRUPO" > /dev/null; then
    groupadd "$GRUPO"
    echo "Grupo '$GRUPO' criado."
fi

# Lê cada linha do arquivo
while read -r NOME; do

    # Ignora linhas vazias
    if [ -z "$NOME" ]; then
        continue
    fi

    # Converte para minúsculas e remove caracteres especiais
    USUARIO=$(echo "$NOME" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9')

    # Verifica se o usuário já existe
    if id "$USUARIO" > /dev/null 2>&1; then
        echo "  Já existe: $USUARIO"
        echo "$(date '+%d/%m/%Y %H:%M:%S') - JÁ EXISTE: $USUARIO" >> $LOG
        count_existentes=$((count_existentes + 1))
        continue
    fi

    # Cria o usuário
    useradd -m -g "$GRUPO" -s /bin/bash "$USUARIO"

    if [ $? -eq 0 ]; then
        # Define a senha padrão
        echo "$USUARIO:$SENHA_PADRAO" | chpasswd
        # Força troca de senha no primeiro login
        chage -d 0 "$USUARIO"

        echo "  Criado: $USUARIO"
        echo "$(date '+%d/%m/%Y %H:%M:%S') - CRIADO: $USUARIO" >> $LOG
        count_criados=$((count_criados + 1))
    else
        echo "  Erro ao criar: $USUARIO"
        echo "$(date '+%d/%m/%Y %H:%M:%S') - ERRO: $USUARIO" >> $LOG
        count_erros=$((count_erros + 1))
    fi

done < "$LISTA"

echo ""
echo "===== RESUMO ====="
echo "Criados com sucesso: $count_criados"
echo "Já existentes      : $count_existentes"
echo "Com erro           : $count_erros"
echo "Log salvo em       : $LOG"
