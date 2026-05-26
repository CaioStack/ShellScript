#!/bin/bash
# ============================================================
# 10 - PROCESSOS E SISTEMA
# ============================================================
 
 
# ============================================================
# EXEMPLO 1 - Ver processos em execução
# ============================================================
 
ps aux | head -10
 
 
# ============================================================
# EXEMPLO 2 - Buscar processo por nome
# ============================================================
 
if pgrep -x "cron" > /dev/null 2>&1; then
    echo "O cron está em execução"
else
    echo "O cron não está rodando"
fi
 
 
# ============================================================
# EXEMPLO 3 - PID do script atual
# ============================================================
 
echo "PID do script atual: $$"
 
 
# ============================================================
# EXEMPLO 4 - Informações do sistema
# ============================================================
 
echo "=== MEMÓRIA ==="
free -h
 
echo "=== DISCO ==="
df -h
 
echo "=== UPTIME ==="
uptime -p
 
echo "=== SISTEMA ==="
echo "Kernel : $(uname -r)"
echo "Host   : $(hostname)"
 
 
# ============================================================
# EXEMPLO 5 - Top processos
# ============================================================
 
echo "Top 5 por CPU:"
ps aux --sort=-%cpu | awk 'NR>1 {printf "PID:%-8s CPU:%-6s %s\n", $2, $3, $11}' | head -5