import 'package:flutter/foundation.dart';
import '../models/incident.dart';
import 'incident_service.dart';

class AppState extends ChangeNotifier {
  AppState(this.service);
  final IncidentService service;
  List<Incident> incidents = [];

  Future<void> load() async {
    if (service.demoMode) {
      incidents = service.demoIncidents;
      notifyListeners();
      return;
    }
    service.watchIncidents().listen((data) {
      incidents = data;
      notifyListeners();
    });
  }

  Future<void> create(Incident incident) async {
    await service.createIncident(incident);
    if (service.demoMode) await load();
  }

  Future<void> update(Incident incident) async {
    await service.updateIncident(incident);
    if (service.demoMode) await load();
  }

  Future<void> remove(String id) async {
    await service.deleteIncident(id);
    if (service.demoMode) await load();
  }
}