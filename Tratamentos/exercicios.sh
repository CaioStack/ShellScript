# ============================================================
# EXERCÍCIO 1
# Reescreva um script simples aplicando boas práticas:
# - Verificação de argumentos
# - Mensagens de erro para stderr
# - Log de execução
# - trap para limpar arquivos temporários
# ============================================================
 
# RESOLUÇÃO:
LOG="/tmp/exercicio1.log"
TEMP=$(mktemp)
trap 'rm -f "$TEMP"; echo "Encerrado." >> "$LOG"' EXIT
 
registrar() {
    echo "[$(date '+%d/%m/%Y %H:%M:%S')] $1" | tee -a "$LOG"
}
 
if [ -z "$1" ]; then
    echo "Uso: $0 <nome>" >&2
    exit 1
fi
 
registrar "Script iniciado"
registrar "Argumento recebido: $1"
echo "Olá, $1!" | tee "$TEMP"
registrar "Script finalizado"
 
 
# ============================================================
# EXERCÍCIO 2
# Crie um script que tente criar uma pasta.
# Se der erro, tente criar em outro lugar.
# Registre cada tentativa no log.
# ============================================================
 
# RESOLUÇÃO:
LOG2="/tmp/tentativas.log"
 
tentar_criar() {
    CAMINHO=$1
    echo "[$(date '+%H:%M:%S')] Tentando criar: $CAMINHO" >> "$LOG2"
 
    if mkdir "$CAMINHO" 2>/dev/null; then
        echo "Pasta criada em: $CAMINHO" | tee -a "$LOG2"
        return 0
    else
        echo "Falhou em: $CAMINHO" | tee -a "$LOG2"
        return 1
    fi
}
 
tentar_criar "/root/pasta_restrita" || tentar_criar "/tmp/pasta_alternativa"
 
 
# ============================================================
# EXERCÍCIO 3
# Verifique se os seguintes comandos estão instalados:
# git, curl, python3, vim
# Para cada um, diga se está ou não instalado.
# ============================================================
 
# RESOLUÇÃO:
COMANDOS=("git" "curl" "python3" "vim")
 
for CMD in "${COMANDOS[@]}"; do
    if command -v "$CMD" > /dev/null 2>&1; then
        echo "  ✔ $CMD está instalado"
    else
        echo "  ✘ $CMD NÃO está instalado"
    fi
done