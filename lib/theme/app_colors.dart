import 'package:flutter/material.dart';

class AppColors {
  // Colores principales - Tema verde melón
  static const Color primary = Color(0xFF4CAF50);        // Verde principal
  static const Color primaryDark = Color(0xFF388E3C);   // Verde oscuro
  static const Color primaryLight = Color(0xFF81C784);  // Verde claro
  static const Color secondary = Color(0xFFFF9800);      // Naranja complementario
  static const Color accent = Color(0xFFFFC107);         // Amarillo acento
  
  // Colores de fondo
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFFE8E8E8);
  
  // Colores de texto
  static const Color text = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFFFFFFF);
  
  // Colores de estado
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Colores de UI
  static const Color border = Color(0xFFE0E0E0);
  static const Color shadow = Color(0x1A000000);
  
  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}




