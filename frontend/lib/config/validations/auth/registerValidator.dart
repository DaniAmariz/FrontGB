class RegisterValidator{

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre no puede estar vacío';
    }
    if (value.length > 50) {
      return 'El nombre debe tener al menos 50 caracteres';
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'El apellido no puede estar vacío';
    }
    if (value.length > 50) {
      return 'El apellido debe tener al menos 50 caracteres';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña no puede estar vacía';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[^\w\s])[A-Za-z\d\W]+$')
        .hasMatch(value)) {
      return 'La contraseña debe incluir letras, números y caracteres especiales';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu nombre de usuario';
    } else if (value.length < 4) {
      return 'El usuario debe tener al menos 4 caracteres';
    } else if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
      return 'El usuario debe contener al menos 4 letras';
    } else if (RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'El usuario no puede ser solo números';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu correo electrónico';
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Por favor, ingresa un correo electrónico válido';
    }
    return null;
  }

  static String? validateConfirmedPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Por favor, confirma tu contraseña';
    } else if (value != password) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  static String? validateSelection(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Por favor, selecciona $fieldName';
    }
    return null;
  }

  static String? validateBirthDate(String? birthDateStr) {
    if (birthDateStr == null || birthDateStr.isEmpty) {
      return 'Por favor, ingresa tu fecha de nacimiento';
    }

    try {
      final parts = birthDateStr.split('/');
      if (parts.length != 3) {
        return 'Fecha inválida, usa el formato DD/MM/AAAA';
      }

      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);

      DateTime birthDate = DateTime(year, month, day);

      if (birthDate.isAfter(DateTime.now())) {
        return 'La fecha de nacimiento no puede ser en el futuro';
      }

      final DateTime tenYearsAgo =
      DateTime.now().subtract(const Duration(days: 365 * 10));
      if (birthDate.isAfter(tenYearsAgo)) {
        return 'Debes tener al menos 10 años de edad';
      }
    } catch (e) {
      return 'Fecha inválida, usa el formato DD/MM/AAAA';
    }

    return null;
  }
}