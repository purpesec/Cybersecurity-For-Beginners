# Contribuir

Las contribuciones deben mantener el contenido reproducible, neutral y seguro para un entorno educativo.

## Flujo de trabajo

1. Crea una rama con un nombre descriptivo, por ejemplo `contenido/enumeracion-smb`.
2. Realiza un cambio acotado y comprueba todos los enlaces relativos.
3. Abre un pull request que explique el objetivo, el entorno probado y la validación realizada.

## Convenciones de estructura

- El repositorio se organiza en las cuatro áreas de aprendizaje del blog (`fundamentos/`, `red-team-operations/`, `blue-team-operations/` y `analisis-de-malware/`) y en las categorías transversales `writeups/`, `certificaciones/`, `laboratorios/`, `resenas/` y `guias/`.
- Cada área o categoría contiene únicamente un `README.md` con la lista de temas.
- No se crean carpetas de rutas, cursos ni sesiones. El material práctico vive en su repositorio correspondiente.
- Cada tema es una fila de la tabla del área y enlaza directamente al post del blog.
- Los nombres de carpetas se escriben en minúsculas y con guiones.

## Contenido de un tema

Cada fila incluye el título del post enlazado con su URL pública y una descripción breve del contenido. El orden de los temas sigue una progresión de aprendizaje, de lo básico a lo específico.

## Estilo

- El idioma principal es español.
- Los nombres de productos, comandos y términos técnicos pueden mantenerse en inglés.
- Usa un solo encabezado H1 por documento.
- Evita referencias a academias o instituciones concretas.

## Comprobación de índices

`scripts/check-index.js` compara los índices con los posts del blog:

```sh
node scripts/check-index.js ../blog/_posts
```

Avisa de los temas publicados que no aparecen en su área, de las categorías no reconocidas y de los enlaces a posts que ya no existen. El workflow `.github/workflows/check-index.yml` lo ejecuta los lunes, al cambiar un README o manualmente. Como el blog es privado, necesita el secreto `BLOG_REPO_TOKEN` con permiso de lectura sobre `purpesec/blog`.

## Seguridad

- No incluyas malware real, credenciales válidas, datos personales ni secretos.
- Las muestras deben ser simulaciones educativas claramente identificadas.
- Todo código vulnerable debe incluir un aviso de uso exclusivo en laboratorio.
- No reemplaces una vulnerabilidad intencional por código seguro sin revisar primero el objetivo didáctico.
