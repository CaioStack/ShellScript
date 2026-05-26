# ============================================================
# EXERCÍCIO 1
# Crie um script que receba um arquivo como argumento
# e exiba suas permissões de forma amigável:
#   Arquivo : /etc/passwd
#   Dono    : pode ler e escrever
#   Grupo   : pode ler
#   Outros  : pode ler
# ============================================================
 
# RESOLUÇÃO:
ARQUIVO="${1:-/etc/passwd}"
 
echo "Arquivo : $ARQUIVO"
 
if [ -r "$ARQUIVO" ]; then
    echo "Você    : pode ler"
else
    echo "Você    : sem leitura"
fi
 
if [ -w "$ARQUIVO" ]; then
    echo "Você    : pode escrever"
else
    echo "Você    : sem escrita"
fi
 
if [ -x "$ARQUIVO" ]; then
    echo "Você    : pode executar"
else
    echo "Você    : sem execução"
fi
 
echo "Permissão numérica: $(stat -c '%a' "$ARQUIVO")"
 
 
# ============================================================
# EXERCÍCIO 2
# Crie um script que percorra uma pasta
# e liste apenas os arquivos que o usuário atual
# tem permissão de execução.
# ============================================================
 
# RESOLUÇÃO:
PASTA="${1:-.}"
 
echo "Arquivos executáveis em '$PASTA':"
for ARQUIVO in "$PASTA"/*; do
    if [ -f "$ARQUIVO" ] && [ -x "$ARQUIVO" ]; then
        echo "  $ARQUIVO"
    fi
done
 
 
# ============================================================
# EXERCÍCIO 3
# Crie um script que verifique se está rodando como root.
# - Se for root: exiba "Modo administrador ativado"
# - Se não for: exiba "Execute com sudo!" e saia com erro
# ============================================================
 
# RESOLUÇÃO:
if [ "$EUID" -eq 0 ]; then
    echo "Modo administrador ativado."
else
    echo "Execute com sudo!" >&2
    exit 1
fi