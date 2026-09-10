#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------------------------------------
# Laboratorio: script de root escribible (Privilege Escalation, Capítulo 06).
#
# Este script provisiona de forma INTENCIONAL una tarea cron que ejecuta como
# root un script que el grupo de laboratorio puede modificar. Es material
# educativo y solo debe ejecutarse en una VM Ubuntu aislada y autorizada.
#
#   sudo bash setup.sh
#
# El script es idempotente: puede ejecutarse varias veces sin duplicar estado.
# ---------------------------------------------------------------------------

LAB_USER="student"
LAB_DIR="/opt/maintenance"
LAB_SCRIPT="${LAB_DIR}/backup.sh"
LAB_LOG="/var/log/maintenance.log"
CRON_FILE="/etc/cron.d/privesc-lab"
FLAG_FILE="/root/flag.txt"
LAB_FLAG="PURPESEC{cron_writable_script_demo}"

# Verifica privilegios: todo el aprovisionamiento requiere root.
if [[ "${EUID}" -ne 0 ]]; then
    echo "[!] Ejecuta este script con sudo." >&2
    exit 1
fi

# 1. Crea la cuenta sin privilegios si no existe.
if id "${LAB_USER}" >/dev/null 2>&1; then
    echo "[=] La cuenta ${LAB_USER} ya existe."
else
    echo "[+] Creando la cuenta ${LAB_USER}..."
    useradd --create-home --shell /bin/bash "${LAB_USER}"
fi

# 2. Instala y habilita cron si no esta disponible o no esta activo.
if ! command -v crontab >/dev/null 2>&1; then
    echo "[+] Instalando el paquete cron..."
    apt-get update
    apt-get install -y cron
fi

if ! systemctl is-active --quiet cron; then
    echo "[+] Habilitando y arrancando cron..."
    systemctl enable --now cron
else
    echo "[=] cron ya esta activo."
fi

# 3. Crea el directorio de mantenimiento protegido (root:root 0755).
echo "[+] Preparando ${LAB_DIR}..."
mkdir -p "${LAB_DIR}"
chown root:root "${LAB_DIR}"
chmod 0755 "${LAB_DIR}"

# 4. Escribe el script que root ejecutara. Su contenido es inofensivo:
#    registra la fecha y la marca de la ejecucion en el log de mantenimiento.
cat > "${LAB_SCRIPT}" <<'SCRIPT'
#!/usr/bin/env bash
set -euo pipefail
echo "$(date -Is) maintenance backup executed" >> /var/log/maintenance.log
SCRIPT

# 5. El script pertenece a root pero el grupo student puede escribirlo (0770).
#    Esa concesion de escritura es la vulnerabilidad intencional del laboratorio.
chown root:"${LAB_USER}" "${LAB_SCRIPT}"
chmod 0770 "${LAB_SCRIPT}"

# 6. Registra la tarea cron que ejecuta el script como root cada minuto.
#    cron relee /etc/cron.d automaticamente, sin necesidad de reiniciar.
cat > "${CRON_FILE}" <<'CRON'
# Laboratorio Purpesec Academy - Capitulo 06.
# Ejecuta el script de mantenimiento como root cada minuto.
* * * * * root /opt/maintenance/backup.sh
CRON
chown root:root "${CRON_FILE}"
chmod 0644 "${CRON_FILE}"

# 7. Crea el flag objetivo, legible unicamente por root.
echo "${LAB_FLAG}" > "${FLAG_FILE}"
chown root:root "${FLAG_FILE}"
chmod 0600 "${FLAG_FILE}"

# 8. Resumen final y recordatorio del ciclo de ejecucion.
cat <<SUMMARY

[+] Laboratorio preparado.
    Cuenta sin privilegios : ${LAB_USER}
    Script privilegiado    : ${LAB_SCRIPT} (root:${LAB_USER}, modo 0770)
    Tarea cron             : ${CRON_FILE} (* * * * * root /opt/maintenance/backup.sh)
    Registro de actividad  : ${LAB_LOG}
    Flag de laboratorio    : ${FLAG_FILE} (modo 0600, solo root)

[!] La tarea se ejecuta cada minuto. Tras modificar el script, espera hasta
    sesenta segundos a que cron dispare el siguiente ciclo antes de validar.

[!] Entorno de laboratorio. Revierte la instantanea al terminar para eliminar
    la configuracion vulnerable.
SUMMARY
