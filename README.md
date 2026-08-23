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



# Hotel Incident Tracker (HIT)

Flutter mobile application for recording, viewing, updating, and deleting hotel operational incidents, based on A5_ALCE and the Project Integrator Stage 3 instructions.

## Requirements Covered
- Incident CRUD operations.
- Firebase Firestore as the cloud database.
- Firebase Authentication prepared for user login.
- Firebase Storage prepared for photo uploads.
- Firebase Cloud Messaging prepared for notifications.
- Roles: Front Desk, Housekeeping, Cleaning, Maintenance, Supervisor, and Management.
- Dashboard with pending, in progress, completed, and critical incidents.
- History with filters.
- Incident details, comments, status changes, and closure.
- Local demo mode to run and test the interface before connecting Firebase.

## Firebase Configuration
1. Install Flutter and run flutter pub get.
2. Install the FlutterFire CLI and run flutterfire configure from this directory.
3. This will generate lib/firebase_options.dart.
4. In Firebase, enable Authentication (Email/Password), Firestore, and Storage.
5. Review and apply the rules in firebase/firestore.rules and firebase/storage.rules.
6. Run flutter run.

The app starts in demo mode if Firebase is not configured correctly. Demo mode allows you to validate the CRUD functionality using in-memory data; once Firebase is connected, operations are performed in Firestore.

## Demo Credentials
- Username: demo@hit.local
- Password: demo123

In demo mode, the credentials are simulated and are not sent to any external service.
