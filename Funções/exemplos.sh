#!/bin/bash
# ============================================================
# 05 - FUNÇÕES
# ============================================================
# Funções agrupam comandos que podem ser reutilizados.
# Evita repetir o mesmo código várias vezes.
#
# Estrutura:
#   nome_da_funcao() {
#       comandos
#   }
#
# Para chamar: nome_da_funcao
# ============================================================
 
 
# ============================================================
# EXEMPLO 1 - Função simples
# ============================================================
 
saudacao() {
    echo "Olá! Bem-vindo ao sistema."
    echo "Data: $(date '+%d/%m/%Y %H:%M:%S')"
}
 
saudacao
 
 
# ============================================================
# EXEMPLO 2 - Função com parâmetros
# ============================================================
 
cumprimentar() {
    NOME=$1
    echo "Olá, $NOME! Tudo bem?"
}
 
cumprimentar "João"
cumprimentar "Maria"
 
 
# ============================================================
# EXEMPLO 3 - Função que retorna um valor
# ============================================================
 
calcular_soma() {
    RESULTADO=$(($1 + $2))
    echo $RESULTADO
}
 
SOMA=$(calcular_soma 10 5)
echo "A soma é: $SOMA"
 
 
# ============================================================
# EXEMPLO 4 - Função com verificação de erros
# ============================================================
 
criar_pasta() {
    CAMINHO=$1
 
    if [ -z "$CAMINHO" ]; then
        echo "Erro: informe um caminho!"
        return 1
    fi
 
    if [ -d "$CAMINHO" ]; then
        echo "A pasta '$CAMINHO' já existe."
        return 0
    fi
 
    mkdir "$CAMINHO"
    echo "Pasta '$CAMINHO' criada!"
    return 0
}
 
criar_pasta "/tmp/teste_shell"
criar_pasta ""
 
 
# ============================================================
# EXEMPLO 5 - Variáveis globais dentro de funções
# ============================================================
 
TOTAL=0
 
adicionar() {
    VALOR=$1
    TOTAL=$((TOTAL + VALOR))
}
 
adicionar 10
adicionar 20
adicionar 5
 
echo "Total acumulado: $TOTAL"
 
 
# ============================================================
# EXEMPLO 6 - Função de log
# ============================================================
 
LOG_FILE="/tmp/meu_script.log"
 
registrar() {
    MENSAGEM=$1
    echo "[$(date '+%d/%m/%Y %H:%M:%S')] $MENSAGEM" | tee -a $LOG_FILE
}
 
registrar "Script iniciado"
registrar "Processando dados..."
registrar "Script finalizado"