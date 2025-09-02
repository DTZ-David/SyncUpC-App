import 'package:intl/intl.dart';

class EventModel {
  final String id;
  final String eventTitle;
  final String eventObjective;
  final DateTime eventStartDate;
  final DateTime eventEndDate;

  final CampusModel campus;
  final SpaceModel space;

  final bool targetTeachers;
  final bool targetStudents;
  final bool targetAdministrative;
  final bool targetGeneral;

  final String additionalDetails;
  final List<String> imageUrls;
  final List<String> participantProfilePictures;

  final List<CategoryModel> categories;
  final List<EventTypeModel> eventTypes;

  final bool isSaved;
  final String status;

  EventModel({
    required this.id,
    required this.eventTitle,
    required this.eventObjective,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.campus,
    required this.space,
    required this.targetTeachers,
    required this.targetStudents,
    required this.targetAdministrative,
    required this.targetGeneral,
    required this.additionalDetails,
    required this.imageUrls,
    required this.participantProfilePictures,
    required this.categories,
    required this.eventTypes,
    required this.isSaved,
    required this.status,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? '',
      eventTitle: json['eventTitle'] ?? '',
      eventObjective: json['eventObjective'] ?? '',
      eventStartDate: _parseFlexibleDate(json['eventStartDate']),
      eventEndDate: _parseFlexibleDate(json['eventEndDate']),
      campus: CampusModel.fromJson(json['campus'] ?? {}),
      space: SpaceModel.fromJson(json['space'] ?? {}),
      targetTeachers: json['targetTeachers'] ?? false,
      targetStudents: json['targetStudents'] ?? false,
      targetAdministrative: json['targetAdministrative'] ?? false,
      targetGeneral: json['targetGeneral'] ?? false,
      additionalDetails: json['additionalDetails'] ?? '',
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      participantProfilePictures:
          List<String>.from(json['participantProfilePictures'] ?? []),
      categories: (json['categories'] as List? ?? [])
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
      eventTypes: (json['eventTypes'] as List? ?? [])
          .map((e) => EventTypeModel.fromJson(e))
          .toList(),
      isSaved: json['isSaved'] ?? false,
      status: json['status'] ?? 'Created',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventTitle': eventTitle,
      'eventObjective': eventObjective,
      'eventStartDate': eventStartDate.toIso8601String(),
      'eventEndDate': eventEndDate.toIso8601String(),
      'campus': campus.toJson(),
      'space': space.toJson(),
      'targetTeachers': targetTeachers,
      'targetStudents': targetStudents,
      'targetAdministrative': targetAdministrative,
      'targetGeneral': targetGeneral,
      'additionalDetails': additionalDetails,
      'imageUrls': imageUrls,
      'participantProfilePictures': participantProfilePictures,
      'categories': categories.map((e) => e.toJson()).toList(),
      'eventTypes': eventTypes.map((e) => e.toJson()).toList(),
      'isSaved': isSaved,
      'status': status,
    };
  }

  static DateTime _parseFlexibleDate(String raw) {
    try {
      // Caso ISO 8601 (ej: "2025-09-01T22:30:00Z")
      return DateTime.parse(raw).toLocal();
    } catch (_) {
      // Caso personalizado "dd/MM/yyyy HH:mm:ss"
      return DateFormat("dd/MM/yyyy HH:mm:ss").parseUtc(raw).toLocal();
    }
  }
}

/// Campus
class CampusModel {
  final String name;

  CampusModel({required this.name});

  factory CampusModel.fromJson(Map<String, dynamic> json) {
    return CampusModel(name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}

/// Space
class SpaceModel {
  final String name;

  SpaceModel({required this.name});

  factory SpaceModel.fromJson(Map<String, dynamic> json) {
    return SpaceModel(name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}

/// Category
class CategoryModel {
  final String name;

  CategoryModel({required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}

/// EventType
class EventTypeModel {
  final String name;

  EventTypeModel({required this.name});

  factory EventTypeModel.fromJson(Map<String, dynamic> json) {
    return EventTypeModel(name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
