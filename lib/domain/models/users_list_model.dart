import '../../shared/utils/string_extensions.dart';

class UserList {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;
  final DateTime modifiedAt;

  UserList({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      modifiedAt: json['modified_at'] != null
          ? DateTime.parse(json['modified_at'])
          : DateTime.now(),
    );
  }

  String get initial => name.isNotEmpty
      ? name.firstLetterOrDefault
      : email.firstLetterOrDefault;

  String get displayName => name.isNotEmpty ? name : email.emailUsername;
}
