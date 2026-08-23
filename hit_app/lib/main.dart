import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'services/incident_service.dart';
import 'services/app_state.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var demoMode = false;
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (_) {
    demoMode = true;
  }
  runApp(HitApp(demoMode: demoMode));
}

class HitApp extends StatelessWidget {
  const HitApp({super.key, required this.demoMode});
  final bool demoMode;

  @override
  Widget build(BuildContext context) {
    final state = AppState(IncidentService(demoMode: demoMode));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HIT - Hotel Incident Tracker',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: LoginScreen(state: state, demoMode: demoMode),
    );
  }
}