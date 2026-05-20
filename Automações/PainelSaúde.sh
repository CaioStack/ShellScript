#!/bin/bash
# Painel de saúde do sistema

clear

echo "=================================================="
echo "          PAINEL DE SAÚDE DO SISTEMA"
echo "=================================================="
echo "  Host  : $(hostname)"
echo "  Data  : $(date '+%d/%m/%Y %H:%M:%S')"
echo "  Uptime: $(uptime -p)"
echo "=================================================="

# ===== PARTE 1: Uso de disco por partição =====
echo ""
echo "===== USO DE DISCO POR PARTIÇÃO ====="
echo ""
printf "%-25s %8s %8s %8s %6s  %s\n" "PARTIÇÃO" "TOTAL" "USADO" "LIVRE" "USO%" "STATUS"
echo "-----------------------------------------------------------------------"

df -h 2>/dev/null | tail -n +2 | while read -r linha; do
    # Pega os campos da linha
    PARTICAO=$(echo "$linha" | awk '{print $1}')
    TOTAL=$(echo "$linha"   | awk '{print $2}')
    USADO=$(echo "$linha"   | awk '{print $3}')
    LIVRE=$(echo "$linha"   | awk '{print $4}')
    PCT=$(echo "$linha"     | awk '{print $5}')

    # Remove o % para comparar o número
    NUM=$(echo "$PCT" | tr -d '%')

    # Define o status (alerta se acima de 80%)
    if [ -n "$NUM" ] && [ "$NUM" -ge 80 ] 2>/dev/null; then
        STATUS="⚠ ALERTA"
    else
        STATUS="✔ OK"
    fi

    printf "%-25s %8s %8s %8s %6s  %s\n" "${PARTICAO:0:25}" "$TOTAL" "$USADO" "$LIVRE" "$PCT" "$STATUS"
done

# ===== PARTE 2: Top 5 processos =====
echo ""
echo "===== TOP 5 PROCESSOS QUE MAIS CONSOMEM RECURSOS ====="
echo ""
printf "%-8s %-20s %-12s %6s %6s\n" "PID" "PROCESSO" "USUÁRIO" "%CPU" "%MEM"
echo "------------------------------------------------------"
ps aux --sort=-%cpu 2>/dev/null | awk 'NR>1 {printf "%-8s %-20s %-12s %6s %6s\n", $2, $11, $1, $3, $4}' | head -5

# ===== PARTE 3: Usuários logados =====
echo ""
echo "===== USUÁRIOS ATUALMENTE LOGADOS ====="
echo ""

if who 2>/dev/null | grep -q .; then
    printf "%-15s %-10s %-20s\n" "USUÁRIO" "TERMINAL" "DESDE"
    echo "--------------------------------------------"
    who 2>/dev/null | while read -r linha; do
        USUARIO=$(echo "$linha" | awk '{print $1}')
        TERMINAL=$(echo "$linha" | awk '{print $2}')
        DATA=$(echo "$linha" | awk '{print $3, $4}')
        printf "%-15s %-10s %-20s\n" "$USUARIO" "$TERMINAL" "$DATA"
    done
else
    echo "  Nenhum usuário logado no momento."
fi

# ===== PARTE 4: Últimas 10 linhas do log do sistema =====
echo ""
echo "===== ÚLTIMAS 10 ENTRADAS DO LOG DO SISTEMA ====="
echo ""

if command -v journalctl > /dev/null 2>&1; then
    journalctl -n 10 --no-pager 2>/dev/null | while read -r linha; do
        echo "  $linha"
    done
elif [ -f /var/log/syslog ]; then
    tail -n 10 /var/log/syslog | while read -r linha; do
        echo "  $linha"
    done
else
    echo "  Log do sistema não encontrado."
fi

echo ""
echo "=================================================="
echo "  Painel gerado em: $(date '+%d/%m/%Y %H:%M:%S')"
echo "=================================================="
