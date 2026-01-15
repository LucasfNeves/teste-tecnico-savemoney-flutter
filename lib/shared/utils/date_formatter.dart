// /home/lneves/projects/savemoney_flutter/lib/shared/utils/date_formatter.dart
class DateFormatter {
  static String formatDate(String? dateString) {
    if (dateString == null) return '';

    try {
      final date = DateTime.parse(dateString);
      final day = date.day.toString().padLeft(2, '0');
      final month = date.month.toString().padLeft(2, '0');
      final year = date.year;

      return '$day/$month/$year';
    } catch (e) {
      return dateString;
    }
  }
}
