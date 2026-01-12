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
}
