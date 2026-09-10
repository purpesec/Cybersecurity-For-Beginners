#!/usr/bin/env bash
set -euo pipefail

# setup.sh - Preparación del laboratorio "capability sensible" (capítulo 05).
#
# Entorno: VM Ubuntu aislada. Ejecutar como root o con sudo:
#     sudo bash setup.sh
#
# Idempotente: puede ejecutarse varias veces sin acumular efectos. Crea el
# usuario sin privilegios student, instala libcap2-bin si falta, copia el
# intérprete real de Python a /usr/local/bin/pycap, le asigna cap_setuid+ep y
# genera /root/flag.txt con permisos 0600.

FLAG_VALUE="PURPESEC{cap_setuid_lab_05}"
PYCAP="/usr/local/bin/pycap"

# 1. Crear el usuario student si no existe. Representa el acceso inicial.
if id -u student >/dev/null 2>&1; then
    echo "[=] El usuario student ya existe."
else
    useradd -m -s /bin/bash student
    echo "student:student" | chpasswd
    echo "[+] Usuario student creado."
fi

# 2. Instalar libcap2-bin (getcap y setcap) si no está disponible.
if command -v setcap >/dev/null 2>&1 && command -v getcap >/dev/null 2>&1; then
    echo "[=] libcap2-bin ya está instalado."
else
    apt-get update -qq
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq libcap2-bin
    echo "[+] libcap2-bin instalado."
fi

# 3. Resolver la ruta real del intérprete de Python 3 y copiarlo a pycap.
if ! command -v python3 >/dev/null 2>&1; then
    echo "[!] python3 no está instalado; instalando."
    apt-get update -qq
    DEBIAN_FRONTEND=noninteractive apt-get install -y -qq python3
fi
PYTHON_REAL="$(readlink -f "$(command -v python3)")"
echo "[+] Intérprete real de Python: ${PYTHON_REAL}"
cp -f "${PYTHON_REAL}" "${PYCAP}"

# 4. Fijar propiedad y permisos del binario copiado.
chown root:root "${PYCAP}"
chmod 755 "${PYCAP}"

# 5. Asignar CAP_SETUID a los conjuntos effective y permitted del binario.
#    Esto permite al intérprete cambiar su UID a cualquier valor, incluido 0.
setcap cap_setuid+ep "${PYCAP}"

# 6. Crear el flag objetivo, legible solo por root.
printf '%s\n' "${FLAG_VALUE}" > /root/flag.txt
chown root:root /root/flag.txt
chmod 600 /root/flag.txt

# 7. Resumen final del escenario preparado.
echo
echo "==================================================="
echo " Laboratorio cap_setuid preparado"
echo "==================================================="
echo " Usuario sin privilegios : student"
echo " Binario con capability  : ${PYCAP}"
echo " Capability aplicada     : $(getcap "${PYCAP}")"
echo " Flag objetivo           : /root/flag.txt (0600)"
echo
echo " Inicia sesión como student y enumera con:"
echo "   getcap -r / 2>/dev/null"
echo "==================================================="
