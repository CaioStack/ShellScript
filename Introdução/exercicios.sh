# ============================================================
# EXERCÍCIO 1
# Exiba seu nome, sua idade e sua cidade usando echo.
# Exemplo de saída esperada:
#   Nome  : João
#   Idade : 20
#   Cidade: Fortaleza
# ============================================================
 
# RESOLUÇÃO:
echo "Nome  : João"
echo "Idade : 20"
echo "Cidade: Fortaleza"
 
 
# ============================================================
# EXERCÍCIO 2
# Exiba a data e hora atual no formato: DD/MM/AAAA HH:MM:SS
# Dica: use o comando date e consulte o exemplo 2
# ============================================================
 
# RESOLUÇÃO:
echo "Data e hora: $(date '+%d/%m/%Y %H:%M:%S')"
 
 
# ============================================================
# EXERCÍCIO 3
# Crie um script que exiba uma "ficha" assim:
#
#   ========================
#   FICHA DO SISTEMA
#   ========================
#   Usuário : (seu usuário)
#   Host    : (nome do pc)
#   Data    : (data atual)
#   ========================
# ============================================================
 
# RESOLUÇÃO:
echo "========================"
echo "FICHA DO SISTEMA"
echo "========================"
echo "Usuário : $USER"
echo "Host    : $(hostname)"
echo "Data    : $(date '+%d/%m/%Y')"
echo "========================"