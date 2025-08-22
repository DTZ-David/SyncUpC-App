import 'package:intl/intl.dart';

class EventModel {
  final String id;
  final String eventTitle;
  final String eventObjective;
  final DateTime eventStartDate;
  final DateTime eventEndDate;
  final String eventLocation;
  final bool targetTeachers;
  final bool targetStudents;
  final bool targetAdministrative;
  final bool targetGeneral;
  final String additionalDetails;
  final List<String> imageUrls;
  final List<String> participantProfilePictures;
  final List<String> tags;
  final bool isSaved;
  final String status;

  EventModel(
      {required this.isSaved,
      required this.id,
      required this.eventTitle,
      required this.eventObjective,
      required this.eventStartDate,
      required this.eventEndDate,
      required this.eventLocation,
      required this.targetTeachers,
      required this.targetStudents,
      required this.targetAdministrative,
      required this.targetGeneral,
      required this.additionalDetails,
      required this.imageUrls,
      required this.tags,
      required this.participantProfilePictures,
      required this.status});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? '',
      eventTitle: json['eventTitle'] ?? '',
      eventObjective: json['eventObjective'] ?? '',
      eventStartDate: _parseFlexibleDate(json['eventStartDate']), // <- aquí
      eventEndDate: _parseFlexibleDate(json['eventEndDate']), // <- aquí
      eventLocation: json['eventLocation'] ?? '',
      targetTeachers: json['targetTeachers'] ?? false,
      targetStudents: json['targetStudents'] ?? false,
      targetAdministrative: json['targetAdministrative'] ?? false,
      targetGeneral: json['targetGeneral'] ?? false,
      additionalDetails: json['additionalDetails'] ?? '',
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      participantProfilePictures:
          List<String>.from(json['participantProfilePictures'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      isSaved: json['isSaved'] ?? '',
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
      'eventLocation': eventLocation,
      'targetTeachers': targetTeachers,
      'targetStudents': targetStudents,
      'targetAdministrative': targetAdministrative,
      'targetGeneral': targetGeneral,
      'additionalDetails': additionalDetails,
      'imageUrls': imageUrls,
      'participantProfilePictures': participantProfilePictures,
      'tags': tags,
      'isSaved': isSaved,
      'status': status
    };
  }

  static DateTime _parseFlexibleDate(String raw) {
    try {
      return DateTime.parse(raw); // ISO 8601
    } catch (_) {
      // Formato real: dd/MM/yyyy HH:mm:ss
      return DateFormat("dd/MM/yyyy HH:mm:ss").parse(raw);
    }
  }
}
