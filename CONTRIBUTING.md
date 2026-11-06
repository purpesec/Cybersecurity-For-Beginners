# Contribuir

Las contribuciones deben mantener el contenido reproducible, neutral y seguro para un entorno educativo.

## Flujo de trabajo

1. Se crea una rama con un nombre descriptivo, por ejemplo `contenido/enumeracion-smb`.
2. Se realiza un cambio acotado y se comprueban todos los enlaces relativos.
3. Se abre un pull request que explique el objetivo, el entorno probado y la validación realizada.

## Convenciones de estructura

- El repositorio se organiza en las cuatro áreas de aprendizaje del blog (`fundamentos/`, `red-team-operations/`, `blue-team-operations/` y `analisis-de-malware/`) y en las secciones `writeups/` y `labs/`.
- Cada área contiene un `README.md` con una tabla de dos columnas: Tema y Labs.
- Los laboratorios viven en `labs/<nombre-del-lab>/` dentro del área correspondiente. Cada laboratorio incluye un `README.md` con las instrucciones y sus archivos de práctica.
- La columna Tema enlaza al post del blog. La columna Labs enlaza a la carpeta del laboratorio en GitHub mediante una ruta relativa; si no existe laboratorio para ese tema, muestra `-`.
- No se crean carpetas de rutas, cursos ni sesiones.
- Los nombres de carpetas se escriben en minúsculas y con guiones.

## Contenido de un tema

Cada fila incluye el título numerado del post enlazado con su URL pública y, en la columna Labs, el enlace al laboratorio de GitHub o `-`. No se enlaza un laboratorio hasta que sus instrucciones y archivos estén disponibles. El orden de los temas sigue una progresión de aprendizaje, de lo básico a lo específico. La tabla de writeups conserva sus columnas de máquina, plataforma, sistema, dificultad y resolución.

## Estilo

- El idioma principal es español.
- Los nombres de productos, comandos y términos técnicos pueden mantenerse en inglés.
- Se usa un solo encabezado H1 por documento.
- Se evitan las referencias a academias o instituciones concretas.

## Comprobación de índices

`.github/scripts/check-index.js` compara los índices con los posts publicados del blog:

```sh
node .github/scripts/check-index.js
```

Por defecto lee el índice público del blog
(<https://purpesec.github.io/blog/assets/js/data/search.json>), así que no
necesita credenciales. Para trabajar sin conexión o con borradores todavía sin
publicar, se le pasa el directorio local de posts:

```sh
node .github/scripts/check-index.js ../blog/_posts
```

Avisa de los temas publicados que no aparecen en el catálogo raíz o en su área,
de las categorías no reconocidas y de los enlaces a posts que ya no existen. El
workflow `.github/workflows/check-index.yml` lo ejecuta los lunes, al cambiar un
README o manualmente.

## Seguridad

- No se incluye malware real, credenciales válidas, datos personales ni secretos.
- Las muestras deben ser simulaciones educativas claramente identificadas.
- Todo código vulnerable incluye un aviso de uso exclusivo en laboratorio.
- No se reemplaza una vulnerabilidad intencional por código seguro sin revisar antes el objetivo didáctico.
