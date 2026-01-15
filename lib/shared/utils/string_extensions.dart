extension StringExtensions on String {
  /// Trunca o texto para o comprimento máximo especificado e adiciona '...'
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }

  /// Retorna a primeira letra maiúscula ou um caractere padrão
  String get firstLetterOrDefault {
    if (isEmpty) return '?';
    return this[0].toUpperCase();
  }

  /// Retorna o nome de usuário do email (antes do @)
  String get emailUsername {
    final parts = split('@');
    return parts.isNotEmpty ? parts[0] : this;
  }
}
