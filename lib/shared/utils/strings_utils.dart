import 'package:flutter/material.dart';

extension StringUtils on String {
  String truncateWithEllipsis(int maxLength, {String ellipsis = '…'}) {
    final chars = Characters(this);
    if (chars.length <= maxLength) return this;
    return chars.take(maxLength).toString() + ellipsis;
  }

  String get firstLetterOrDefault {
    if (isEmpty) return '?';
    return this[0].toUpperCase();
  }

  // Retorna o nome de usuário do email (antes do @)
  String get emailUsername {
    final parts = split('@');
    return parts.isNotEmpty ? parts[0] : this;
  }
}
