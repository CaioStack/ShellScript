#!/bin/bash
# Monitor interativo de processos

LOG="monitor_$(date '+%Y%m%d_%H%M%S').log"

echo "===== MONITOR DE PROCESSOS ====="
echo "Comandos: M = Monitorar | E = Encerrar processo | Q = Sair"

while true; do

    echo ""
    read -rp "Escolha [M/E/Q]: " OPCAO

    # ===== MONITORAR =====
    if [ "$OPCAO" = "M" ] || [ "$OPCAO" = "m" ]; then

        echo "Monitorando a cada 5 segundos. Pressione CTRL+C para parar."
        echo ""

        while true; do
            clear
            echo "===== TOP 10 - MAIOR USO DE CPU ====="
            echo "$(date '+%d/%m/%Y %H:%M:%S')"
            echo ""
            printf "%-8s %-20s %-10s %6s %6s\n" "PID" "NOME" "USUÁRIO" "%CPU" "%MEM"
            echo "----------------------------------------------------"
            ps aux --sort=-%cpu | awk 'NR>1 {printf "%-8s %-20s %-10s %6s %6s\n", $2, $11, $1, $3, $4}' | head -10

            echo ""
            echo "===== TOP 10 - MAIOR USO DE MEMÓRIA ====="
            printf "%-8s %-20s %-10s %6s %6s\n" "PID" "NOME" "USUÁRIO" "%MEM" "%CPU"
            echo "----------------------------------------------------"
            ps aux --sort=-%mem | awk 'NR>1 {printf "%-8s %-20s %-10s %6s %6s\n", $2, $11, $1, $4, $3}' | head -10

            sleep 5
        done

    # ===== ENCERRAR PROCESSO =====
    elif [ "$OPCAO" = "E" ] || [ "$OPCAO" = "e" ]; then

        read -rp "Digite o nome do processo: " NOME_PROC

        # Busca o PID do processo
        PID=$(pgrep -x "$NOME_PROC" 2>/dev/null)

        if [ -z "$PID" ]; then
            echo "Processo '$NOME_PROC' não encontrado."
        else
            echo "Processo encontrado:"
            ps -p "$PID" -o pid,comm,user,%cpu,%mem 2>/dev/null

            echo ""
            read -rp "Confirma encerramento? (s/N): " CONFIRMA

            if [ "$CONFIRMA" = "s" ] || [ "$CONFIRMA" = "S" ]; then
                kill "$PID"

                if [ $? -eq 0 ]; then
                    echo "Processo $PID encerrado com sucesso."
                    echo "$(date '+%d/%m/%Y %H:%M:%S') - ENCERRADO: PID=$PID Nome=$NOME_PROC" >> $LOG
                else
                    echo "Erro ao encerrar o processo."
                    echo "$(date '+%d/%m/%Y %H:%M:%S') - ERRO ao encerrar: PID=$PID" >> $LOG
                fi
            else
                echo "Operação cancelada."
            fi
        fi

    # ===== SAIR =====
    elif [ "$OPCAO" = "Q" ] || [ "$OPCAO" = "q" ]; then
        echo "Saindo. Log salvo em: $LOG"
        exit 0

    else
        echo "Opção inválida. Use M, E ou Q."
    fi

done
