#!/bin/bash
# ============================================================
# 03 - CONDICIONAIS (if / elif / else)
# ============================================================
# Condicionais permitem que o script tome decisões:
# "SE isso for verdade, faça aquilo."
#
# Estrutura básica:
#   if [ condição ]; then
#       comandos
#   elif [ outra condição ]; then
#       comandos
#   else
#       comandos
#   fi
#
# ATENÇÃO: espaços dentro dos colchetes são obrigatórios!
# ============================================================
 
 
# ============================================================
# EXEMPLO 1 - Comparando números
# ============================================================
 
# Operadores numéricos:
# -eq  igual a          (equal)
# -ne  diferente de     (not equal)
# -gt  maior que        (greater than)
# -lt  menor que        (less than)
# -ge  maior ou igual   (greater or equal)
# -le  menor ou igual   (less or equal)
 
NUMERO=10
 
if [ $NUMERO -gt 5 ]; then
    echo "$NUMERO é maior que 5"
fi
 
if [ $NUMERO -eq 10 ]; then
    echo "$NUMERO é igual a 10"
fi
 
 
# ============================================================
# EXEMPLO 2 - if / elif / else com nota
# ============================================================
 
NOTA=7
 
if [ $NOTA -ge 7 ]; then
    echo "Aprovado!"
elif [ $NOTA -ge 5 ]; then
    echo "Recuperação"
else
    echo "Reprovado"
fi
 
 
# ============================================================
# EXEMPLO 3 - Comparando texto (strings)
# ============================================================
 
# Operadores de texto:
# =    igual
# !=   diferente
# -z   string vazia
# -n   string não vazia
 
COR="azul"
 
if [ "$COR" = "azul" ]; then
    echo "A cor é azul!"
fi
 
if [ "$COR" != "vermelho" ]; then
    echo "A cor não é vermelho"
fi
 
VAZIO=""
if [ -z "$VAZIO" ]; then
    echo "A variável está vazia"
fi
 
 
# ============================================================
# EXEMPLO 4 - Verificando arquivos e pastas
# ============================================================
 
# Operadores de arquivo:
# -f   é um arquivo
# -d   é um diretório (pasta)
# -e   existe (arquivo ou pasta)
# -r   tem permissão de leitura
# -w   tem permissão de escrita
# -x   tem permissão de execução
 
if [ -f "/etc/passwd" ]; then
    echo "O arquivo /etc/passwd existe!"
fi
 
if [ -d "$HOME" ]; then
    echo "A pasta home existe!"
fi
 
if [ ! -d "/pasta/inexistente" ]; then
    echo "Essa pasta não existe"
fi
 
# ! -> inverte a condição (NOT)
 
 
# ============================================================
# EXEMPLO 5 - Condições combinadas
# ============================================================
 
# && -> E (as duas condições precisam ser verdade)
# || -> OU (basta uma ser verdade)
 
IDADE=20
TEM_CNH="sim"
 
if [ $IDADE -ge 18 ] && [ "$TEM_CNH" = "sim" ]; then
    echo "Pode dirigir!"
fi
 
DIA="sábado"
 
if [ "$DIA" = "sábado" ] || [ "$DIA" = "domingo" ]; then
    echo "É fim de semana!"
fi