import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/app_state.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.state, required this.demoMode});
  final AppState state;
  final bool demoMode;
  @override State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final user = TextEditingController(text: 'demo@hit.local');
  final pass = TextEditingController(text: 'demo123');
  String role = 'Recepción';
  bool loading = false;

  Future<void> enter() async {
    setState(() => loading = true);
    if (!widget.demoMode) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: user.text.trim(), password: pass.text);
      } catch (e) {
        if (mounted) {
          setState(() => loading = false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No fue posible iniciar sesión: $e')));
        }
        return;
      }
    }
    await widget.state.load();
    if (!mounted) return;
    setState(() => loading = false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen(state: widget.state, role: role, demoMode: widget.demoMode)));
  }

  @override Widget build(BuildContext context) => Scaffold(
    body: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 460),
      child: Card(child: Padding(padding: const EdgeInsets.all(28), child: Column(children: [
        const Icon(Icons.hotel, size: 72),
        const SizedBox(height: 12),
        Text('Hotel Incident Tracker', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const Text('HIT · Gestión de incidencias'),
        const SizedBox(height: 28),
        TextField(controller: user, decoration: const InputDecoration(labelText: 'Usuario', prefixIcon: Icon(Icons.person), border: OutlineInputBorder())),
        const SizedBox(height: 14),
        TextField(controller: pass, obscureText: true, decoration: const InputDecoration(labelText: 'Contraseña', prefixIcon: Icon(Icons.lock), border: OutlineInputBorder())),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(value: role, decoration: const InputDecoration(labelText: 'Rol', border: OutlineInputBorder()), items: ['Recepción','Ama de Llaves','Limpieza','Mantenimiento','Supervisor','Gerencia'].map((r) => DropdownMenuItem(value:r, child:Text(r))).toList(), onChanged: (v) => setState(() => role=v!)),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: loading ? null : enter, icon: const Icon(Icons.login), label: Text(loading ? 'Ingresando...' : 'Iniciar sesión'))),
        if (widget.demoMode) ...[
          const SizedBox(height: 12),
          const Text('Modo demostración activo', style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('Permite probar el CRUD sin configurar Firebase.'),
        ]
      ]))),
    ))),
  );
}