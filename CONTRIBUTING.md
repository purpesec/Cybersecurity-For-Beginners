# Contribuir

Las contribuciones deben mantener el contenido reproducible, neutral y seguro para un entorno educativo.

## Flujo de trabajo

1. Crea una rama con un nombre descriptivo, por ejemplo `contenido/enumeracion-smb`.
2. Realiza un cambio acotado y comprueba todos los enlaces relativos.
3. Abre un pull request que explique el objetivo, el entorno probado y la validación realizada.

## Convenciones de estructura

- El repositorio se organiza en cuatro áreas de primer nivel, las mismas del blog: `fundamentos/`, `red-team-operations/`, `blue-team-operations/` y `analisis-de-malware/`.
- Cada área contiene una o más rutas; cada ruta usa su propia carpeta con un `README.md` como índice.
- Cada sesión utiliza `<ruta>/NN-tema/README.md`.
- Cada laboratorio utiliza `<ruta>/NN-tema/lab/README.md`.
- Los archivos de apoyo permanecen dentro del `lab/` que los necesita.
- Los nombres de carpetas se escriben en minúsculas y con guiones, por ejemplo `02-fundamentos-sql`.
- Se conserva la numeración real de las sesiones aunque todavía existan huecos.

## Contenido de una sesión

El `README.md` de una sesión debe incluir: objetivo, duración estimada, nivel, prerrequisitos, resultados de aprendizaje, conceptos, laboratorio, evidencias y criterios de finalización.

El `README.md` de un laboratorio debe incluir: alcance autorizado, requisitos, topología cuando aplique, pasos reproducibles, resultados esperados, validación final, entrega y navegación de retorno.

## Estilo

- El idioma principal es español.
- Los nombres de productos, comandos y términos técnicos pueden mantenerse en inglés.
- Usa un solo encabezado H1 por documento.
- No dupliques código que ya exista como archivo de apoyo; enlázalo desde el laboratorio.
- Incluye versiones cuando un procedimiento dependa de ellas.
- Evita referencias a academias o instituciones concretas.

## Seguridad

- No incluyas malware real, credenciales válidas, datos personales ni secretos.
- Las muestras deben ser simulaciones educativas claramente identificadas.
- Todo código vulnerable debe incluir un aviso de uso exclusivo en laboratorio.
- No reemplaces una vulnerabilidad intencional por código seguro sin revisar primero el objetivo didáctico.
