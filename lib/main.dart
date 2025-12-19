import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'screens/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Cargar variables de entorno
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    print('Warning: No se pudo cargar .env: $e');
    // Usar valores por defecto si no existe .env
  }
  
  // Inicializar Supabase
  try {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? 'https://gwapxyguzvhecorqgjeh.supabase.co',
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd3YXB4eWd1enZoZWNvcnFnamVoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ3Mjc3MzAsImV4cCI6MjA4MDMwMzczMH0.WlWVytxQaZlAVXjoFdqYFsxar4I7us0gupz3XV8_BJc',
    );
    print('✅ Supabase inicializado correctamente');
  } catch (e) {
    print('⚠️ Error inicializando Supabase: $e');
  }
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ohmelon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(), // Pantalla principal con navegación inferior
      debugShowCheckedModeBanner: false,
    );
  }
}
