# shhfood


widgets used:
Widgets de Diseño y Estructura
Scaffold: El widget base para implementar la estructura visual de Material Design. Proporciona la estructura para la página, incluyendo un body.


Container: Un widget flexible para agrupar otros widgets. Lo estás utilizando para aplicar un degradado de fondo (LinearGradient) a toda la pantalla.


Center: Un widget que centra a su hijo dentro de sí mismo.


SingleChildScrollView: Permite que el contenido de la página sea desplazable, crucial para asegurar que todos los campos sean visibles incluso en pantallas pequeñas o cuando el teclado está activo.


Column: Un widget que muestra a sus hijos en un arreglo vertical. Estás utilizando una Column para organizar todos los campos de entrada y botones.


SizedBox: Un widget para crear espacios vacíos con dimensiones específicas, usado para añadir separación vertical entre los elementos.


Widgets de Entrada de Texto
TextFormField (implícitamente a través de TextField con InputDecoration): Aunque la función _buildTextField crea un TextField, la combinación con InputDecoration le da las características de un campo de formulario. Se usa para capturar:
Nombre del Restaurante
Dirección
Teléfono
Descripción del Restaurante
Horario de Servicio
Widgets de Interacción y Botones



ElevatedButton: Un botón con sombra para indicar que tiene una acción principal. Lo estás utilizando para la acción "Registrar Restaurante".


TextButton: Un botón de texto que se usa para acciones secundarias o navegaciones. Lo empleas para "¿Ya tienes una cuenta? Inicia sesión".


GestureDetector: Un widget no visual que detecta gestos. Lo usas en la sección de selección de imagen para hacer que el Container sea tappable (clicable), permitiendo al usuario iniciar la selección de una foto.


Widgets de Visualización de Contenido
Text: Un widget para mostrar texto. Lo usas para el título "Registra Tu Restaurante", las etiquetas de los campos y el texto de los botones.


Icon: Un widget para mostrar íconos visuales (por ejemplo, Icons.restaurant_menu, Icons.location_on_outlined, Icons.add_a_photo_outlined).


Image.file: Este widget se utiliza para mostrar la imagen seleccionada del dispositivo, una vez que el usuario ha elegido una foto para el restaurante.


ClipRRect: Un widget que recorta a su hijo usando un rectángulo redondeado. Lo empleas para redondear las esquinas de la imagen seleccionada.


CircularProgressIndicator: Un widget que muestra un indicador de progreso circular. Lo usarías para la carga de diálogo cuando se está realizando una operación asíncrona como el login o registro (mostrado en el AuthController).

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
