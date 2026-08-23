import 'package:cloud_firestore/cloud_firestore.dart';

class Incident {
  final String id;
  final DateTime createdAt;
  final String reporter;
  final String department;
  final String location;
  final String type;
  final String priority;
  final String description;
  final String assignee;
  final String status;
  final DateTime? closedAt;
  final List<String> comments;
  final List<String> evidenceUrls;

  const Incident({
    required this.id,
    required this.createdAt,
    required this.reporter,
    required this.department,
    required this.location,
    required this.type,
    required this.priority,
    required this.description,
    required this.assignee,
    required this.status,
    this.closedAt,
    this.comments = const [],
    this.evidenceUrls = const [],
  });

  factory Incident.fromMap(String id, Map<String, dynamic> map) {
    DateTime parse(dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      return DateTime.tryParse(value?.toString() ?? '') ?? DateTime.now();
    }

    return Incident(
      id: id,
      createdAt: parse(map['createdAt']),
      reporter: map['reporter']?.toString() ?? '',
      department: map['department']?.toString() ?? 'Recepción',
      location: map['location']?.toString() ?? '',
      type: map['type']?.toString() ?? 'Otro',
      priority: map['priority']?.toString() ?? 'Media',
      description: map['description']?.toString() ?? '',
      assignee: map['assignee']?.toString() ?? 'Sin asignar',
      status: map['status']?.toString() ?? 'Pendiente',
      closedAt: map['closedAt'] == null ? null : parse(map['closedAt']),
      comments: List<String>.from(map['comments'] ?? const []),
      evidenceUrls: List<String>.from(map['evidenceUrls'] ?? const []),
    );
  }

  Map<String, dynamic> toMap() => {
        'createdAt': Timestamp.fromDate(createdAt),
        'reporter': reporter,
        'department': department,
        'location': location,
        'type': type,
        'priority': priority,
        'description': description,
        'assignee': assignee,
        'status': status,
        'closedAt': closedAt == null ? null : Timestamp.fromDate(closedAt!),
        'comments': comments,
        'evidenceUrls': evidenceUrls,
      };

  Incident copyWith({
    String? status,
    String? assignee,
    DateTime? closedAt,
    List<String>? comments,
    List<String>? evidenceUrls,
  }) => Incident(
        id: id,
        createdAt: createdAt,
        reporter: reporter,
        department: department,
        location: location,
        type: type,
        priority: priority,
        description: description,
        assignee: assignee ?? this.assignee,
        status: status ?? this.status,
        closedAt: closedAt ?? this.closedAt,
        comments: comments ?? this.comments,
        evidenceUrls: evidenceUrls ?? this.evidenceUrls,
      );
}