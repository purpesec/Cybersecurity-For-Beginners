# Cloud y servicios

[Inicio](../../README.md) · [Requisitos previos](../README.md) · [Anterior: Threat intel y hunting](../11-threat-intel-y-hunting/README.md) · [Siguiente: Herramientas de análisis](../13-herramientas-de-analisis/README.md)

La nube cambió el perímetro: ya no hay solo servidores propios, sino servicios contratados, identidades federadas y APIs. Este módulo explica los modelos de servicio, los proveedores principales, la seguridad compartida y los servicios de almacenamiento y productividad que aparecen en cualquier inventario.

## Contenido

| # | Concepto |
|---|---|
| 12.1 | [Habilidades y conocimientos de cloud](#121-habilidades-y-conocimientos-de-cloud) |
| 12.2 | [IaaS](#122-iaas) |
| 12.3 | [PaaS](#123-paas) |
| 12.4 | [SaaS](#124-saas) |
| 12.5 | [Nube pública](#125-nube-pública) |
| 12.6 | [Nube privada](#126-nube-privada) |
| 12.7 | [Nube híbrida](#127-nube-híbrida) |
| 12.8 | [AWS](#128-aws) |
| 12.9 | [Azure](#129-azure) |
| 12.10 | [GCP](#1210-gcp) |
| 12.11 | [S3](#1211-s3) |
| 12.12 | [Seguridad en la nube](#1212-seguridad-en-la-nube) |
| 12.13 | [Infraestructura como código](#1213-infraestructura-como-código) |
| 12.14 | [Serverless](#1214-serverless) |
| 12.15 | [Despliegue en la nube](#1215-despliegue-en-la-nube) |
| 12.16 | [Cloud frente a on-premises](#1216-cloud-frente-a-on-premises) |
| 12.17 | [NAS y SAN](#1217-nas-y-san) |
| 12.18 | [Box](#1218-box) |
| 12.19 | [Dropbox](#1219-dropbox) |
| 12.20 | [OneDrive](#1220-onedrive) |
| 12.21 | [Google Drive](#1221-google-drive) |
| 12.22 | [iCloud](#1222-icloud) |
| 12.23 | [Microsoft Office](#1223-microsoft-office) |
| 12.24 | [Google Workspace](#1224-google-workspace) |
| 12.25 | [Suites de productividad](#1225-suites-de-productividad) |

---

### 12.1 Habilidades y conocimientos de cloud

Trabajar en cloud exige entender redes virtuales, identidad, almacenamiento, cómputo, automatización y el modelo de responsabilidad compartida. La configuración sustituye al cableado: un error de permisos puede exponer datos.

**Claves:**
- Modelos de servicio: IaaS, PaaS y SaaS.
- Identidad y acceso (IAM) son el nuevo perímetro.
- Todo se define por API y, a menudo, por código.
- El proveedor protege la infraestructura; el cliente, sus datos y configuraciones.
- La visibilidad depende de los registros que se habiliten.

**En el curso:** [CyberSOC](../../cybersoc/README.md) y arquitecturas híbridas.

**Fuentes:** [NIST SP 800-145](https://csrc.nist.gov/pubs/sp/800/145/final) · [AWS — Well-Architected](https://aws.amazon.com/architecture/well-architected/) · [Microsoft — Azure architecture](https://learn.microsoft.com/en-us/azure/architecture/)

---

### 12.2 IaaS

IaaS (*Infrastructure as a Service*) ofrece máquinas virtuales, redes y almacenamiento bajo demanda. El cliente administra el sistema operativo y todo lo que se ejecuta encima.

**Claves:**
- El proveedor gestiona hardware, virtualización y red física.
- El cliente parchea, configura y protege sus máquinas.
- Ejemplos: EC2, Azure Virtual Machines, Compute Engine.
- Un grupo de seguridad mal abierto equivale a un puerto expuesto.
- La instantánea y la plantilla reemplazan al instalador manual.

**En el curso:** [setup](../../setup/README.md) y [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-145](https://csrc.nist.gov/pubs/sp/800/145/final) · [AWS — EC2](https://docs.aws.amazon.com/ec2/) · [Microsoft — Virtual Machines](https://learn.microsoft.com/en-us/azure/virtual-machines/)

---

### 12.3 PaaS

PaaS (*Platform as a Service*) ofrece un entorno gestionado para desplegar aplicaciones sin administrar el sistema operativo. El proveedor mantiene el runtime, el escalado y parte de la seguridad.

**Claves:**
- El cliente se centra en código, datos y configuración.
- El escalado y el parcheo del runtime son responsabilidad del proveedor.
- Ejemplos: App Service, Elastic Beanstalk, Cloud Run.
- La configuración de la plataforma también puede exponer datos.
- Menos control implica menos superficie que administrar.

**En el curso:** [Pentesting Web](../../pentesting-web/README.md) en despliegues gestionados.

**Fuentes:** [NIST SP 800-145](https://csrc.nist.gov/pubs/sp/800/145/final) · [Microsoft — App Service](https://learn.microsoft.com/en-us/azure/app-service/) · [Google Cloud — PaaS](https://cloud.google.com/paas)

---

### 12.4 SaaS

SaaS (*Software as a Service*) entrega una aplicación completa por suscripción. El cliente solo configura usuarios, permisos y datos.

**Claves:**
- El proveedor gestiona infraestructura, aplicación y parches.
- Ejemplos: Microsoft 365, Google Workspace, Salesforce.
- Los riesgos se trasladan a identidad, compartición y configuración.
- La exportación y la retención de datos deben planificarse.
- El cumplimiento depende de lo que el proveedor certifique.

**En el curso:** [CyberSOC](../../cybersoc/README.md) y gobierno de identidad.

**Fuentes:** [NIST SP 800-145](https://csrc.nist.gov/pubs/sp/800/145/final) · [Microsoft — Microsoft 365](https://learn.microsoft.com/en-us/microsoft-365/) · [Google Workspace — Security](https://workspace.google.com/security/)

---

### 12.5 Nube pública

La nube pública ofrece recursos compartidos sobre infraestructura del proveedor, accesibles por Internet y facturados por uso. AWS, Azure y GCP son los principales.

**Claves:**
- Elasticidad y pago por consumo.
- Multiinquilino: el aislamiento depende del proveedor.
- La configuración por defecto no siempre es segura.
- La exposición accidental de almacenamiento es un clásico.
- Los registros y la auditoría son responsabilidad del cliente.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-145](https://csrc.nist.gov/pubs/sp/800/145/final) · [CISA — Cloud security](https://www.cisa.gov/topics/cybersecurity-best-practices) · [AWS — Cloud security](https://aws.amazon.com/security/)

---

### 12.6 Nube privada

La nube privada ofrece servicios cloud sobre infraestructura dedicada a una organización, propia o alojada. Aporta control y cumplimiento a cambio de coste y mantenimiento.

**Claves:**
- Se implementa con virtualización propia (VMware, Proxmox, OpenStack).
- Mantiene el control de datos y ubicación.
- No elimina la necesidad de automatización y gobierno.
- Puede ser tan expuesta como una pública mal configurada.
- Suele integrarse en un modelo híbrido.

**En el curso:** [CyberSOC](../../cybersoc/README.md) y laboratorio local.

**Fuentes:** [NIST SP 800-145](https://csrc.nist.gov/pubs/sp/800/145/final) · [NIST SP 800-125](https://csrc.nist.gov/pubs/sp/800/125/final) · [Proxmox — Documentation](https://pve.proxmox.com/pve-docs/)

---

### 12.7 Nube híbrida

La nube híbrida combina entornos públicos y privados con orquestación y conectividad entre ambos. Permite mantener datos sensibles dentro y escalar fuera.

**Claves:**
- Requiere identidad unificada y red consistente.
- La VPN o el enlace dedicado son la pieza de unión.
- La complejidad aumenta: dos modelos de seguridad.
- La ubicación de los datos debe estar documentada.
- Es habitual en migraciones graduales.

**En el curso:** [CyberSOC](../../cybersoc/02-arquitectura-soc/README.md).

**Fuentes:** [NIST SP 800-145](https://csrc.nist.gov/pubs/sp/800/145/final) · [NIST SP 800-207](https://csrc.nist.gov/pubs/sp/800/207/final) · [Microsoft — Hybrid cloud](https://learn.microsoft.com/en-us/azure/architecture/guide/technology-choices/technology-choices-overview)

---

### 12.8 AWS

AWS es la plataforma cloud de Amazon. Ofrece cómputo (EC2), almacenamiento (S3), red (VPC), identidad (IAM) y cientos de servicios gestionados.

**Claves:**
- IAM define usuarios, roles y políticas; es el control central.
- VPC estructura redes y subredes.
- CloudTrail registra llamadas a la API.
- S3 aloja objetos; un bucket público es una filtración.
- La facturación por uso exige control de costes.

**En el curso:** contexto de seguridad cloud en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [AWS — Documentation](https://docs.aws.amazon.com/) · [AWS — IAM](https://docs.aws.amazon.com/iam/) · [AWS — Security best practices](https://docs.aws.amazon.com/security/)

---

### 12.9 Azure

Azure es la plataforma cloud de Microsoft, integrada con Entra ID (antes Azure AD) y el ecosistema Windows. Ofrece máquinas virtuales, App Service, almacenamiento y servicios de seguridad.

**Claves:**
- Entra ID gestiona identidades y acceso condicional.
- Los grupos de seguridad de red filtran tráfico en la VPC.
- Azure Policy aplica configuraciones.
- Defender for Cloud evalúa la postura.
- La integración con Active Directory local es habitual.

**En el curso:** [CyberSOC](../../cybersoc/README.md) y entornos Microsoft.

**Fuentes:** [Microsoft — Azure](https://learn.microsoft.com/en-us/azure/) · [Microsoft — Entra ID](https://learn.microsoft.com/en-us/entra/identity/) · [Microsoft — Defender for Cloud](https://learn.microsoft.com/en-us/azure/defender-for-cloud/)

---

### 12.10 GCP

Google Cloud (GCP) es la plataforma cloud de Google. Destaca en datos, Kubernetes (GKE) y servicios de machine learning.

**Claves:**
- IAM con roles predefinidos y personalizados.
- VPC global y reglas de firewall por instancia o red.
- Cloud Storage para objetos; los permisos son críticos.
- Kubernetes gestionado con GKE.
- Registro de auditoría con Cloud Audit Logs.

**En el curso:** contexto de seguridad cloud.

**Fuentes:** [Google Cloud — Documentation](https://cloud.google.com/docs) · [Google Cloud — IAM](https://cloud.google.com/iam/docs) · [Google Cloud — Security](https://cloud.google.com/security)

---

### 12.11 S3

S3 (*Simple Storage Service*) es el almacenamiento de objetos de AWS. Los datos se guardan en *buckets* con claves y políticas de acceso.

**Claves:**
- Un bucket público expone todos sus objetos a Internet.
- Las políticas de bucket y de IAM se combinan.
- El cifrado en reposo y el versionado son configurables.
- Los registros de acceso permiten auditar quién leyó qué.
- Es un objetivo habitual de búsqueda de filtraciones.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [AWS — S3](https://docs.aws.amazon.com/s3/) · [AWS — S3 security](https://docs.aws.amazon.com/AmazonS3/latest/userguide/security.html) · [AWS — IAM policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)

---

### 12.12 Seguridad en la nube

La seguridad en la nube aplica los mismos principios (identidad, mínimo privilegio, cifrado, registro) a un entorno que se define por API y se comparte con un proveedor.

**Claves:**
- Modelo de responsabilidad compartida.
- Identidad como perímetro principal.
- Configuración segura por defecto y auditoría continua.
- Cifrado en tránsito y en reposo.
- Visibilidad mediante registros y CSPM.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-144](https://csrc.nist.gov/pubs/sp/800/144/final) · [NIST SP 800-210](https://csrc.nist.gov/pubs/sp/800/210/final) · [CISA — Cloud security](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 12.13 Infraestructura como código

IaC define infraestructura en archivos versionables (Terraform, CloudFormation, Bicep, Ansible). Permite revisar, repetir y auditar cambios.

**Claves:**
- La infraestructura pasa a revisarse como código.
- Los secretos no deben quedar en el repositorio.
- El estado de Terraform puede contener datos sensibles.
- Los cambios no revisados pueden abrir puertos o permisos.
- Se integra en CI/CD con validaciones y políticas.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-204D](https://csrc.nist.gov/pubs/sp/800/204/d/final) · [HashiCorp — Terraform](https://developer.hashicorp.com/terraform/docs) · [AWS — CloudFormation](https://docs.aws.amazon.com/cloudformation/)

---

### 12.14 Serverless

Serverless ejecuta código bajo demanda sin administrar servidores. El proveedor escala y factura por invocación; el cliente se centra en la función y sus permisos.

**Claves:**
- Ejemplos: AWS Lambda, Azure Functions, Cloud Functions.
- Cada función necesita permisos mínimos y su propio rol.
- El evento de entrada es una superficie de ataque.
- Los registros y trazas son la principal visibilidad.
- El tiempo de ejecución y la concurrencia tienen límites.

**En el curso:** arquitecturas modernas en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [NIST SP 800-145](https://csrc.nist.gov/pubs/sp/800/145/final) · [AWS — Lambda](https://docs.aws.amazon.com/lambda/) · [Microsoft — Functions](https://learn.microsoft.com/en-us/azure/azure-functions/)

---

### 12.15 Despliegue en la nube

El despliegue cloud es el proceso de crear y publicar recursos: cuentas, red, identidad, cómputo, almacenamiento y aplicaciones. Debe ser repetible y auditable.

**Claves:**
- Separar entornos (desarrollo, pruebas, producción).
- Aplicar etiquetas para coste y responsabilidad.
- Usar plantillas y pipelines en lugar de consola manual.
- Verificar la configuración tras cada despliegue.
- Planificar la eliminación de recursos para evitar costes.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [AWS — Well-Architected](https://aws.amazon.com/architecture/well-architected/) · [Microsoft — Cloud Adoption Framework](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/) · [Google Cloud — Architecture Framework](https://cloud.google.com/architecture/framework)

---

### 12.16 Cloud frente a on-premises

On-premises significa operar la infraestructura en instalaciones propias; cloud, consumirla como servicio. Cambian el control, el coste, la escala y el modelo de responsabilidad.

**Claves:**
- On-premises: control total y mantenimiento total.
- Cloud: agilidad y escala con dependencia del proveedor.
- La seguridad no es mejor ni peor por sí misma: depende de la configuración.
- El cumplimiento y la residencia de datos influyen en la elección.
- Muchas organizaciones operan un modelo híbrido.

**En el curso:** [CyberSOC](../../cybersoc/02-arquitectura-soc/README.md).

**Fuentes:** [NIST SP 800-145](https://csrc.nist.gov/pubs/sp/800/145/final) · [NIST SP 800-146](https://csrc.nist.gov/pubs/sp/800/146/final) · [Microsoft — Hybrid cloud](https://learn.microsoft.com/en-us/azure/architecture/guide/technology-choices/technology-choices-overview)

---

### 12.17 NAS y SAN

NAS y SAN son soluciones de almacenamiento en red. NAS comparte archivos por protocolos como SMB o NFS; SAN ofrece bloques a nivel de red, normalmente por Fibre Channel o iSCSI.

**Claves:**
- NAS: sistema de archivos compartido, fácil de usar.
- SAN: rendimiento y bloques para bases de datos y virtualización.
- Ambos requieren autenticación y segmentación.
- Un NAS mal expuesto puede filtrar archivos por SMB.
- Las copias y la instantánea forman parte del diseño.

**En el curso:** almacenamiento en [CyberSOC](../../cybersoc/02-arquitectura-soc/README.md).

**Fuentes:** [NIST SP 800-209](https://csrc.nist.gov/pubs/sp/800/209/final) · [Microsoft — Storage](https://learn.microsoft.com/en-us/windows-server/storage/storage-spaces/overview) · [Red Hat — NFS](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/managing_file_systems/)

---

### 12.18 Box

Box es un servicio de almacenamiento y colaboración en la nube orientado a empresas, con controles de compartición y cumplimiento.

**Claves:**
- Enlaces públicos y permisos son el riesgo principal.
- Admite clasificación, retención y DLP.
- La integración con identidad corporativa es habitual.
- La auditoría registra accesos y cambios.
- Los datos se cifran en tránsito y en reposo.

**En el curso:** gobierno de datos en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Box — Trust](https://www.box.com/trust) · [Box — Security](https://support.box.com/hc/en-us) · [CISA — Cloud security](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 12.19 Dropbox

Dropbox es un servicio de sincronización y almacenamiento en la nube, popular en equipos pequeños y usuarios individuales.

**Claves:**
- La sincronización propaga borrados y cifrado por ransomware.
- Los enlaces compartidos pueden quedar públicos.
- La verificación en dos pasos es imprescindible.
- Las versiones anteriores ayudan a recuperar archivos.
- En empresa conviene gobernar cuentas y compartidos.

**En el curso:** riesgos de sombra TI en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Dropbox — Security](https://www.dropbox.com/security) · [Dropbox — Trust](https://help.dropbox.com/) · [CISA — Cloud security](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 12.20 OneDrive

OneDrive es el almacenamiento personal y corporativo de Microsoft, integrado en Windows y Microsoft 365.

**Claves:**
- La cuenta corporativa se integra con Entra ID.
- Los enlaces de uso compartido tienen permisos por defecto.
- La copia de seguridad de carpetas protege ante pérdida del equipo.
- La retención y la exhibición legal se configuran en el tenant.
- El cifrado y las claves las gestiona Microsoft o el cliente.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Microsoft — OneDrive](https://learn.microsoft.com/en-us/onedrive/) · [Microsoft — OneDrive security](https://learn.microsoft.com/en-us/sharepoint/plan-for-sharepoint-onedrive) · [Microsoft — Data encryption](https://learn.microsoft.com/en-us/purview/encryption)

---

### 12.21 Google Drive

Google Drive es el almacenamiento de Google, integrado en Google Workspace. Permite compartir archivos y carpetas con permisos granulares.

**Claves:**
- La compartición pública es el error más frecuente.
- Los permisos heredan de carpetas y unidades compartidas.
- La actividad se audita en el informe de administración.
- La DLP de Workspace puede bloquear comparticiones.
- El cifrado lo gestiona Google, con opciones de clave propia.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Google Workspace — Drive](https://support.google.com/drive/) · [Google Workspace — Security](https://workspace.google.com/security/) · [Google — Transparency](https://transparencyreport.google.com/)

---

### 12.22 iCloud

iCloud es el servicio de Apple para sincronizar archivos, fotos, copias de seguridad y datos de aplicaciones entre dispositivos.

**Claves:**
- La cuenta Apple ID es el punto único de fallo.
- La verificación en dos pasos es imprescindible.
- La copia de seguridad incluye datos sensibles.
- El cifrado avanzado protege extremo a extremo.
- La recuperación de cuenta exige planificarla.

**En el curso:** dispositivos y datos en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Apple — iCloud security](https://support.apple.com/guide/security/icloud-security-overview-sec1b8d2d2b3/web) · [Apple — Advanced Data Protection](https://support.apple.com/en-us/108756) · [Apple — Platform Security](https://support.apple.com/guide/security/welcome/web)

---

### 12.23 Microsoft Office

Microsoft Office es la suite de productividad de Microsoft: Word, Excel, PowerPoint, Outlook y otros. En la empresa suele distribuirse como Microsoft 365.

**Claves:**
- Las macros son un vector clásico de malware.
- Los documentos pueden incluir enlaces y objetos incrustados.
- La protección de archivos se gestiona con directivas.
- La nube añade compartición y versionado.
- Mantener actualizada la suite cierra vulnerabilidades conocidas.

**En el curso:** macros y documentos en [Análisis de malware](../../malware-analysis/README.md).

**Fuentes:** [Microsoft — Microsoft 365](https://learn.microsoft.com/en-us/microsoft-365/) · [Microsoft — Macros](https://learn.microsoft.com/en-us/deployoffice/security/internet-macros-blocked) · [CISA — Phishing](https://www.cisa.gov/topics/cybersecurity-best-practices)

---

### 12.24 Google Workspace

Google Workspace agrupa Gmail, Drive, Docs, Meet y Calendar en la nube. La administración se hace desde una consola central.

**Claves:**
- La identidad se gestiona con cuentas y grupos.
- La DLP y la seguridad de Gmail se configuran por políticas.
- La auditoría registra accesos y cambios.
- El uso compartido externo debe restringirse.
- La autenticación fuerte protege el acceso.

**En el curso:** [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Google Workspace — Admin](https://support.google.com/a/) · [Google Workspace — Security](https://workspace.google.com/security/) · [Google — Zero Trust](https://cloud.google.com/beyondcorp)

---

### 12.25 Suites de productividad

Las suites de productividad reúnen procesador de texto, hoja de cálculo, presentaciones y correo. Las más usadas son Microsoft 365, Google Workspace y LibreOffice.

**Claves:**
- En cloud, la colaboración y el cifrado dependen del proveedor.
- Las macros y los formatos heredados amplían el riesgo.
- LibreOffice es una alternativa local sin coste.
- La conversión de formatos puede alterar contenido.
- La política de uso debe cubrir compartición y retención.

**En el curso:** cultura de herramientas en [CyberSOC](../../cybersoc/README.md).

**Fuentes:** [Microsoft 365](https://www.microsoft.com/en-us/microsoft-365) · [Google Workspace](https://workspace.google.com/) · [LibreOffice](https://www.libreoffice.org/)

---

[Requisitos previos](../README.md) · [Siguiente: Herramientas de análisis](../13-herramientas-de-analisis/README.md)
