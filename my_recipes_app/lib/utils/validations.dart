class Validations {
  // Validar el nombre
  static bool isValidName(String name) {
    return name.isNotEmpty; // Laxamente, solo verificamos que no esté vacío
  }

  // Validar el email
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Validar la contraseña
  static bool isValidPassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{7,}$');
    return passwordRegex.hasMatch(password);
  }

  // Validar confirmación de contraseña
  static bool doPasswordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  // Validar primera letra en mayusculas
  static String firstLetterUpperCase(String title) {
    title = title.trim();
    title = title[0].toUpperCase()+title.substring(1);
    return title;
  }
}
