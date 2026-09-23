# Explicacion completa del trabajo realizado

## Objetivo principal

Se creo una pagina HTML con Bootstrap 4 y un formulario que integra CKEditor en el campo de mensaje.

## Archivos del trabajo

- pagina.html
- EXPLICACION.md

## Tecnologias usadas

- Bootstrap 4.6 (CDN)
- jQuery 3.5.1 slim (CDN)
- Bootstrap Bundle JS 4.6 (CDN)
- CKEditor 4.22.1 standard (CDN)

## Estructura de la pagina

- Contenedor Bootstrap centrado.
- Tarjeta visual (card) para el formulario.
- Campos del formulario: nombre, correo electronico, asunto y mensaje.
- Campo mensaje como textarea transformado por CKEditor.
- Boton de envio normal.
- Boton adicional para ir a una URL enviando el contenido del editor por query string.

## Cambios de diseno y tamano en CKEditor

- Se aumento el ancho disponible del formulario cambiando la columna a col-lg-10.
- Se aumento la altura del editor con configuracion height en CKEditor.
- Se definio altura minima del area editable con CSS (cke_contents).

## Zoom del editor al 125% (solo CSS)

Se aplico zoom visual al contenedor de CKEditor con:

- zoom: 1.25
- ajuste de ancho compensado con width: calc(100% / 1.25)

Tambien se agrego fallback para navegadores sin soporte de zoom:

- transform: scale(1.25)
- transform-origin: top left
- padding-bottom extra en el wrapper para evitar solapes visuales

## Barra de herramientas reducida

Se dejo CKEditor solo con:

- Bold (negrita)
- Link (enlace)

## Quitar texto del pie del editor (body p)

Para ocultar la ruta de elementos del pie (element path), se uso:

- removePlugins: "elementspath"

Y para quitar la esquina de redimensionado:

- resize_enabled: false

## Que es CKEDITOR y donde se define

- CKEDITOR es el objeto global de CKEditor 4.
- No se define manualmente en el codigo local.
- Lo crea el script cargado desde CDN: https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js
- Despues de cargar ese script, se puede usar CKEDITOR.replace("mensaje", {...}).

## Envio del contenido del editor en la URL

Se agrego un boton que:

- Lee el contenido con CKEDITOR.instances.mensaje.getData().
- Codifica el parametro con encodeURIComponent(...).
- Redirige a una URL base con ?mensaje=...

Ejemplo de construccion:

- destino = urlBase + "?mensaje=" + encodeURIComponent(mensaje)

## Codificacion del parametro enviado

El parametro va en percent-encoding sobre UTF-8.

- encodeURIComponent genera secuencias %XX para caracteres no ASCII.
- Espacios: %20
- Acentos y eñe: codificados en UTF-8 y luego escapados en URL.

## Recuperar el parametro en un Servlet Java (GET, UTF-8)

Forma normal:

- String mensaje = request.getParameter("mensaje");

Para que llegue bien en GET, el servidor debe decodificar URI en UTF-8.
En Tomcat, en server.xml:

- URIEncoding="UTF-8"
- useBodyEncodingForURI="true"

Nota:

- request.setCharacterEncoding("UTF-8") aplica sobre todo a cuerpo de peticion (POST), no siempre arregla GET.

Workaround cuando llega mal (solo temporal):

- new String(raw.getBytes("ISO-8859-1"), "UTF-8")

## Diferencia entre getData() y textarea.value

No son equivalentes en todos los momentos.

- CKEDITOR.instances.mensaje.getData() obtiene el contenido real del editor (HTML del editor).
- document.getElementById("mensaje").value obtiene el valor actual del textarea original.

Si se quiere leer textarea.value sincronizado con CKEditor, antes hay que ejecutar:

- CKEDITOR.instances.mensaje.updateElement();

Y despues leer:

- document.getElementById("mensaje").value

## Comandos Git explicados durante el trabajo

Para ver URL de remotos:

- git remote -v
- git remote get-url origin

Resultado visto en este repositorio:

- origin -> https://github.com/aberbel/git.git (fetch/push)

## Ajustes tecnicos adicionales

- Se retiraron atributos integrity de algunos CDN para evitar posibles bloqueos por hash no coincidente.
- Se valido el archivo HTML tras cambios y no aparecieron errores en la comprobacion del editor.

## Estado final

La pagina queda lista para:

- Editar mensaje enriquecido con CKEditor.
- Usar solo negrita y enlace en toolbar.
- Ocultar el pie de ruta de elementos del editor.
- Aplicar zoom visual del editor al 125%.
- Redirigir a una URL enviando el contenido del editor como parametro.
