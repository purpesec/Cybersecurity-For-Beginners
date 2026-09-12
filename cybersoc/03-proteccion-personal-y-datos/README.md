# 03. Protección personal y de datos

[CyberSOC](../README.md) | [Inicio](../../README.md)

## Objetivo

Aplicar controles básicos para proteger cuentas, dispositivos, redes y datos durante todo su ciclo de vida.

## Datos y estados

Los datos pueden estar en reposo, en uso o en tránsito. El control depende del estado: cifrado de disco para reposo, mínimo privilegio durante el uso y TLS para tránsito. Ninguno evita por sí solo una sesión autorizada comprometida.

## Controles mínimos

### Dispositivo

Actualiza sistema, navegador y aplicaciones; instala software desde fuentes confiables; activa firewall y protección antimalware; bloquea la sesión; usa MFA; mantén copias automáticas y probadas.

### Cuenta

Usa una frase larga y única por servicio. Guarda claves en un administrador. Rechaza solicitudes MFA que no iniciaste y revisa sesiones y aplicaciones OAuth conectadas.

### Red inalámbrica

Cambia credenciales predeterminadas, prefiere WPA3 o WPA2 actualizado, separa invitados e IoT y desactiva conexión automática en redes públicas.

### Respaldo y eliminación

Aplica la regla 3-2-1: tres copias, dos medios distintos y una fuera del sitio. Cifra respaldos, limita quién los modifica y prueba la restauración. Borrar una copia local no elimina réplicas ni respaldos.

## Práctica guiada

~~~bash
lsblk
df -h
ss -tulpen
id
getent passwd | head
find /home -maxdepth 2 -type f -perm -o+r 2>/dev/null | head
~~~

Interpreta qué datos están expuestos, qué control falta y qué evidencia conservarías. No recolectes datos personales reales.

## Entrega

Inventario de activos y datos, matriz estado del dato → control y procedimiento de restauración probado.

[Volver al índice CyberSOC](../README.md)
