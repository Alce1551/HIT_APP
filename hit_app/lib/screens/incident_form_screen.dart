import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../models/incident.dart';
import '../services/app_state.dart';

class IncidentFormScreen extends StatefulWidget {
  const IncidentFormScreen({super.key, required this.state, required this.role});
  final AppState state; final String role;
  @override State<IncidentFormScreen> createState()=>_IncidentFormScreenState();
}
class _IncidentFormScreenState extends State<IncidentFormScreen>{
  final desc=TextEditingController();
  String dept='Recepción', location='Habitación 101', type='Mantenimiento', priority='Media', assignee='Sin asignar';
  XFile? photo;
  bool saving=false;
  final picker=ImagePicker();
  Future<void> save() async {
    if(desc.text.trim().isEmpty){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Agrega una descripción.')));return;}
    setState(()=>saving=true);
    final id=const Uuid().v4();
    final incident=Incident(id:id,createdAt:DateTime.now(),reporter:widget.role,department:dept,location:location,type:type,priority:priority,description:desc.text.trim(),assignee:assignee,status:'Pendiente');
    await widget.state.create(incident);
    if(photo!=null){await widget.state.service.uploadEvidence(id,photo!);}
    if(mounted)Navigator.pop(context);
  }
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Nueva incidencia')),body:Form(child:ListView(padding:const EdgeInsets.all(16),children:[
    DropdownButtonFormField(value:location,decoration:const InputDecoration(labelText:'Ubicación',border:OutlineInputBorder()),items:['Habitación 101','Habitación 205','Lobby','Restaurante','Alberca','Área de servicio'].map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(v)=>setState(()=>location=v!)),
    const SizedBox(height:12),
    DropdownButtonFormField(value:type,decoration:const InputDecoration(labelText:'Tipo de incidencia',border:OutlineInputBorder()),items:['Mantenimiento','Limpieza','Habitación','Seguridad','Solicitud especial','Otro'].map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(v)=>setState(()=>type=v!)),
    const SizedBox(height:12),
    DropdownButtonFormField(value:priority,decoration:const InputDecoration(labelText:'Prioridad',border:OutlineInputBorder()),items:['Baja','Media','Alta','Crítica'].map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(v)=>setState(()=>priority=v!)),
    const SizedBox(height:12),
    DropdownButtonFormField(value:dept,decoration:const InputDecoration(labelText:'Departamento',border:OutlineInputBorder()),items:['Recepción','Ama de Llaves','Limpieza','Mantenimiento'].map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(v)=>setState(()=>dept=v!)),
    const SizedBox(height:12),
    DropdownButtonFormField(value:assignee,decoration:const InputDecoration(labelText:'Responsable',border:OutlineInputBorder()),items:['Sin asignar','Carlos - Mantenimiento','Ana - Limpieza','Luis - Supervisión'].map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(v)=>setState(()=>assignee=v!)),
    const SizedBox(height:12),
    TextField(controller:desc,maxLines:5,decoration:const InputDecoration(labelText:'Descripción',alignLabelWithHint:true,border:OutlineInputBorder())),
    const SizedBox(height:12),
    OutlinedButton.icon(onPressed:()async{final p=await picker.pickImage(source:ImageSource.camera);if(p!=null)setState(()=>photo=p);},icon:const Icon(Icons.camera_alt_outlined),label:Text(photo==null?'Agregar evidencia fotográfica':'Foto seleccionada')),
    const SizedBox(height:20),
    FilledButton.icon(onPressed:saving?null:save,icon:const Icon(Icons.save),label:Text(saving?'Guardando...':'Registrar incidencia'))
  ])));
}