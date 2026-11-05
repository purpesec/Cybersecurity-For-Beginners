#!/usr/bin/env bash
set -euo pipefail

# setup.sh - Preparación del laboratorio "Enumeración local guiada".
#
# Pertenece al capítulo 02 (Enumeración local del sistema) de la ruta
# Privilege Escalation. Debe ejecutarse con sudo dentro de una VM Ubuntu
# aislada y sin conexión a Internet:
#
#     sudo bash setup.sh
#
# El script es idempotente: puede ejecutarse varias veces sin duplicar
# usuarios, directorios ni entradas de cron. No crea rutas de escalada
# explotables; únicamente genera objetos observables para enumerar.

# Comprueba que se ejecuta con privilegios administrativos.
if [ "$(id -u)" -ne 0 ]; then
    echo "[!] Este script debe ejecutarse con sudo o como root." >&2
    exit 1
fi

# ---------------------------------------------------------------------------
# 1. Cuenta sin privilegios que representa el acceso inicial.
#    No se añade a ningún grupo administrativo (sin sudo).
# ---------------------------------------------------------------------------
if ! id -u student >/dev/null 2>&1; then
    useradd --create-home --shell /bin/bash student
    # Contraseña de laboratorio; válida solo en la VM aislada.
    echo 'student:student' | chpasswd
    echo "[+] Usuario 'student' creado sin privilegios administrativos."
else
    echo "[=] El usuario 'student' ya existe; no se modifica."
fi

# ---------------------------------------------------------------------------
# 2. Cuenta de servicio con shell no interactiva.
# ---------------------------------------------------------------------------
if ! id -u svc-backup >/dev/null 2>&1; then
    useradd --system \
        --shell /usr/sbin/nologin \
        --home-dir /var/lib/svc-backup \
        --no-create-home \
        svc-backup
    echo "[+] Usuario 'svc-backup' creado con shell /usr/sbin/nologin."
else
    echo "[=] El usuario 'svc-backup' ya existe; no se modifica."
fi

# ---------------------------------------------------------------------------
# 3. Directorio compartido escribible por cualquier usuario.
#    Es un elemento observable, no una vía de escalada por sí mismo.
# ---------------------------------------------------------------------------
install -d -m 0777 /opt/shared

if [ ! -f /opt/shared/datos-backup.txt ]; then
    cat > /opt/shared/datos-backup.txt <<'DATA'
# Archivo de datos de ejemplo del laboratorio.
# No contiene credenciales ni secretos reales.
origen=127.0.0.1
destino=127.0.0.1
retencion_dias=7
estado=sincronizado
DATA
fi
chmod 0644 /opt/shared/datos-backup.txt

# ---------------------------------------------------------------------------
# 4. Entrada de cron señuelo.
#    Invoca un script que no existe. La ruta /usr/local/bin pertenece a root
#    con modo 755, por lo que no es escribible por el usuario sin privilegios:
#    el objetivo es que la entrada sea descubierta al enumerar, no explotarla.
# ---------------------------------------------------------------------------
CRON_FILE=/etc/cron.d/privesc-enum
cat > "$CRON_FILE" <<'CRON'
# Laboratorio de enumeración local (capítulo 02).
# El script referenciado a continuación no existe de forma intencional.
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/15 * * * * root /usr/local/bin/privesc-enum.sh
CRON
chown root:root "$CRON_FILE"
chmod 0644 "$CRON_FILE"

echo "[+] Preparación completada."
echo "    Usa 'su - student' para comenzar la enumeración."
