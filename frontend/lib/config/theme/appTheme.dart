import 'package:flutter/material.dart';

class AppTheme {

  static const Color azulOscuro = Color(0xFF00374B);
  static const Color verdeAgua = Color(0xFF517F72);
  static const Color morado = Color(0xFF311073);
  static const Color azulMar = Color(0xFF165795);
  static const Color azulVerdoso = Color(0xFF458997);
  static const Color verde = Color(0xFF80B03B);

  static const Color primaryColor = Colors.blue;
  static const Color bodyTextColor = Color.fromARGB(255, 135, 135, 135);
  static const Color inputFillColor = Colors.white;
  static const Color buttonBackgroundColor = Color.fromARGB(255, 3, 37, 64);
  static const Color buttonForegroundColor = Colors.white;
  static const Color registerTextColor = Color.fromARGB(255, 127, 12, 198);
  static const Color questionTextColor = Color.fromARGB(255, 3, 37, 64);

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 135, 135, 135),
        fontSize: 14,
      ),
    ),
  );

  static InputDecoration inputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white.withOpacity(0.7),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
  );

  static ButtonStyle elevatedButtonStyle = ButtonStyle(
    padding: WidgetStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0)),
    minimumSize: WidgetStateProperty.all<Size>(const Size(200, 60)),
    backgroundColor: WidgetStateProperty.all<Color>(
        const Color.fromARGB(255, 3, 37, 64)),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
  );

  static TextStyle registerTextStyle = const TextStyle(
    fontSize: 16,
    color: Color.fromARGB(255, 127, 12, 198),
    fontWeight: FontWeight.w800,
  );

  static TextStyle questionTextStyle = const TextStyle(
    fontSize: 16,
    color: Color.fromARGB(255, 3, 37, 64),
    fontWeight: FontWeight.w700,
  );


}
