class EventSpaceRequest {
  final String id;
  final String name;
  final String description;
  final String creationDate;
  final String campusId;
  final String modificationDate;

  EventSpaceRequest({
    required this.id,
    required this.name,
    required this.description,
    required this.campusId,
    required this.creationDate,
    required this.modificationDate,
  });

  factory EventSpaceRequest.fromJson(Map<String, dynamic> json) {
    return EventSpaceRequest(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      campusId: json['campusId'] ?? '',
      creationDate: json['creationDate'] ?? '',
      modificationDate: json['modificationDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'campusId': campusId,
      'creationDate': creationDate,
      'modificationDate': modificationDate,
    };
  }
}
