import 'package:intl/intl.dart';

class EventModel {
  final String eventTitle;
  final String eventObjective;
  final DateTime eventDate;
  final String eventLocation;
  final bool targetTeachers;
  final bool targetStudents;
  final bool targetAdministrative;
  final bool targetGeneral;
  final String additionalDetails;
  final List<String> imageUrls;
  final List<String> participantProfilePictures;

  EventModel({
    required this.eventTitle,
    required this.eventObjective,
    required this.eventDate,
    required this.eventLocation,
    required this.targetTeachers,
    required this.targetStudents,
    required this.targetAdministrative,
    required this.targetGeneral,
    required this.additionalDetails,
    required this.imageUrls,
    required this.participantProfilePictures,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventTitle: json['eventTitle'] ?? '',
      eventObjective: json['eventObjective'] ?? '',
      eventDate: _parseFlexibleDate(json['eventDate']), // <- aquí
      eventLocation: json['eventLocation'] ?? '',
      targetTeachers: json['targetTeachers'] ?? false,
      targetStudents: json['targetStudents'] ?? false,
      targetAdministrative: json['targetAdministrative'] ?? false,
      targetGeneral: json['targetGeneral'] ?? false,
      additionalDetails: json['additionalDetails'] ?? '',
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      participantProfilePictures:
          List<String>.from(json['participantProfilePictures'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventTitle': eventTitle,
      'eventObjective': eventObjective,
      'eventDate': eventDate.toIso8601String(),
      'eventLocation': eventLocation,
      'targetTeachers': targetTeachers,
      'targetStudents': targetStudents,
      'targetAdministrative': targetAdministrative,
      'targetGeneral': targetGeneral,
      'additionalDetails': additionalDetails,
      'imageUrls': imageUrls,
      'participantProfilePictures': participantProfilePictures,
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
