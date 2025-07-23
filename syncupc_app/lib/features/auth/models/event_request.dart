class EventRequest {
  final String eventTitle;
  final String eventObjective;
  final String eventLocation;
  final String address;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime registrationStart;
  final DateTime registrationEnd;
  final List<String> careerIds;
  final bool targetTeachers;
  final bool targetStudents;
  final bool targetAdministrative;
  final bool targetGeneral;
  final bool isVirtual;
  final String? meetingUrl;
  final int maxCapacity;
  final bool requiresRegistration;
  final bool isPublic;
  final List<String> tags;
  final List<String> imageUrls;
  final String? additionalDetails;

  EventRequest({
    required this.eventTitle,
    required this.eventObjective,
    required this.eventLocation,
    required this.address,
    required this.startDate,
    required this.endDate,
    required this.registrationStart,
    required this.registrationEnd,
    required this.careerIds,
    required this.targetTeachers,
    required this.targetStudents,
    required this.targetAdministrative,
    required this.targetGeneral,
    required this.isVirtual,
    this.meetingUrl,
    required this.maxCapacity,
    required this.requiresRegistration,
    required this.isPublic,
    required this.tags,
    required this.imageUrls,
    this.additionalDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'eventTitle': eventTitle,
      'eventObjective': eventObjective,
      'eventLocation': eventLocation,
      'address': address,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'registrationStart': registrationStart.toIso8601String(),
      'registrationEnd': registrationEnd.toIso8601String(),
      'careerIds': careerIds,
      'targetTeachers': targetTeachers,
      'targetStudents': targetStudents,
      'targetAdministrative': targetAdministrative,
      'targetGeneral': targetGeneral,
      'isVirtual': isVirtual,
      'meetingUrl': meetingUrl,
      'maxCapacity': maxCapacity,
      'requiresRegistration': requiresRegistration,
      'isPublic': isPublic,
      'tags': tags,
      'imageUrls': imageUrls,
      'additionalDetails': additionalDetails,
    };
  }
}
