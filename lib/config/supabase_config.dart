// SUSPENDIDO - Solo usando productos y tiendas hardcodeados
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../utils/logger.dart';
// import '../services/supabase_rest_client.dart';

// class SupabaseConfig {
//   static late SupabaseRestClient restClient;
  
//   static const String supabaseUrl = 'https://gwapxyguzvhecorqgjeh.supabase.co';
//   static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd3YXB4eWd1enZoZWNvcnFnamVoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ3Mjc3MzAsImV4cCI6MjA4MDMwMzczMH0.WlWVytxQaZlAVXjoFdqYFsxar4I7us0gupz3XV8_BJc';

//   static Future<void> initialize() async {
//     final logger = AppLogger();
//     try {
//       logger.logInfo('🔄 Inicializando Supabase con REST Client...');
      
//       // Inicializar REST client
//       restClient = SupabaseRestClient();
      
//       // Intentar inicializar Supabase normal (para auth)
//       try {
//         await Supabase.initialize(
//           url: supabaseUrl,
//           anonKey: supabaseAnonKey,
//         );
//         logger.logSuccess('✅ Supabase inicializado');
//       } catch (e) {
//         logger.logWarning('⚠️ Supabase init falló (usando REST): $e');
//       }
      
//       // Probar con REST Client
//       logger.logInfo('📡 Probando REST Client...');
//       final productos = await restClient.queryTable('productos');
//       logger.logSuccess('✓ REST: ${productos.length} productos cargados');
      
//       final tiendas = await restClient.queryTable('tiendas');
//       logger.logSuccess('✓ REST: ${tiendas.length} tiendas cargadas');
      
//     } catch (e, stackTrace) {
//       logger.logError('❌ Error: $e');
//       logger.logInfo('$stackTrace');
//     }
//   }

//   static SupabaseClient get client {
//     try {
//       return Supabase.instance.client;
//     } catch (e) {
//       throw Exception('Supabase no inicializado: $e');
//     }
//   }

//   static SupabaseRestClient get rest => restClient;
// }
