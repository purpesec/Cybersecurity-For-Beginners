# Laboratorio: reconocimiento y enumeración con Metasploitable 2

[Inicio](../../../README.md) | [Ethical Hacking](../../README.md) | [Sesión 03](../README.md)

> [!CAUTION]
> Ejecuta estos comandos únicamente contra la VM Metasploitable 2 de tu laboratorio aislado.

## Objetivo

Realizar reconocimiento y enumeración sobre una máquina Metasploitable 2 dentro de una red de laboratorio.

## Requisitos

- Kali Linux y Metasploitable 2 en la misma red host-only.
- Nmap, `smbclient`, WhatWeb, Gobuster, `rpcinfo` y `showmount`.
- Autorización sobre todos los sistemas incluidos en el alcance.

```mermaid
flowchart TD
    A[Red objetivo] --> B[Descubrimiento de hosts]
    B --> C[Escaneo de puertos]
    C --> D[Detección de servicios y versiones]
    D --> E[Enumeración específica]
```

---

## 1. Identificar nuestra red

Primero revisamos la configuración de Kali:

```bash
ip addr
```

Ejemplo:

```text
inet 192.168.56.10/24
```

Esto nos indica:

```text
IP de Kali: 192.168.56.10
Red: 192.168.56.0/24
```

---

## Práctica 1: Descubrimiento de hosts

Buscamos qué dispositivos están activos en nuestra red:

```bash
sudo nmap -sn 192.168.56.0/24
```

`-sn` realiza descubrimiento de hosts sin escanear puertos.

Ejemplo:

```text
192.168.56.1     Host is up
192.168.56.10    Host is up
192.168.56.105   Host is up
```

```mermaid
flowchart TD
    A[192.168.56.0/24] --> B[nmap -sn]
    B --> C[192.168.56.1]
    B --> D[192.168.56.10]
    B --> E[192.168.56.105]
    E --> F[Objetivo seleccionado]
```

Objetivo:

```text
192.168.56.105
```

---

## Práctica 2: Escaneo de puertos

Escaneo básico:

```bash
nmap 192.168.56.105
```

Ejemplo:

```text
PORT     STATE SERVICE
21/tcp   open  ftp
22/tcp   open  ssh
23/tcp   open  telnet
25/tcp   open  smtp
80/tcp   open  http
139/tcp  open  netbios-ssn
445/tcp  open  microsoft-ds
```

```mermaid
flowchart LR
    A[192.168.56.105] --> B[21/tcp]
    A --> C[22/tcp]
    A --> D[80/tcp]
    A --> E[445/tcp]

    B --> B1[FTP]
    C --> C1[SSH]
    D --> D1[HTTP]
    E --> E1[SMB]
```

Para revisar todos los puertos TCP:

```bash
nmap -p- 192.168.56.105
```

`-p-` revisa los puertos TCP del `1` al `65535`.

---

## Práctica 3: Servicios y versiones

Ahora identificamos el software que funciona detrás de cada puerto:

```bash
nmap -sV 192.168.56.105
```

Ejemplo:

```text
21/tcp open ftp  vsftpd 2.3.4
22/tcp open ssh  OpenSSH 4.7p1
80/tcp open http Apache
```

```mermaid
flowchart LR
    A[21/tcp] --> B[FTP]
    B --> C[vsftpd]
    C --> D[2.3.4]
```

Interpretación:

```text
FTP       = servicio
vsftpd    = software
2.3.4     = versión
```

---

## 2. Enumeración de servicios

Una vez encontrados los servicios, los investigamos de forma individual.

```mermaid
flowchart TD
    A[Servicios encontrados] --> B[FTP]
    A --> C[SMB]
    A --> D[HTTP]
    A --> E[RPC]
    A --> F[NFS]

    B --> B1[Acceso anonymous]
    B --> B2[Archivos]

    C --> C1[Shares]
    C --> C2[Acceso sin credenciales]

    D --> D1[Tecnologías]
    D --> D2[Directorios]

    E --> E1[Servicios RPC]

    F --> F1[Exports]
```

---

## Práctica 4: Enumeración FTP

Confirmamos el servicio:

```bash
nmap -p21 -sV 192.168.56.105
```

Nos conectamos:

```bash
ftp 192.168.56.105
```

Probar:

```text
Name: anonymous
```

Una vez dentro:

```bash
pwd
ls
```

También podemos comprobar acceso anónimo con Nmap:

```bash
nmap -p21 --script ftp-anon 192.168.56.105
```

```mermaid
flowchart LR
    A[21/tcp] --> B[FTP]
    B --> C[Intentar anonymous]
    C --> D[Listar archivos]
```

---

## Práctica 5: Enumeración SMB

Confirmamos SMB:

```bash
nmap -p139,445 -sV 192.168.56.105
```

Listamos recursos compartidos:

```bash
smbclient -L //192.168.56.105 -N
```

Opciones:

```text
-L  = listar shares
-N  = no solicitar contraseña
```

También podemos usar NSE:

```bash
nmap -p139,445 --script smb-enum-shares 192.168.56.105
```

```mermaid
flowchart LR
    A[139/445] --> B[SMB]
    B --> C[smbclient]
    C --> D[Listar shares]
```

---

## Práctica 6: Enumeración HTTP

Confirmamos el servicio web:

```bash
nmap -p80 -sV 192.168.56.105
```

Revisamos cabeceras:

```bash
curl -I http://192.168.56.105
```

Identificamos tecnologías:

```bash
whatweb http://192.168.56.105
```

Buscamos directorios:

```bash
gobuster dir -u http://192.168.56.105 -w /usr/share/wordlists/dirb/common.txt
```

Podemos encontrar rutas como:

```text
/admin
/images
/uploads
/dvwa
/phpMyAdmin
```

```mermaid
flowchart TD
    A[80/tcp] --> B[HTTP]
    B --> C[curl -I]
    B --> D[WhatWeb]
    B --> E[Gobuster]

    C --> C1[Cabeceras]
    D --> D1[Tecnologías]
    E --> E1[Directorios]
```

---

## Práctica 7: Enumeración RPC

Si encontramos:

```text
111/tcp open rpcbind
```

Ejecutamos:

```bash
rpcinfo -p 192.168.56.105
```

```mermaid
flowchart LR
    A[Nmap] --> B[111/tcp]
    B --> C[RPCBind]
    C --> D[rpcinfo -p]
    D --> E[Servicios RPC]
```

---

## Práctica 8: Enumeración NFS

Confirmamos NFS:

```bash
nmap -p2049 -sV 192.168.56.105
```

Listamos directorios exportados:

```bash
showmount -e 192.168.56.105
```

Ejemplo:

```text
Export list for 192.168.56.105:
/ *
```

```mermaid
flowchart LR
    A[2049/tcp] --> B[NFS]
    B --> C[showmount -e]
    C --> D[Exports]
```

RPC también puede llevarnos al descubrimiento de NFS:

```mermaid
flowchart LR
    A[Nmap] --> B[111/tcp RPC]
    B --> C[rpcinfo -p]
    C --> D[NFS detectado]
    D --> E[2049/tcp]
    E --> F[showmount -e]
```

---

## Práctica final: Enumeración desde cero

Se entrega únicamente la red:

```text
192.168.56.0/24
```

## Paso 1: Identificar nuestra red

```bash
ip addr
```

## Paso 2: Descubrir hosts

```bash
sudo nmap -sn 192.168.56.0/24
```

## Paso 3: Seleccionar el objetivo

Ejemplo:

```text
192.168.56.105
```

Podemos guardar la IP en una variable:

```bash
IP=192.168.56.105
```

Comprobar:

```bash
echo $IP
```

---

## Paso 4: Escanear puertos

```bash
nmap $IP
```

Todos los puertos TCP:

```bash
nmap -p- $IP
```

---

## Paso 5: Detectar servicios y versiones

```bash
nmap -sV $IP
```

---

## Paso 6: FTP

```bash
nmap -p21 -sV $IP
ftp $IP
```

Probar:

```text
anonymous
```

Comprobación automática:

```bash
nmap -p21 --script ftp-anon $IP
```

---

## Paso 7: SMB

```bash
nmap -p139,445 -sV $IP
```

```bash
smbclient -L //$IP -N
```

```bash
nmap -p139,445 --script smb-enum-shares $IP
```

---

## Paso 8: HTTP

```bash
nmap -p80 -sV $IP
```

```bash
curl -I http://$IP
```

```bash
whatweb http://$IP
```

```bash
gobuster dir -u http://$IP -w /usr/share/wordlists/dirb/common.txt
```

---

## Paso 9: RPC

```bash
rpcinfo -p $IP
```

---

## Paso 10: NFS

```bash
nmap -p2049 -sV $IP
```

```bash
showmount -e $IP
```

---

## Flujo completo

```mermaid
flowchart TD
    A[ip addr] --> B[Identificar red]
    B --> C[nmap -sn]
    C --> D[Descubrir objetivo]
    D --> E[nmap]
    E --> F[Puertos abiertos]
    F --> G[nmap -sV]
    G --> H[Servicios y versiones]
    H --> I[Enumeración específica]

    I --> J[FTP]
    I --> K[SMB]
    I --> L[HTTP]
    I --> M[RPC]
    I --> N[NFS]

    J --> J1[ftp / ftp-anon]
    K --> K1[smbclient / NSE]
    L --> L1[curl / WhatWeb / Gobuster]
    M --> M1[rpcinfo]
    N --> N1[showmount]
```

---

## Resultado de la enumeración

```mermaid
flowchart TD
    A[Objetivo 192.168.56.105]

    A --> B[FTP 21]
    B --> B1[Software]
    B --> B2[Versión]
    B --> B3[Anonymous]

    A --> C[SSH 22]
    C --> C1[Software]
    C --> C2[Versión]

    A --> D[HTTP 80]
    D --> D1[Servidor]
    D --> D2[Tecnologías]
    D --> D3[Directorios]

    A --> E[SMB 139/445]
    E --> E1[Software]
    E --> E2[Shares]

    A --> F[RPC 111]
    F --> F1[Servicios RPC]

    A --> G[NFS 2049]
    G --> G1[Exports]
```

## Comandos principales

```bash
# Identificar la red
ip addr

# Descubrir hosts
sudo nmap -sn 192.168.56.0/24

# Escaneo básico
nmap $IP

# Todos los puertos TCP
nmap -p- $IP

# Servicios y versiones
nmap -sV $IP

# FTP
ftp $IP
nmap -p21 --script ftp-anon $IP

# SMB
smbclient -L //$IP -N
nmap -p139,445 --script smb-enum-shares $IP

# HTTP
curl -I http://$IP
whatweb http://$IP
gobuster dir -u http://$IP -w /usr/share/wordlists/dirb/common.txt

# RPC
rpcinfo -p $IP

# NFS
showmount -e $IP
```

## Validación final

```text
[ ] La red y el objetivo están documentados
[ ] Se revisaron todos los puertos TCP
[ ] Los servicios incluyen versión cuando fue posible
[ ] FTP, SMB, HTTP, RPC y NFS fueron enumerados por separado
[ ] Los resultados distinguen observaciones de vulnerabilidades confirmadas
[ ] No se realizó explotación
```

## Entrega

Crea una tabla con `puerto`, `servicio`, `versión`, `evidencia` y `siguiente comprobación`. Añade los comandos utilizados y un resumen de la superficie de ataque observada.

[Volver a la sesión](../README.md) | [Volver a Ethical Hacking](../../README.md) | [Inicio](../../../README.md)
