class EventCampusRequest {
  final String id;
  final String name;
  final String description;
  final String creationDate;
  final String modificationDate;

  EventCampusRequest({
    required this.id,
    required this.name,
    required this.description,
    required this.creationDate,
    required this.modificationDate,
  });

  factory EventCampusRequest.fromJson(Map<String, dynamic> json) {
    return EventCampusRequest(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      creationDate: json['creationDate'] ?? '',
      modificationDate: json['modificationDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'creationDate': creationDate,
      'modificationDate': modificationDate,
    };
  }
}
