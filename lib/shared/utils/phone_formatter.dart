class PhoneFormatter {
  static String format(String value) {
    String numbers = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (numbers.length > 9) numbers = numbers.substring(0, 9);

    String formatted = '';
    if (numbers.isNotEmpty) {
      formatted = numbers[0];
      if (numbers.length > 1) {
        formatted +=
            ' ${numbers.substring(1, numbers.length > 5 ? 5 : numbers.length)}';
      }
      if (numbers.length > 5) {
        formatted += '-${numbers.substring(5)}';
      }
    }
    return formatted;
  }
}
