class ValidatorsCustomInput {
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    if (!value.contains('@')) return 'E-mail inválido';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    if (value.length < 6) return 'Senha deve ter pelo menos 6 caracteres';
    return null;
  }

  static String? fullName(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    final trimmed = value.trim();
    final parts = trimmed.split(' ');
    if (parts.length < 2) return 'Digite nome e sobrenome';
    if (parts.any((part) => part.isEmpty)) return 'Nome inválido';
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length < 10) return 'Telefone deve ter pelo menos 10 dígitos';
    return null;
  }
}
