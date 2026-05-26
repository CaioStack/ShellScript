#!/bin/bash
# ============================================================
# 09 - PERMISSÕES E USUÁRIOS
# ============================================================
# No Linux, todo arquivo tem permissões para 3 tipos de dono:
#
#   dono (u) | grupo (g) | outros (o)
#   rwx      | rwx       | rwx
#
#   r = leitura   (4)
#   w = escrita   (2)
#   x = execução  (1)
#
# Exemplo: 755 = dono(rwx=7) grupo(rx=5) outros(rx=5)
# ============================================================
 
 
# ============================================================
# EXEMPLO 1 - Ver permissões de um arquivo
# ============================================================
 
ls -l /etc/passwd
stat -c '%A %a %n' /etc/passwd
 
 
# ============================================================
# EXEMPLO 2 - Alterar permissões com chmod
# ============================================================
 
touch /tmp/teste_perm.txt
chmod 644 /tmp/teste_perm.txt
chmod 755 /tmp/teste_perm.txt
chmod u+x /tmp/teste_perm.txt
chmod o-rwx /tmp/teste_perm.txt
 
 
# ============================================================
# EXEMPLO 3 - Verificar se tem permissão
# ============================================================
 
ARQUIVO="/etc/passwd"
 
if [ -r "$ARQUIVO" ]; then
    echo "Tenho permissão de LEITURA"
fi
 
if [ -w "$ARQUIVO" ]; then
    echo "Tenho permissão de ESCRITA"
else
    echo "Sem permissão de escrita"
fi
 
 
# ============================================================
# EXEMPLO 4 - Informações de usuários
# ============================================================
 
echo "Usuário: $USER"
echo "UID    : $EUID"
echo "Grupos : $(groups)"
 
if [ "$EUID" -eq 0 ]; then
    echo "Rodando como root"
else
    echo "Não é root (UID: $EUID)"
fi
 
 
# ============================================================
# EXEMPLO 5 - Listar usuários do sistema
# ============================================================
 
echo "Usuários comuns (UID >= 1000):"
while IFS=: read -r nome senha uid resto; do
    if [ "$uid" -ge 1000 ] && [ "$nome" != "nobody" ]; then
        echo "  $nome (UID: $uid)"
    fi
done < /etc/passwd