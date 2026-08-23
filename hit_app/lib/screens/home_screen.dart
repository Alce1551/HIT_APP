import 'package:flutter/material.dart';
import '../models/incident.dart';
import '../services/app_state.dart';
import '../widgets/incident_card.dart';
import 'incident_form_screen.dart';
import 'incident_detail_screen.dart';
import 'history_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.state, required this.role, required this.demoMode});
  final AppState state; final String role; final bool demoMode;
  @override State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override void initState() { super.initState(); widget.state.addListener(_refresh); }
  @override void dispose() { widget.state.removeListener(_refresh); super.dispose(); }
  void _refresh() => setState(() {});
  List<Incident> get incidents => widget.state.incidents;

  @override Widget build(BuildContext context) {
    if (index == 1) return HistoryScreen(state: widget.state, role: widget.role, onBack: () => setState(() => index=0));
    if (index == 2) return NotificationsScreen(onBack: () => setState(() => index=0));
    final pending = incidents.where((i)=>i.status=='Pendiente').length;
    final process = incidents.where((i)=>i.status=='En proceso').length;
    final done = incidents.where((i)=>i.status=='Finalizado').length;
    final critical = incidents.where((i)=>i.priority=='Crítica' && i.status!='Finalizado').length;
    return Scaffold(
      appBar: AppBar(title: const Text('HIT · Panel principal'), actions: [IconButton(onPressed:()=>setState(()=>index=2), icon:const Icon(Icons.notifications_none)), PopupMenuButton<String>(onSelected:(_){}, itemBuilder:(_)=>[PopupMenuItem(value:'role', child:Text('Rol: ${widget.role}')), const PopupMenuItem(value:'demo', child:Text('Salir'))])]),
      floatingActionButton: FloatingActionButton.extended(onPressed: () async { await Navigator.push(context, MaterialPageRoute(builder: (_) => IncidentFormScreen(state: widget.state, role: widget.role))); setState((){}); }, icon: const Icon(Icons.add), label: const Text('Nueva incidencia')),
      bottomNavigationBar: NavigationBar(selectedIndex: index, onDestinationSelected:(v)=>setState(()=>index=v), destinations: const [NavigationDestination(icon:Icon(Icons.dashboard_outlined), selectedIcon:Icon(Icons.dashboard), label:'Inicio'), NavigationDestination(icon:Icon(Icons.history), label:'Historial'), NavigationDestination(icon:Icon(Icons.notifications_outlined), label:'Avisos')]),
      body: RefreshIndicator(onRefresh: () async => widget.state.load(), child: ListView(padding: const EdgeInsets.all(16), children: [
        Text('Hola, ${widget.role}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        if(widget.demoMode) const Padding(padding:EdgeInsets.only(top:4), child:Text('Modo demo · los datos se guardan en memoria durante la ejecución.')),
        const SizedBox(height: 16),
        GridView.count(crossAxisCount:2, shrinkWrap:true, physics:const NeverScrollableScrollPhysics(), childAspectRatio:1.8, crossAxisSpacing:10, mainAxisSpacing:10, children:[_metric('Pendientes',pending,Icons.pending_outlined),_metric('En proceso',process,Icons.autorenew),_metric('Finalizados',done,Icons.check_circle_outline),_metric('Críticas',critical,Icons.priority_high)]),
        const SizedBox(height: 22), Text('Incidencias recientes', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight:FontWeight.bold)),
        const SizedBox(height: 8),
        if(incidents.isEmpty) const Card(child:Padding(padding:EdgeInsets.all(24), child:Center(child:Text('No hay incidencias. Crea la primera con el botón +.')))),
        ...incidents.take(12).map((i)=>IncidentCard(incident:i,onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>IncidentDetailScreen(state:widget.state,incident:i,role:widget.role)))))
      ])),
    );
  }
  Widget _metric(String title,int value,IconData icon)=>Card(child:Padding(padding:const EdgeInsets.all(12),child:Row(children:[Icon(icon,size:30),const SizedBox(width:10),Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('$value',style:const TextStyle(fontSize:24,fontWeight:FontWeight.bold)),Text(title)])])));
}