# Explicacion del trabajo realizado

## Objetivo

Se creo una pagina HTML con Bootstrap 4 y un formulario que integra CKEditor en el campo de mensaje.

## Archivo creado

- pagina.html

## Tecnologias usadas

- Bootstrap 4.6 (CDN)
- jQuery 3.5.1 slim (CDN)
- Bootstrap Bundle JS 4.6 (CDN)
- CKEditor 4.22.1 standard (CDN)

## Estructura de la pagina

La pagina contiene:

- Un contenedor centrado con una tarjeta visual (card) para el formulario.
- Un formulario con los campos:
  - Nombre
  - Correo electronico
  - Asunto
  - Mensaje (textarea convertido en editor enriquecido con CKEditor)
- Un boton de envio.

## Estilos aplicados

Se agregaron estilos CSS simples para:

- Fondo gris claro en la pagina.
- Tarjeta con sombra, borde redondeado y espaciado superior/inferior.
- Ajuste de ancho para CKEditor al 100%.

## Funcionamiento de CKEditor

Se inicializa con la instruccion:

- CKEDITOR.replace('mensaje');

Esto reemplaza el textarea del campo mensaje por un editor visual con formato.

## Comportamiento del formulario

Se agrego un manejador de envio en JavaScript que:

- Evita el envio real (event.preventDefault()).
- Muestra un mensaje de confirmacion con alert('Formulario enviado.').

## Ajuste tecnico realizado

Se retiraron atributos de integridad (integrity) en los CDN para evitar posibles bloqueos si la huella no coincide.

## Validacion del resultado

Se reviso el archivo final y no se detectaron errores en la comprobacion del editor.

## Resultado

La pagina esta lista para abrirse en navegador y probar el formulario con editor enriquecido.
