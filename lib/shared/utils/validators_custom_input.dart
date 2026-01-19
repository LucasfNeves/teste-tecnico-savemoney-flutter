class ValidatorsCustomInput {
  static const String _requiredMessage = 'Campo obrigatório';
  static const String _invalidEmailMessage = 'E-mail inválido';
  static const String _invalidPasswordMessage =
      'Senha deve ter pelo menos 6 caracteres';
  static const String _invalidFullNameMessage = 'Digite nome e sobrenome';
  static const String _invalidPhoneMessage = 'Telefone inválido';

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static String? required(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? _requiredMessage;
    }
    return null;
  }

  static String? email(String? value, {String? message}) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    if (!_emailRegex.hasMatch(value!.trim())) {
      return message ?? _invalidEmailMessage;
    }
    return null;
  }

  static String? password(
    String? value, {
    int minLength = 6,
    bool requireUppercase = false,
    bool requireLowercase = false,
    bool requireNumber = false,
    bool requireSpecialChar = false,
    String? message,
  }) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    if (value!.length < minLength) {
      return message ?? _invalidPasswordMessage;
    }

    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return 'Senha deve conter pelo menos uma letra maiúscula';
    }

    if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      return 'Senha deve conter pelo menos uma letra minúscula';
    }

    if (requireNumber && !value.contains(RegExp(r'[0-9]'))) {
      return 'Senha deve conter pelo menos um número';
    }

    if (requireSpecialChar &&
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Senha deve conter pelo menos um caractere especial';
    }

    return null;
  }

  static String? fullName(String? value, {String? message}) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    final trimmed = value!.trim();
    final parts = trimmed.split(RegExp(r'\s+'));

    if (parts.length < 2) {
      return message ?? _invalidFullNameMessage;
    }

    if (parts.any((part) => part.length < 2)) {
      return 'Nome e sobrenome devem ter pelo menos 2 caracteres';
    }

    return null;
  }

  static String? phone(String? value, {String? message}) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    final cleaned = value!.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleaned.length < 10 || cleaned.length > 11) {
      return message ?? _invalidPhoneMessage;
    }

    return null;
  }

  static String? phoneWithAreaCode(String? areaCode, String? number) {
    // Validações específicas para campos separados
    if ((areaCode == null || areaCode.isEmpty) &&
        (number == null || number.isEmpty)) {
      return 'O telefone é obrigatório.';
    }

    if (areaCode == null || areaCode.isEmpty) {
      return 'O DDD é obrigatório.';
    }

    if (areaCode.length < 2) {
      return 'O DDD deve ter 2 dígitos.';
    }

    if (number == null || number.isEmpty) {
      return 'O número é obrigatório.';
    }

    final fullPhone = areaCode + number.replaceAll(RegExp(r'\D'), '');
    return phone(fullPhone);
  }

  static String? isNumber(String? value, {String? message}) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    if (double.tryParse(value!) == null) {
      return message ?? 'Deve ser um número válido';
    }
    return null;
  }
}
