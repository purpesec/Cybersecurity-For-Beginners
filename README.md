# Red2Blue Learning

Catálogo de temas de ciberseguridad en español: cada entrada enlaza al artículo
publicado en el blog, ordenado por área de aprendizaje.

**[Blog](https://purpesec.github.io/blog/)** ·
**[Cómo contribuir](CONTRIBUTING.md)** ·
**[Seguridad](SECURITY.md)**

## About

Este repositorio es el índice del blog. No guarda el material didáctico, solo la
lista de temas publicados con una descripción breve y su enlace. Sirve para ver de un
vistazo qué hay disponible, en qué orden conviene estudiarlo y si algún artículo del
blog se ha quedado sin catalogar.

El catálogo separa cuatro **áreas de aprendizaje** —Fundamentos, Red Team
Operations, Blue Team Operations y Análisis de malware— de cinco **categorías
transversales**: Writeups, Certificaciones, Laboratorios, Reseñas y Guías. El
material práctico vive en sus repositorios propios; aquí solo hay un `README.md` por
carpeta.

## Tabla de contenido

- [Cómo está organizado](#cómo-está-organizado)
- [Ruta de aprendizaje](#ruta-de-aprendizaje)
- [Índice de temas](#índice-de-temas)
- [Añadir un tema](#añadir-un-tema)
- [Verificación del catálogo](#verificación-del-catálogo)
- [Uso responsable](#uso-responsable)
- [Enlaces](#enlaces)

## Cómo está organizado

```text
fundamentos/            Área de aprendizaje
red-team-operations/    Área de aprendizaje
blue-team-operations/   Área de aprendizaje
analisis-de-malware/    Área de aprendizaje
writeups/               Categoría transversal
certificaciones/        Categoría transversal
laboratorios/           Categoría transversal
resenas/                Categoría transversal
guias/                  Categoría transversal
scripts/check-index.js  Comprobación con los posts del blog
```

Cada carpeta contiene un único `README.md` con una tabla de dos columnas: el tema,
enlazado a su post, y un resumen del contenido. Los nombres de carpeta van en
minúsculas y con guiones. No se crean carpetas de rutas, cursos ni sesiones.

## Ruta de aprendizaje

1. **Fundamentos**: redes y Linux. Es la base que se da por conocida en el resto del
   catálogo.
2. **Área según el objetivo**: Blue Team Operations para monitorización y detección,
   Red Team Operations para reconocimiento y escalada en entornos autorizados, o
   Análisis de malware para análisis estático y dinámico.
3. **Refuerzo**: Writeups para ver las técnicas aplicadas de principio a fin,
   Laboratorios para practicar en entornos controlados y Guías para procedimientos que
   no encajan en un área concreta.

Dentro de cada índice los temas se ordenan de lo básico a lo específico.

## Índice de temas

### Áreas de aprendizaje

| Área | Temas | Enfoque |
| --- | ---: | --- |
| [Fundamentos](./fundamentos/) | 2 | Modelos de red, direccionamiento, Linux y contenedores |
| [Red Team Operations](./red-team-operations/) | 1 | Enumeración y escalada de privilegios en entornos autorizados |
| [Blue Team Operations](./blue-team-operations/) | 1 | Monitorización, detección y SIEM |
| [Análisis de malware](./analisis-de-malware/) | 3 | Laboratorio aislado, análisis estático y dinámico, Windows internals |

### Categorías transversales

| Categoría | Temas | Contenido |
| --- | ---: | --- |
| [Writeups](./writeups/) | 1 | Resoluciones paso a paso de máquinas y retos |
| [Certificaciones](./certificaciones/) | 0 | Notas, rutas de estudio y experiencias |
| [Laboratorios](./laboratorios/) | 0 | Entornos y ejercicios prácticos |
| [Reseñas](./resenas/) | 0 | Herramientas, plataformas, cursos y libros |
| [Guías](./guias/) | 0 | Procedimientos fuera de un área de aprendizaje |

Las filas nuevas se añaden solo cuando el artículo ya está publicado en el blog.

## Añadir un tema

1. Publica el artículo en el blog con su categoría correspondiente.
2. Añade una fila a la tabla del área o categoría, con el título enlazado a la URL
   pública del post y un resumen de una línea.
3. Ejecuta la comprobación del catálogo en local.
4. Abre un pull request que indique el objetivo y la validación realizada.

Las convenciones completas están en [CONTRIBUTING.md](CONTRIBUTING.md).

## Verificación del catálogo

`scripts/check-index.js` compara los índices con los posts del blog:

```sh
node scripts/check-index.js ../blog/_posts
```

Avisa de tres cosas: temas publicados que no aparecen en su área, posts con una
categoría no reconocida y enlaces a posts que ya no existen.

El workflow [`.github/workflows/check-index.yml`](.github/workflows/check-index.yml)
lo ejecuta los lunes, al cambiar un `README.md` o `scripts/`, de forma manual y al
recibir el evento `blog-published`. Como el blog es privado, necesita el secreto
`BLOG_REPO_TOKEN` con permiso de lectura sobre `purpesec/blog`.

## Uso responsable

- El contenido es educativo y se publica solo sobre sistemas propios o con
  autorización explícita.
- No se incluyen muestras de malware real, credenciales válidas ni datos personales.
  Las muestras son simulaciones identificadas como tales.
- Todo código deliberadamente vulnerable lleva un aviso de uso exclusivo en
  laboratorio.

## Enlaces

| Recurso | Enlace |
| --- | --- |
| Blog | <https://purpesec.github.io/blog/> |
| Contribuir | [CONTRIBUTING.md](CONTRIBUTING.md) |
| Política de seguridad | [SECURITY.md](SECURITY.md) |
| Comprobación de índices | [`.github/workflows/check-index.yml`](.github/workflows/check-index.yml) |
