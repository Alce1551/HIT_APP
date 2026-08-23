# Hotel Incident Tracker (HIT)

Aplicación móvil Flutter para registrar, consultar, actualizar y eliminar incidencias operativas de un hotel, basada en A5_ALCE y en las instrucciones del Proyecto Integrador Etapa 3.

## Requisitos cubiertos
- CRUD de incidencias.
- Firebase Firestore como base de datos en la nube.
- Firebase Authentication preparado para inicio de sesión.
- Firebase Storage preparado para fotografías.
- Firebase Cloud Messaging preparado para notificaciones.
- Roles: Recepción, Ama de Llaves, Limpieza, Mantenimiento, Supervisor y Gerencia.
- Panel con pendientes, en proceso, finalizados y críticas.
- Historial con filtros.
- Detalle, comentarios, cambio de estado y cierre.
- Modo demo local para poder ejecutar y probar la interfaz antes de conectar Firebase.

## Configuración Firebase
1. Instala Flutter y ejecuta `flutter pub get`.
2. Instala FlutterFire CLI y ejecuta `flutterfire configure` desde este directorio.
3. Esto generará `lib/firebase_options.dart`.
4. En Firebase habilita Authentication (Email/Password), Firestore y Storage.
5. Revisa y aplica las reglas de `firebase/firestore.rules` y `firebase/storage.rules`.
6. Ejecuta `flutter run`.

La app inicia en modo demo si Firebase no está configurado correctamente. El modo demo permite validar el CRUD en memoria; al conectar Firebase, las operaciones se realizan en Firestore.

## Credenciales demo
- Usuario: demo@hit.local
- Contraseña: demo123

En modo demo las credenciales son simuladas y no se envían a ningún servicio.
