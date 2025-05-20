### Capitulo 1: Introduccion a Phoenix
- Historia y explicacion de las carateristicas que hacen a Erlang, BEAM, Elixir y Phoenix unas grandes herramientas para crear aplicaciones flexibles, escalables, rapidas y tolerante a fallos

### Capitulo 2: La disposición del terreno
- Instalacion de Phoenix, que está construido utilizando Erlang y OTP para la capa de servicio, Elixir para el lenguaje y Node.js para empaquetar activos estáticos.
- Usamos la combinación de herramientas de compilación Elixir para crear un nuevo proyecto e iniciar el servidor.
- Las aplicaciones web de Phoenix son pipelines de conexiones
- Flujo tradicional de aplicaciones (endpoint -> router -> pipeline -> controller)
- El router distribuye requests
- Los controladores llaman a servicios y configuran la informacion intermedia para las vistas

### Capitulo 3: Controladores
- Crear primer contexto que encapsula toda la lógica relacionada con la gestión de cuentas.
- Crear acciones que sirven como punto principal de control para cada solicitud.
- Crear vistas que existen para representar plantillas.
- Crear plantillas que generan HTML para los usuarios.
- Utilizar helpers, que son funciones de Phoenix simples utilizadas en plantillas.

### Capitulo 4: Ecto y changesets
- Configurar base de datos conectada a OTP, para que Elixir pudiera hacer lo correcto en caso de que el repositorio falle.
- Crear un esquema completo con información sobre cada campo necesario.
- Crear una migración para especificar las tablas de base de datos, automatizar la creacion y eliminacion de cualquier cambio en la base de datos.
- Crear changeset para que Ecto pudiera rastrear y administrar de manera eficiente cada cambio solicitado en la aplicación.


### Capitulo 5: Autenticacion de usuario
- Uso del contexto de Cuentas existente para buscar usuarios en la sesión.
- Añadir la dependencia pbkdf2_elixir al proyecto para el hash de contraseñas.
- Crear una capa propia de autenticación.
- Crear changeset asociados para gestionar la validación de contraseñas.
- Implementacion de un módulo plug que carga el usuario desde la sesión y la integracion del pipeline del navegador.
- Implementar una función plug y su uso junto con algunas acciones específicas del pipeline del controlador.

### Capitulo 6: Generadores y relaciones
- Uso de contextos en todo momento para crear una capa de API fácil de mantener para la aplicación.
- Convertir un plug privado en una función pública para ser compartido con controladores y enrutadores.
- Cómo migrar y revertir cambios en la base de datos.
- Definicion de relaciones entre esquemas de Usuario y Vídeo y uso de funciones de Ecto para construir y recuperar datos asociados.
- Principales generadores que Phoenix proporciona para dar soporte a aplicaciones.

### Capitulo 7: Consultas y restricciones de Ecto
- Cómo generar datos y cómo usar la opción :on_conflict para gestionar conflictos de datos
- Utilizar la API de consulta de Ecto, que es independiente de la API del repositorio, para realizar algunas consultas básicas.
- Uso de fragmentos para pasar comandos SQL a través de la API de consulta sin cambios.
- Escribir validaciones de estilo de restricción para índices únicos y violaciones de llaves externas.

### Capitulo 8: Probando MVC
- Crear pruebas unitarias en contextos para probar una capa singular de la aplicacion aislada
- El uso de la palabra reservada "decribe" para permitir configuraciones que se van a aplicar a varias pruebas al mismo tiempo
- Crear pruebas que se ejecutaran de manera concurrente
- Crear pruebas de integracion que permitan probar las capas de la aplicacion trabajando en conjunto
- Probar el pipeline de los plugs

### Capitulo 9: Viendo videos
- Webpack para soportar la recarga en tiempo de desarrollo y la minimización del código de producción.
- Generadores para crear una migración Ecto.
- Changesets para crear slugs.
- Protocolos para construir URL sin problemas a partir de esos nuevos slugs.

### Capitulo 10: Usando canales
- Conectarse a un canal del lado del servidor a través de un cliente ES6.
- Crear un canal del lado del servidor con soporte para sondeo largo y WebSocket.
- Construir una API simple para permitir a los usuarios unirse a un canal.
- Procesar mensajes entrantes de OTP con handle_info y canales con handle_in.
- Enviar mensajes de difusión con broadcast.
- Autenticar a los usuarios con Phoenix.Token.
- Persistir las anotaciones con Ecto y exponer esas nuevas características a través del contexto de multimedia.
- Utilizar Channel Presence para realizar un seguimiento de la lista de usuarios en un canal de video.

### Capitulo 11: Observador y Umbrellas
- Utilizar el Observer para comprender la importancia de las aplicaciones.
- Extraer rumbl y rumbl_web en su propio proyecto secundario.
- Identificar cambios de configuración, incluyendo dependencias, árboles de supervisión y configuración de la aplicación.