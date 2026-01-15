import '../../shared/utils/string_extensions.dart';

class User {
  final String id;
  final String name;
  final String email;
  final List<Telephone> telephones;
  final DateTime createdAt;
  final DateTime modifiedAt;

  User({
    required this.id,
    this.name = '',
    required this.email,
    required this.telephones,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      telephones: json['telephones'] != null
          ? (json['telephones'] as List)
              .map((tel) => Telephone.fromJson(tel))
              .toList()
          : [],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      modifiedAt: json['modified_at'] != null
          ? DateTime.parse(json['modified_at'])
          : DateTime.now(),
    );
  }

  String get initial =>
      name.isNotEmpty ? name.firstLetterOrDefault : email.firstLetterOrDefault;

  String get displayName => name.isNotEmpty ? name : email.emailUsername;

  List<String> get formattedPhones => telephones
      .map((tel) =>
          '(${tel.areaCode.toString().padLeft(2, '0')}) ${tel.formattedNumber}')
      .toList();
}

class Telephone {
  final int areaCode;
  final int number;

  Telephone({
    required this.areaCode,
    required this.number,
  });

  factory Telephone.fromJson(Map<String, dynamic> json) {
    return Telephone(
      areaCode: json['area_code'] ?? 0,
      number: json['number'] ?? 0,
    );
  }

  String get formattedNumber {
    String numStr = number.toString();
    if (numStr.length == 9) {
      return '${numStr.substring(0, 1)} ${numStr.substring(1, 5)}-${numStr.substring(5)}';
    }
    return numStr;
  }
}
