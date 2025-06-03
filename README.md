Requisitos previos
Disponer del Flutter SDK instalado en el sistema.

Contar con Visual Studio Code o cualquier otro editor compatible con Flutter (se recomienda Visual Studio Code para facilitar la gestión del proyecto).

Tener disponible un dispositivo Android/iOS físico o un emulador configurado para la ejecución.

Instrucciones de instalación y ejecución
1. Descargar y descomprimir el proyecto

Por favor, descargue el archivo ZIP del proyecto y descomprímalo en la carpeta que desee utilizar.

2. Abrir el proyecto en Visual Studio Code

Acceda a Visual Studio Code y seleccione la opción “Open Folder”. Navegue hasta la carpeta donde ha descomprimido el proyecto y ábrala.

3. Instalar dependencias

Abra el terminal integrado en Visual Studio Code y ejecute el siguiente comando:

flutter pub get

Este comando descargará todas las dependencias necesarias para el proyecto.

4. Configurar un dispositivo o emulador

Dispositivo físico:

Conecte su teléfono móvil mediante USB.

Active las opciones de desarrollador y la depuración por USB.

Autorice la conexión si fuera necesario.

Emulador:

Puede crear un emulador Android desde Android Studio o Visual Studio Code (es necesario tener instalado Android Studio y las imágenes del sistema correspondientes).

Seleccione el dispositivo virtual deseado en la barra inferior de VS Code o desde el menú de dispositivos.

5. Ejecutar la aplicación

En el terminal, ejecute:

flutter run

También puede pulsar F5 o utilizar el botón "Run" de Visual Studio Code para desplegar la aplicación en el dispositivo o emulador seleccionado.

Notas adicionales
La aplicación soporta internacionalización (español, inglés y valenciano). Puede cambiar el idioma desde la pantalla de autenticación.

Si se encuentra con problemas de permisos o ejecución en el emulador, asegúrese de haber instalado las herramientas de plataforma Android y haber aceptado las licencias del SDK de Flutter.

El proyecto utiliza Supabase como base de datos y la api está ejecutandose en un servidor Render. Por favor asegurese de tener conexión a internet en todo momento.