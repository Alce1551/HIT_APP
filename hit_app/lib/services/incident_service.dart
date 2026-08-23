import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../models/incident.dart';

class IncidentService {
  IncidentService({required this.demoMode});
  final bool demoMode;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _uuid = const Uuid();
  final List<Incident> _demo = [];

  Stream<List<Incident>> watchIncidents() {
    if (demoMode) {
      return Stream<List<Incident>>.multi((controller) {
        controller.add(List.unmodifiable(_demo));
        // Demo refresh: UI calls refresh through notify listeners in repository-like flow.
      });
    }
    return _firestore.collection('incidents').orderBy('createdAt', descending: true).snapshots().map(
          (snapshot) => snapshot.docs.map((d) => Incident.fromMap(d.id, d.data())).toList(),
        );
  }

  List<Incident> get demoIncidents => List.unmodifiable(_demo);

  Future<String> createIncident(Incident incident) async {
    if (demoMode) {
      _demo.insert(0, incident);
      return incident.id;
    }
    final ref = await _firestore.collection('incidents').add(incident.toMap());
    return ref.id;
  }

  Future<void> updateIncident(Incident incident) async {
    if (demoMode) {
      final i = _demo.indexWhere((x) => x.id == incident.id);
      if (i >= 0) _demo[i] = incident;
      return;
    }
    await _firestore.collection('incidents').doc(incident.id).update(incident.toMap());
  }

  Future<void> deleteIncident(String id) async {
    if (demoMode) {
      _demo.removeWhere((x) => x.id == id);
      return;
    }
    await _firestore.collection('incidents').doc(id).delete();
  }

  Future<String> uploadEvidence(String incidentId, XFile image) async {
    if (demoMode) return 'demo://evidence/$incidentId';
    final bytes = await image.readAsBytes();
    final ref = _storage.ref('incidents/$incidentId/${_uuid.v4()}.jpg');
    await ref.putData(bytes, SettableMetadata(contentType: 'image/jpeg'));
    return ref.getDownloadURL();
  }
}