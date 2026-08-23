import 'package:flutter/material.dart';
import '../models/incident.dart';

class IncidentCard extends StatelessWidget {
  const IncidentCard({super.key, required this.incident, required this.onTap});
  final Incident incident;
  final VoidCallback onTap;

  Color priorityColor(BuildContext context) {
    switch (incident.priority) {
      case 'Crítica': return Theme.of(context).colorScheme.error;
      case 'Alta': return Colors.orange;
      case 'Baja': return Colors.green;
      default: return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text('#${incident.id.substring(0, 6).toUpperCase()}', style: const TextStyle(fontWeight: FontWeight.bold))),
              Chip(label: Text(incident.priority), avatar: CircleAvatar(backgroundColor: priorityColor(context), radius: 5)),
            ]),
            Text(incident.description, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: [
              Chip(label: Text(incident.status)),
              Chip(label: Text(incident.location)),
              Chip(label: Text(incident.department)),
            ]),
          ]),
        ),
      ),
    );
  }
}