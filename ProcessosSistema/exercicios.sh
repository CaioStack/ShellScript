# ============================================================
# EXERCÍCIO 1
# Crie um script que exiba:
# - Memória total e disponível
# - Porcentagem de uso da memória
# - Um alerta se o uso passar de 80%
# ============================================================
 
# RESOLUÇÃO:
TOTAL=$(free | awk '/Mem:/ {print $2}')
USADO=$(free | awk '/Mem:/ {print $3}')
PERCENTUAL=$((USADO * 100 / TOTAL))
 
TOTAL_HR=$(free -h | awk '/Mem:/ {print $2}')
DISPONIVEL_HR=$(free -h | awk '/Mem:/ {print $7}')
 
echo "Memória total     : $TOTAL_HR"
echo "Disponível        : $DISPONIVEL_HR"
echo "Uso               : $PERCENTUAL%"
 
if [ $PERCENTUAL -ge 80 ]; then
    echo "ALERTA: uso de memória acima de 80%!"
fi
 
 
# ============================================================
# EXERCÍCIO 2
# Crie um script que verifique a cada 3 segundos
# se um processo específico (passado como argumento) está rodando.
# Se parar, exiba um alerta e saia.
# ============================================================
 
# RESOLUÇÃO:
PROCESSO="${1:-bash}"
 
echo "Monitorando processo '$PROCESSO'..."
 
while true; do
    if pgrep -x "$PROCESSO" > /dev/null 2>&1; then
        echo "$(date '+%H:%M:%S') - '$PROCESSO' está rodando."
    else
        echo "ALERTA: '$PROCESSO' não está mais em execução!"
        exit 1
    fi
    sleep 3
done
 
 
# ============================================================
# EXERCÍCIO 3
# Crie um script que mostre os 10 processos que mais
# consomem memória, com PID, nome e percentual.
# ============================================================
 
# RESOLUÇÃO:
echo "Top 10 processos por memória:"
echo ""
printf "%-8s %-25s %6s\n" "PID" "NOME" "%MEM"
echo "----------------------------------------"
ps aux --sort=-%mem | awk 'NR>1 {printf "%-8s %-25s %6s\n", $2, $11, $4}' | head -10