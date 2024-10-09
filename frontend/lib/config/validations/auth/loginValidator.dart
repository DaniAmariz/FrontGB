
class LoginValidator{


  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu nombre de usuario';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña no puede estar vacía';
    }
    return null;

  }

}