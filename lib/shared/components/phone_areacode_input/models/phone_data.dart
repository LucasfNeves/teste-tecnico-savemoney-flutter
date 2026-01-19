// lib/shared/components/phone_areacode_input/models/phone_data.dart

import 'package:equatable/equatable.dart';

class PhoneData extends Equatable {
  final String areaCode;
  final String number;

  const PhoneData({
    required this.areaCode,
    required this.number,
  });

  const PhoneData.empty()
      : areaCode = '',
        number = '';

  String get fullPhone => '$areaCode${number.replaceAll(RegExp(r'\D'), '')}';

  String get formattedPhone =>
      areaCode.isEmpty || number.isEmpty ? '' : '($areaCode) $number';

  bool get isComplete => areaCode.isNotEmpty && number.isNotEmpty;

  PhoneData copyWith({
    String? areaCode,
    String? number,
  }) {
    return PhoneData(
      areaCode: areaCode ?? this.areaCode,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'area_code': areaCode,
      'number': number.replaceAll(RegExp(r'\D'), ''),
    };
  }

  factory PhoneData.fromJson(Map<String, dynamic> json) {
    return PhoneData(
      areaCode: json['area_code']?.toString() ?? '',
      number: json['number']?.toString() ?? '',
    );
  }

  @override
  List<Object?> get props => [areaCode, number];

  @override
  bool get stringify => true;
}

extension PhoneDataListExtensions on List<PhoneData> {
  List<Map<String, dynamic>> toJsonList() {
    return map((phone) => phone.toJson()).toList();
  }
}

extension PhoneDataMapListExtensions on List<Map<String, dynamic>> {
  List<PhoneData> toPhoneDataList() {
    return map((map) => PhoneData.fromJson(map)).toList();
  }
}
