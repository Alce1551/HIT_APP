import 'package:flutter/material.dart';
import '../models/incident.dart';
import '../services/app_state.dart';

class IncidentDetailScreen extends StatefulWidget {
  const IncidentDetailScreen({super.key,required this.state,required this.incident,required this.role});
  final AppState state; final Incident incident; final String role;
  @override State<IncidentDetailScreen> createState()=>_IncidentDetailScreenState();
}
class _IncidentDetailScreenState extends State<IncidentDetailScreen>{
  late Incident current; final comment=TextEditingController();
  @override void initState(){super.initState();current=widget.incident;}
  Future<void> updateStatus(String status) async { final next=current.copyWith(status:status,closedAt:status=='Finalizado'?DateTime.now():current.closedAt); await widget.state.update(next); setState(()=>current=next); }
  Future<void> addComment() async {if(comment.text.trim().isEmpty)return;final next=current.copyWith(comments:[...current.comments,'${widget.role}: ${comment.text.trim()}']);await widget.state.update(next);setState(()=>current=next);comment.clear();}
  Future<void> delete() async {await widget.state.remove(current.id);if(mounted)Navigator.pop(context);}
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:Text('Incidencia #${current.id.substring(0,6).toUpperCase()}'),actions:[IconButton(onPressed:delete,icon:const Icon(Icons.delete_outline))]),body:ListView(padding:const EdgeInsets.all(16),children:[
    Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(current.description,style:Theme.of(context).textTheme.titleLarge),const SizedBox(height:12),Wrap(spacing:8,runSpacing:8,children:[Chip(label:Text(current.status)),Chip(label:Text(current.priority)),Chip(label:Text(current.location))]),const Divider(height:28),_row('Tipo',current.type),_row('Departamento',current.department),_row('Reportó',current.reporter),_row('Responsable',current.assignee),_row('Creada',current.createdAt.toString()),if(current.closedAt!=null)_row('Cerrada',current.closedAt.toString())])),),
    const SizedBox(height:12),
    Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Cambiar estado',style:TextStyle(fontWeight:FontWeight.bold)),const SizedBox(height:10),Wrap(spacing:8,children:['Pendiente','En proceso','Finalizado'].map((s)=>ChoiceChip(label:Text(s),selected:current.status==s,onSelected:(_)=>updateStatus(s))).toList())])),),
    const SizedBox(height:12),
    Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Comentarios',style:TextStyle(fontWeight:FontWeight.bold)),...current.comments.map((c)=>ListTile(contentPadding:EdgeInsets.zero,leading:const Icon(Icons.comment_outlined),title:Text(c))),TextField(controller:comment,decoration:InputDecoration(labelText:'Agregar comentario',suffixIcon:IconButton(onPressed:addComment,icon:const Icon(Icons.send))))])),),
  ]));
  Widget _row(String a,String b)=>Padding(padding:const EdgeInsets.symmetric(vertical:4),child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[SizedBox(width:110,child:Text(a,style:const TextStyle(fontWeight:FontWeight.bold))),Expanded(child:Text(b))]));
}