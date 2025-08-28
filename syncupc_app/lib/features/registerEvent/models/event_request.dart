class EventRequest {
  final String eventTitle;
  final String eventObjective;
  final String campusId;
  final String spaceId;
  final DateTime startDate;
  final DateTime endDate;
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
  final List<String> eventTypesId;
  final List<String> eventCategoryId;
  final List<String> imageUrls;
  final String? additionalDetails;

  const EventRequest({
    required this.eventTitle,
    required this.eventObjective,
    required this.campusId,
    required this.spaceId,
    required this.startDate,
    required this.endDate,
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
    required this.eventTypesId,
    required this.eventCategoryId,
    required this.imageUrls,
    this.additionalDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'eventTitle': eventTitle,
      'eventObjective': eventObjective,
      'campusId': campusId,
      'spaceId': spaceId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
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
      'eventTypesId': eventTypesId,
      'eventCategoryId': eventCategoryId,
      'imageUrls': imageUrls,
      'additionalDetails': additionalDetails,
    };
  }

  factory EventRequest.fromJson(Map<String, dynamic> json) {
    return EventRequest(
      eventTitle: json['eventTitle'] ?? '',
      eventObjective: json['eventObjective'] ?? '',
      campusId: json['campusId'] ?? '',
      spaceId: json['spaceId'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      careerIds: List<String>.from(json['careerIds'] ?? []),
      targetTeachers: json['targetTeachers'] ?? false,
      targetStudents: json['targetStudents'] ?? false,
      targetAdministrative: json['targetAdministrative'] ?? false,
      targetGeneral: json['targetGeneral'] ?? false,
      isVirtual: json['isVirtual'] ?? false,
      meetingUrl: json['meetingUrl'],
      maxCapacity: json['maxCapacity'] ?? 0,
      requiresRegistration: json['requiresRegistration'] ?? false,
      isPublic: json['isPublic'] ?? false,
      eventTypesId: List<String>.from(json['eventTypesId'] ?? []),
      eventCategoryId: List<String>.from(json['eventCategoryId'] ?? []),
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      additionalDetails: json['additionalDetails'],
    );
  }

  EventRequest copyWith({
    String? eventTitle,
    String? eventObjective,
    String? campusId,
    String? spaceId,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? careerIds,
    bool? targetTeachers,
    bool? targetStudents,
    bool? targetAdministrative,
    bool? targetGeneral,
    bool? isVirtual,
    String? meetingUrl,
    int? maxCapacity,
    bool? requiresRegistration,
    bool? isPublic,
    List<String>? eventTypesId,
    List<String>? eventCategoryId,
    List<String>? imageUrls,
    String? additionalDetails,
  }) {
    return EventRequest(
      eventTitle: eventTitle ?? this.eventTitle,
      eventObjective: eventObjective ?? this.eventObjective,
      campusId: campusId ?? this.campusId,
      spaceId: spaceId ?? this.spaceId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      careerIds: careerIds ?? this.careerIds,
      targetTeachers: targetTeachers ?? this.targetTeachers,
      targetStudents: targetStudents ?? this.targetStudents,
      targetAdministrative: targetAdministrative ?? this.targetAdministrative,
      targetGeneral: targetGeneral ?? this.targetGeneral,
      isVirtual: isVirtual ?? this.isVirtual,
      meetingUrl: meetingUrl ?? this.meetingUrl,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      requiresRegistration: requiresRegistration ?? this.requiresRegistration,
      isPublic: isPublic ?? this.isPublic,
      eventTypesId: eventTypesId ?? this.eventTypesId,
      eventCategoryId: eventCategoryId ?? this.eventCategoryId,
      imageUrls: imageUrls ?? this.imageUrls,
      additionalDetails: additionalDetails ?? this.additionalDetails,
    );
  }
}
