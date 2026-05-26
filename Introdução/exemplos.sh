#!/bin/bash
# ============================================================
# 01 - INTRODUÇÃO AO SHELL SCRIPT
# ============================================================
# O que é Shell Script?
# É um arquivo de texto com comandos que o terminal executa
# em sequência, como uma "receita" de instruções.
#
# Para rodar qualquer script:
#   chmod +x arquivo.sh   <- dá permissão de execução
#   ./arquivo.sh          <- executa
# ============================================================
 
 
# ============================================================
# EXEMPLO 1 - Primeiro script: exibindo texto na tela
# ============================================================
 
echo "Olá, mundo!"
echo "Bem-vindo ao Shell Script!"
 
# echo -> exibe uma mensagem na tela
# Tudo após o # é um comentário e é ignorado pelo terminal
 
 
# ============================================================
# EXEMPLO 2 - Exibindo informações do sistema
# ============================================================
 
echo "Usuário logado: $USER"
echo "Diretório atual: $PWD"
echo "Data de hoje: $(date '+%d/%m/%Y')"
echo "Nome do computador: $(hostname)"
 
# $USER, $PWD  -> variáveis que o sistema já define sozinho
# $(comando)   -> executa um comando e usa o resultado
 
 
# ============================================================
# EXEMPLO 3 - Comentários e organização do código
# ============================================================
 
# Isso é um comentário de uma linha
 
# Bloco de comentário (várias linhas):
# Linha 1 do comentário
# Linha 2 do comentário
# Linha 3 do comentário
 
echo "Comentários não aparecem na tela!"