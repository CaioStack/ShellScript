#!/bin/bash
# Relatório e auditoria de usuários

RELATORIO="auditoria_$(date '+%Y%m%d_%H%M%S').txt"

echo "================================" | tee $RELATORIO
echo "AUDITORIA DE USUÁRIOS"           | tee -a $RELATORIO
echo "Data: $(date '+%d/%m/%Y %H:%M:%S')" | tee -a $RELATORIO
echo "================================" | tee -a $RELATORIO

# ===== PARTE 1: Usuários do sistema x usuários comuns =====
echo "" | tee -a $RELATORIO
echo "===== USUÁRIOS DO SISTEMA (UID < 1000) =====" | tee -a $RELATORIO

while IFS=: read -r NOME SENHA UID RESTO; do
    if [ "$UID" -lt 1000 ]; then
        echo "  $NOME (UID: $UID)" | tee -a $RELATORIO
    fi
done < /etc/passwd

echo "" | tee -a $RELATORIO
echo "===== USUÁRIOS COMUNS (UID >= 1000) =====" | tee -a $RELATORIO

while IFS=: read -r NOME SENHA UID RESTO; do
    if [ "$UID" -ge 1000 ] && [ "$NOME" != "nobody" ]; then
        echo "  $NOME (UID: $UID)" | tee -a $RELATORIO
    fi
done < /etc/passwd

# ===== PARTE 2: Usuários sem senha =====
echo "" | tee -a $RELATORIO
echo "===== USUÁRIOS SEM SENHA =====" | tee -a $RELATORIO

count_sem_senha=0

while IFS=: read -r NOME SENHA RESTO; do
    if [ -z "$SENHA" ] || [ "$SENHA" = "!" ] || [ "$SENHA" = "*" ] || [ "$SENHA" = "!!" ]; then
        echo "  Sem senha: $NOME" | tee -a $RELATORIO
        count_sem_senha=$((count_sem_senha + 1))
    fi
done < /etc/shadow 2>/dev/null

if [ $count_sem_senha -eq 0 ]; then
    echo "  Nenhum usuário sem senha." | tee -a $RELATORIO
fi

# ===== PARTE 3: Contas sem login =====
echo "" | tee -a $RELATORIO
echo "===== CONTAS QUE NUNCA FIZERAM LOGIN =====" | tee -a $RELATORIO

count_sem_login=0

while IFS=: read -r NOME SENHA UID RESTO; do
    if [ "$UID" -ge 1000 ] && [ "$NOME" != "nobody" ]; then
        ULTIMO=$(lastlog -u "$NOME" 2>/dev/null | grep -i "never\|nunca")
        if [ -n "$ULTIMO" ]; then
            echo "  Nunca logou: $NOME" | tee -a $RELATORIO
            count_sem_login=$((count_sem_login + 1))
        fi
    fi
done < /etc/passwd

if [ $count_sem_login -eq 0 ]; then
    echo "  Todos os usuários já fizeram login." | tee -a $RELATORIO
fi

# ===== PARTE 4: Grupos de cada usuário =====
echo "" | tee -a $RELATORIO
echo "===== GRUPOS DE CADA USUÁRIO =====" | tee -a $RELATORIO

while IFS=: read -r NOME SENHA UID RESTO; do
    if [ "$UID" -ge 1000 ] && [ "$NOME" != "nobody" ]; then
        GRUPOS=$(id -Gn "$NOME" 2>/dev/null)

        if [ -z "$GRUPOS" ]; then
            echo "  $NOME: SEM GRUPO!" | tee -a $RELATORIO
        else
            echo "  $NOME: $GRUPOS" | tee -a $RELATORIO
        fi
    fi
done < /etc/passwd

echo "" | tee -a $RELATORIO
echo "===== RESUMO =====" | tee -a $RELATORIO
echo "Sem senha    : $count_sem_senha" | tee -a $RELATORIO
echo "Sem login    : $count_sem_login" | tee -a $RELATORIO
echo "Relatório salvo em: $RELATORIO"
