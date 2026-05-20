#!/bin/bash
# Verificador de serviços essenciais

LOG="servicos_$(date '+%Y%m%d_%H%M%S').log"
RELATORIO="relatorio_servicos_$(date '+%Y%m%d_%H%M%S').txt"

# Lista de serviços para monitorar
# Edite conforme os serviços do seu sistema
SERVICOS="ssh cron rsyslog ufw nginx apache2 mysql"

count_ok=0
count_parado=0
count_nao_encontrado=0

echo "================================"   | tee $RELATORIO
echo "VERIFICADOR DE SERVIÇOS"            | tee -a $RELATORIO
echo "Data: $(date '+%d/%m/%Y %H:%M:%S')" | tee -a $RELATORIO
echo "================================"   | tee -a $RELATORIO
echo ""                                    | tee -a $RELATORIO

for SERVICO in $SERVICOS; do

    # Verifica se o serviço existe no sistema
    if ! systemctl list-unit-files 2>/dev/null | grep -q "$SERVICO.service"; then
        echo "  [NÃO ENCONTRADO] $SERVICO" | tee -a $RELATORIO
        echo "$(date '+%d/%m/%Y %H:%M:%S') - NÃO ENCONTRADO: $SERVICO" >> $LOG
        count_nao_encontrado=$((count_nao_encontrado + 1))
        continue
    fi

    # Verifica o estado do serviço
    ESTADO=$(systemctl is-active "$SERVICO" 2>/dev/null)

    if [ "$ESTADO" = "active" ]; then
        # Pega há quanto tempo está rodando
        TEMPO=$(systemctl status "$SERVICO" 2>/dev/null | grep "Active:" | awk '{print $3, $4, $5}')
        echo "  [OK]     $SERVICO - Em execução ($TEMPO)" | tee -a $RELATORIO
        echo "$(date '+%d/%m/%Y %H:%M:%S') - OK: $SERVICO" >> $LOG
        count_ok=$((count_ok + 1))
    else
        echo "  [ALERTA] $SERVICO - PARADO! Estado: $ESTADO - Horário: $(date '+%H:%M:%S')" | tee -a $RELATORIO
        echo "$(date '+%d/%m/%Y %H:%M:%S') - ALERTA: $SERVICO está PARADO" >> $LOG
        count_parado=$((count_parado + 1))
    fi

done

echo ""                                             | tee -a $RELATORIO
echo "===== RESUMO ====="                           | tee -a $RELATORIO
echo "OK              : $count_ok"                  | tee -a $RELATORIO
echo "Parados         : $count_parado"              | tee -a $RELATORIO
echo "Não encontrados : $count_nao_encontrado"      | tee -a $RELATORIO
echo "Log salvo em    : $LOG"
echo "Relatório em    : $RELATORIO"
