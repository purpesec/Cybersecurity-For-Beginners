#!/usr/bin/env bash
#
# setup.sh - Aprovisiona el laboratorio del capitulo 07 de privilege-escalation.
#
# Escenario: una ruta de escalada real con sudo sobre /usr/bin/env y cuatro
# senuelos que deben clasificarse antes de actuar. Debe ejecutarse como root
# o mediante sudo dentro de una VM Ubuntu aislada.
#
# Uso:
#   sudo bash setup.sh
#
# El script es idempotente: puede repetirse sin duplicar archivos ni entradas.
set -euo pipefail

LAB_LOG="/var/log/privesc-lab.log"
SUDOERS_FILE="/etc/sudoers.d/privesc-lab"
CRON_FILE="/etc/cron.d/privesc-lab"
TOOLS_DIR="/opt/tools"
STUDENT_HOME="/home/student"
FLAG_FILE="/root/flag.txt"

# Exige privilegios administrativos.
if [[ "$(id -u)" -ne 0 ]]; then
    echo "Este script debe ejecutarse como root o con sudo." >&2
    exit 1
fi

# ---------------------------------------------------------------------------
# 1. Asegura la cuenta sin privilegios administrativos.
# ---------------------------------------------------------------------------
if ! id student >/dev/null 2>&1; then
    useradd -m -s /bin/bash student
    echo "[+] Usuario student creado."
else
    echo "[=] Usuario student ya existe."
fi

# Retira a student de cualquier grupo con privilegios administrativos.
for group in sudo admin; do
    if id -nG student | tr ' ' '\n' | grep -qx "$group"; then
        deluser student "$group" >/dev/null 2>&1 || true
        echo "[+] student retirado del grupo $group."
    fi
done

# ---------------------------------------------------------------------------
# 2. RUTA REAL: regla de sudo sin contrasena sobre /usr/bin/env.
#    /usr/bin/env ejecuta el comando que recibe como argumento, por lo que
#    permite lanzar una shell con privilegios de root.
# ---------------------------------------------------------------------------
tmp_sudoers="$(mktemp)"
trap 'rm -f "$tmp_sudoers"' EXIT
cat > "$tmp_sudoers" <<'EOF'
student ALL=(root) NOPASSWD: /usr/bin/env
EOF
chmod 0440 "$tmp_sudoers"

# Valida la sintaxis antes de instalarla para no romper sudoers.
visudo -cf "$tmp_sudoers"
install -m 0440 -o root -g root "$tmp_sudoers" "$SUDOERS_FILE"
visudo -cf "$SUDOERS_FILE"
echo "[+] Regla real instalada en $SUDOERS_FILE."

# ---------------------------------------------------------------------------
# 3. Herramientas y senuelos.
# ---------------------------------------------------------------------------
install -d -m 0755 -o root -g root "$TOOLS_DIR"

# SENUELO 1: script escribible por cualquiera, pero sin consumidor privilegiado.
cat > "$TOOLS_DIR/cleanup.sh" <<'EOF'
#!/usr/bin/env bash
# Script de limpieza de ejemplo. No es invocado por ningun cron ni timer.
echo "cleanup ejecutado por $(id -un)"
EOF
chmod 0777 "$TOOLS_DIR/cleanup.sh"

# SENUELO 2: archivo .env con un token ficticio que no concede acceso.
cat > "$TOOLS_DIR/notes.env" <<'EOF'
# Valores ficticios de laboratorio. No son credenciales reales.
API_KEY=lab-demo-no-real
DB_HOST=127.0.0.1
DB_USER=appuser
EOF
chmod 0644 "$TOOLS_DIR/notes.env"

# SENUELO 4: script propiedad de root y no escribible, consumido por cron.
# Intentar modificarlo como student falla con permiso denegado.
cat > "$TOOLS_DIR/locked.sh" <<'EOF'
#!/usr/bin/env bash
# Tarea privilegiada legitima. El archivo no es escribible por student.
echo "$(date -Is) locked.sh ejecutado" >> /var/log/privesc-lab.log
EOF
chown root:root "$TOOLS_DIR/locked.sh"
chmod 0755 "$TOOLS_DIR/locked.sh"

# Entrada de cron que apunta al script protegido (senuelo 4).
cat > "$CRON_FILE" <<'EOF'
# Laboratorio privilege-escalation - tarea privilegiada no explotable.
*/5 * * * * root /opt/tools/locked.sh
EOF
chmod 0644 "$CRON_FILE"
chown root:root "$CRON_FILE"
echo "[+] Herramientas y senuelos creados en $TOOLS_DIR."

# ---------------------------------------------------------------------------
# 4. SENUELO 3: contrasena antigua ficticia en el historial de student.
#    El valor no es valido en el sistema ni autentica contra ninguna cuenta.
# ---------------------------------------------------------------------------
history_file="$STUDENT_HOME/.bash_history"
touch "$history_file"
if ! grep -q "Winter2023!" "$history_file" 2>/dev/null; then
    echo 'mysql -u root -pWinter2023!' >> "$history_file"
fi
chown student:student "$history_file"
chmod 0600 "$history_file"
echo "[+] Historial de student preparado."

# ---------------------------------------------------------------------------
# 5. Prueba de objetivo: solo legible por root.
# ---------------------------------------------------------------------------
echo 'PURPESEC{sudo_env_route}' > "$FLAG_FILE"
chown root:root "$FLAG_FILE"
chmod 0600 "$FLAG_FILE"
echo "[+] Flag de laboratorio creada en $FLAG_FILE (0600)."

# ---------------------------------------------------------------------------
# Resumen final.
# ---------------------------------------------------------------------------
cat <<'EOF'

============================================================
 Laboratorio privilege-escalation 07 aprovisionado
============================================================
 RUTA REAL
   [sudo] student ALL=(root) NOPASSWD: /usr/bin/env
   Prueba como student:  sudo /usr/bin/env /bin/sh

 SENUELOS
   1) /opt/tools/cleanup.sh   0777, sin cron ni timer que lo consuma
   2) /opt/tools/notes.env    API_KEY ficticia (lab-demo-no-real)
   3) ~/.bash_history de student con Winter2023! (no valida)
   4) cron -> /opt/tools/locked.sh 0755 root, no escribible

 OBJETIVO
   /root/flag.txt (0600)

 Limpieza:
   sudo rm -f /etc/sudoers.d/privesc-lab /root/flag.txt
   sudo rm -rf /opt/tools
   sudo rm -f /etc/cron.d/privesc-lab
   (o revertir la instantanea de la VM)
============================================================
EOF
