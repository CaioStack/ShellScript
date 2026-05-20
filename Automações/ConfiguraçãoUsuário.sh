#!/bin/bash
# Script de configuração de novo usuário
# ATENÇÃO: precisa rodar com sudo

LOG="config_usuario_$(date '+%Y%m%d_%H%M%S').log"
SENHA_PADRAO="Trocar@123"

# Verifica se está rodando como root
if [ "$EUID" -ne 0 ]; then
    echo "Erro: execute com sudo!"
    exit 1
fi

# Pega o nome do usuário (pode vir como argumento ou pelo menu)
NOME_USUARIO=$1
PERFIL=$2

# Se não passou o nome, pede pelo terminal
if [ -z "$NOME_USUARIO" ]; then
    read -rp "Digite o nome do usuário: " NOME_USUARIO
fi

# Converte para minúsculas
NOME_USUARIO=$(echo "$NOME_USUARIO" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9')

if [ -z "$NOME_USUARIO" ]; then
    echo "Erro: nome de usuário inválido!"
    exit 1
fi

# Verifica se o usuário já existe
if id "$NOME_USUARIO" > /dev/null 2>&1; then
    echo "Erro: usuário '$NOME_USUARIO' já existe!"
    exit 1
fi

# Se não passou o perfil, mostra o menu
if [ -z "$PERFIL" ]; then
    echo ""
    echo "===== ESCOLHA O PERFIL ====="
    echo "1 - Aluno"
    echo "2 - Professor"
    echo "3 - Admin"
    echo ""
    read -rp "Escolha: " OPCAO

    if [ "$OPCAO" = "1" ]; then
        PERFIL="aluno"
    elif [ "$OPCAO" = "2" ]; then
        PERFIL="professor"
    elif [ "$OPCAO" = "3" ]; then
        PERFIL="admin"
    else
        echo "Opção inválida!"
        exit 1
    fi
fi

# Define o grupo conforme o perfil
if [ "$PERFIL" = "aluno" ]; then
    GRUPO="alunos"
    PERMISSAO_HOME="750"
elif [ "$PERFIL" = "professor" ]; then
    GRUPO="professores"
    PERMISSAO_HOME="750"
elif [ "$PERFIL" = "admin" ]; then
    GRUPO="admins"
    PERMISSAO_HOME="700"
else
    echo "Perfil inválido! Use: aluno, professor ou admin"
    exit 1
fi

echo "$(date '+%d/%m/%Y %H:%M:%S') - Iniciando configuração de $NOME_USUARIO ($PERFIL)" >> $LOG

# Cria o grupo se não existir
if ! getent group "$GRUPO" > /dev/null; then
    groupadd "$GRUPO"
    echo "Grupo '$GRUPO' criado."
    echo "$(date '+%d/%m/%Y %H:%M:%S') - Grupo criado: $GRUPO" >> $LOG
fi

# Cria o usuário
useradd -m -g "$GRUPO" -s /bin/bash "$NOME_USUARIO"

if [ $? -ne 0 ]; then
    echo "Erro ao criar o usuário!"
    exit 1
fi

# Define a senha e força troca no primeiro login
echo "$NOME_USUARIO:$SENHA_PADRAO" | chpasswd
chage -d 0 "$NOME_USUARIO"

# Define permissão da pasta home
HOME_DIR="/home/$NOME_USUARIO"
chmod "$PERMISSAO_HOME" "$HOME_DIR"

echo "$(date '+%d/%m/%Y %H:%M:%S') - Usuário criado: $NOME_USUARIO" >> $LOG

# Cria pastas pessoais conforme o perfil
if [ "$PERFIL" = "aluno" ]; then
    mkdir "$HOME_DIR/Downloads"
    mkdir "$HOME_DIR/Documentos"
    mkdir "$HOME_DIR/Trabalhos"

elif [ "$PERFIL" = "professor" ]; then
    mkdir "$HOME_DIR/Downloads"
    mkdir "$HOME_DIR/Documentos"
    mkdir "$HOME_DIR/Aulas"
    mkdir "$HOME_DIR/Provas"

elif [ "$PERFIL" = "admin" ]; then
    mkdir "$HOME_DIR/Downloads"
    mkdir "$HOME_DIR/Documentos"
    mkdir "$HOME_DIR/Scripts"
    mkdir "$HOME_DIR/Logs"
fi

# Ajusta dono das pastas
chown -R "$NOME_USUARIO:$GRUPO" "$HOME_DIR"

echo "$(date '+%d/%m/%Y %H:%M:%S') - Pastas criadas em $HOME_DIR" >> $LOG

# Mostra o resumo
echo ""
echo "===== RESUMO DA CONFIGURAÇÃO ====="
echo "Usuário criado : $NOME_USUARIO"
echo "Perfil         : $PERFIL"
echo "Grupo          : $GRUPO"
echo "Home           : $HOME_DIR"
echo "Permissão home : $PERMISSAO_HOME"
echo "Senha padrão   : $SENHA_PADRAO"
echo "Troca de senha : obrigatória no primeiro login"
echo "Log salvo em   : $LOG"

echo "$(date '+%d/%m/%Y %H:%M:%S') - Configuração concluída com sucesso" >> $LOG
