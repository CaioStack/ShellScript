#!/bin/bash
# ============================================================
# 02 - VARIÁVEIS
# ============================================================
# Variáveis guardam informações para usar depois.
# Regras:
#   - Sem espaço antes ou depois do =
#   - Para usar o valor, coloque $ na frente
#   - Nomes em maiúsculo são convenção (não obrigatório)
# ============================================================
 
 
# ============================================================
# EXEMPLO 1 - Criando e usando variáveis
# ============================================================
 
NOME="Maria"
IDADE=21
CIDADE="Fortaleza"
 
echo "Nome  : $NOME"
echo "Idade : $IDADE"
echo "Cidade: $CIDADE"
 
 
# ============================================================
# EXEMPLO 2 - Variáveis do sistema (já existem sozinhas)
# ============================================================
 
echo "Usuário atual : $USER"
echo "Pasta home    : $HOME"
echo "Pasta atual   : $PWD"
echo "Nome do shell : $SHELL"
 
# Outras variáveis úteis do sistema:
# $PATH   -> caminhos onde o sistema busca programas
# $EUID   -> ID do usuário (0 = root)
# $RANDOM -> número aleatório
 
 
# ============================================================
# EXEMPLO 3 - Variáveis com resultado de comandos
# ============================================================
 
DATA_HOJE=$(date '+%d/%m/%Y')
HORA_AGORA=$(date '+%H:%M:%S')
ARQUIVOS=$(ls | wc -l)
 
echo "Data : $DATA_HOJE"
echo "Hora : $HORA_AGORA"
echo "Arquivos na pasta atual: $ARQUIVOS"
 
# $( ) -> executa o comando dentro e guarda o resultado
 
 
# ============================================================
# EXEMPLO 4 - Lendo valor digitado pelo usuário
# ============================================================
 
# read -> espera o usuário digitar algo
read -rp "Digite seu nome: " NOME_USUARIO
echo "Olá, $NOME_USUARIO!"
 
# -r  -> não interpreta barras invertidas (boa prática)
# -p  -> mostra uma mensagem antes de esperar a digitação
 
 
# ============================================================
# EXEMPLO 5 - Operações com números
# ============================================================
 
A=10
B=3
 
SOMA=$((A + B))
SUBTRACAO=$((A - B))
MULTIPLICACAO=$((A * B))
DIVISAO=$((A / B))
RESTO=$((A % B))
 
echo "Soma        : $SOMA"
echo "Subtração   : $SUBTRACAO"
echo "Multiplicação: $MULTIPLICACAO"
echo "Divisão     : $DIVISAO"
echo "Resto       : $RESTO"
 
# $(( )) -> faz operações matemáticas com inteiros