import 'notification_preferences.dart';

class RegisterUserRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String profilePhotoUrl;
  final String careerId;
  final String facultyId;
  final NotificationPreferences notificationPreferences;

  RegisterUserRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.profilePhotoUrl,
    required this.careerId,
    required this.facultyId,
    NotificationPreferences? notificationPreferences,
  }) : notificationPreferences =
            notificationPreferences ?? NotificationPreferences.defaultPrefs();

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'profilePhotoUrl': profilePhotoUrl,
        'careerId': careerId,
        'facultyId': facultyId,
        'notificationPreferences': notificationPreferences.toJson(),
      };
  RegisterUserRequest copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phoneNumber,
    String? profilePhotoUrl,
    String? careerId,
    String? facultyId,
    NotificationPreferences? notificationPreferences,
  }) {
    return RegisterUserRequest(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      careerId: careerId ?? this.careerId,
      facultyId: facultyId ?? this.facultyId,
      notificationPreferences:
          notificationPreferences ?? this.notificationPreferences,
    );
  }
}
