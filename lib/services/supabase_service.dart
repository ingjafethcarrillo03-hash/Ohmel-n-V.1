import 'dart:developer' as developer;
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;
  static const String _logTag = '📊 SupabaseService';
  
  // PAGINACIÓN: Constantes
  static const int DEFAULT_PAGE_SIZE = 50;
  static const int MAX_PAGE_SIZE = 100;

  // ✅ OBTENER TODOS LOS PRODUCTOS CON TRY-CATCH Y LOGS
  Future<List<Product>> getProducts() async {
    try {
      final startTime = DateTime.now();
      developer.log('🔄 Iniciando cárga de productos...', name: _logTag);
      print('$_logTag: 🔄 Iniciando cárga de productos...');

      final response = await supabase
          .from('productos')
          .select('sku, nombre, imagen_url, precio')
          .order('nombre', ascending: true)
          .limit(100);

      final duration = DateTime.now().difference(startTime);
      final productCount = (response as List).length;

      developer.log(
        '✅ Cárga completada: $productCount productos en ${duration.inMilliseconds}ms',
        name: _logTag,
      );
      print('$_logTag: ✅ $productCount productos cargados en ${duration.inMilliseconds}ms');

      return (response as List)
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      developer.log(
        '❌ ERROR PostgreSQL: ${e.message}\nCodigo: ${e.code}',
        name: _logTag,
        error: e,
      );
      print('$_logTag: ❌ ERROR PostgreSQL: ${e.message}');
      rethrow;
    } on SocketException catch (e) {
      developer.log(
        '❌ ERROR de Red: ${e.message}',
        name: _logTag,
        error: e,
      );
      print('$_logTag: ❌ ERROR de Red: ${e.message}');
      rethrow;
    } catch (e) {
      developer.log(
        '❌ ERROR Inesperado: $e',
        name: _logTag,
        error: e,
      );
      print('$_logTag: ❌ ERROR Inesperado: $e');
      rethrow;
    }
  }

  // ✅ OBTENER PRODUCTOS CON PAGINACIÓN
  Future<Map<String, dynamic>> getProductsPaginated({
    int page = 1,
    int pageSize = DEFAULT_PAGE_SIZE,
  }) async {
    try {
      if (pageSize > MAX_PAGE_SIZE) pageSize = MAX_PAGE_SIZE;

      final startTime = DateTime.now();
      final offset = (page - 1) * pageSize;

      developer.log(
        '📄 Página $page (offset: $offset, items: $pageSize)',
        name: _logTag,
      );
      print('$_logTag: 📄 Cargando página $page...');

      final response = await supabase
          .from('productos')
          .select('sku, nombre, imagen_url, precio')
          .order('nombre', ascending: true)
          .range(offset, offset + pageSize - 1);

      final items = (response as List)
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();

      final duration = DateTime.now().difference(startTime);

      developer.log(
        '✅ Página $page: ${items.length} items en ${duration.inMilliseconds}ms',
        name: _logTag,
      );
      print('$_logTag: ✅ Página $page cargada');

      return {
        'items': items,
        'page': page,
        'pageSize': pageSize,
        'hasMore': items.length == pageSize,
      };
    } on PostgrestException catch (e) {
      developer.log(
        '❌ ERROR en paginación: ${e.message}',
        name: _logTag,
        error: e,
      );
      print('$_logTag: ❌ ERROR: ${e.message}');
      rethrow;
    } catch (e) {
      developer.log('❌ ERROR: $e', name: _logTag, error: e);
      print('$_logTag: ❌ ERROR: $e');
      rethrow;
    }
  }

  // ✅ BUSCAR PRODUCTOS CON TRY-CATCH Y LOGS
  Future<List<Product>> searchProducts(String query) async {
    try {
      if (query.trim().isEmpty) return [];

      developer.log('🔎 Buscando: "$query"', name: _logTag);
      print('$_logTag: 🔎 Buscando "$query"');

      final response = await supabase
          .from('productos')
          .select('sku, nombre, imagen_url, precio')
          .ilike('nombre', '%$query%')
          .order('nombre', ascending: true);

      final results = (response as List)
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();

      developer.log(
        '✅ Búsqueda: ${results.length} resultados',
        name: _logTag,
      );
      print('$_logTag: ✅ ${results.length} resultados encontrados');

      return results;
    } on PostgrestException catch (e) {
      developer.log('❌ ERROR en búsqueda: ${e.message}', name: _logTag, error: e);
      print('$_logTag: ❌ ERROR: ${e.message}');
      rethrow;
    } catch (e) {
      developer.log('❌ ERROR: $e', name: _logTag, error: e);
      print('$_logTag: ❌ ERROR: $e');
      rethrow;
    }
  }

  // ✅ PRUEBA DE CONEXIÓN
  Future<bool> testConnection() async {
    try {
      developer.log('🧪 Probando conexión...', name: _logTag);
      print('$_logTag: 🧪 Probando conexión...');

      await supabase.from('productos').select().limit(1);

      developer.log('✅ CONEXIÓN EXITOSA', name: _logTag);
      print('$_logTag: ✅ CONEXIÓN EXITOSA');
      return true;
    } catch (e) {
      developer.log('❌ ERROR DE CONEXIÓN: $e', name: _logTag, error: e);
      print('$_logTag: ❌ ERROR: $e');
      return false;
    }
  }
}
