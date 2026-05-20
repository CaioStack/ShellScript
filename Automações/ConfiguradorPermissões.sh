#!/bin/bash
# Configurador de permissões em lote

LOG="permissoes_$(date '+%Y%m%d_%H%M%S').log"

# Pede o caminho ao usuário
read -rp "Informe o caminho onde aplicar as permissões: " CAMINHO

if [ ! -d "$CAMINHO" ]; then
    echo "Erro: caminho não encontrado!"
    exit 1
fi

# Mostra o menu de perfis
echo ""
echo "===== PERFIS DE PERMISSÃO ====="
echo "1 - Somente leitura   (arquivos: 444 | pastas: 555)"
echo "2 - Leitura e escrita (arquivos: 644 | pastas: 755)"
echo "3 - Restrito          (arquivos: 600 | pastas: 700)"
echo "4 - Executável        (arquivos: 755 | pastas: 755)"
echo "0 - Sair"
echo ""
read -rp "Escolha um perfil: " OPCAO

# Define as permissões de acordo com o perfil escolhido
if [ "$OPCAO" = "1" ]; then
    PERM_ARQUIVO="444"
    PERM_PASTA="555"
    PERFIL="Somente leitura"

elif [ "$OPCAO" = "2" ]; then
    PERM_ARQUIVO="644"
    PERM_PASTA="755"
    PERFIL="Leitura e escrita"

elif [ "$OPCAO" = "3" ]; then
    PERM_ARQUIVO="600"
    PERM_PASTA="700"
    PERFIL="Restrito"

elif [ "$OPCAO" = "4" ]; then
    PERM_ARQUIVO="755"
    PERM_PASTA="755"
    PERFIL="Executável"

elif [ "$OPCAO" = "0" ]; then
    echo "Saindo..."
    exit 0

else
    echo "Opção inválida!"
    exit 1
fi

# Mostra o que vai ser feito e pede confirmação
echo ""
echo "Perfil    : $PERFIL"
echo "Arquivos  : $PERM_ARQUIVO"
echo "Pastas    : $PERM_PASTA"
echo "Caminho   : $CAMINHO"
echo ""
read -rp "Confirma? (s/N): " CONFIRMA

if [ "$CONFIRMA" != "s" ] && [ "$CONFIRMA" != "S" ]; then
    echo "Operação cancelada."
    exit 0
fi

count_arquivo=0
count_pasta=0

# Aplica permissões nos arquivos
for ARQUIVO in $(find "$CAMINHO" -type f); do
    chmod "$PERM_ARQUIVO" "$ARQUIVO"
    echo "$(date '+%d/%m/%Y %H:%M:%S') - ARQUIVO [$PERM_ARQUIVO]: $ARQUIVO" >> $LOG
    count_arquivo=$((count_arquivo + 1))
done

# Aplica permissões nas pastas
for PASTA in $(find "$CAMINHO" -type d); do
    chmod "$PERM_PASTA" "$PASTA"
    echo "$(date '+%d/%m/%Y %H:%M:%S') - PASTA [$PERM_PASTA]: $PASTA" >> $LOG
    count_pasta=$((count_pasta + 1))
done

echo ""
echo "===== RESUMO ====="
echo "Perfil aplicado    : $PERFIL"
echo "Arquivos alterados : $count_arquivo"
echo "Pastas alteradas   : $count_pasta"
echo "Log salvo em       : $LOG"
