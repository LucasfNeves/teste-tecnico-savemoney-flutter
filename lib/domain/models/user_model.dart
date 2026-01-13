class User {
  final String id;
  final String email;
  final List<Telephone> telephones;
  final DateTime createdAt;
  final DateTime modifiedAt;

  User({
    required this.id,
    required this.email,
    required this.telephones,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      telephones: (json['telephones'] as List)
          .map((tel) => Telephone.fromJson(tel))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
      modifiedAt: DateTime.parse(json['modified_at']),
    );
  }

  String get name => email.split('@')[0];
  String get initial => name.isNotEmpty ? name[0].toUpperCase() : '';

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
      areaCode: json['area_code'],
      number: json['number'],
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
