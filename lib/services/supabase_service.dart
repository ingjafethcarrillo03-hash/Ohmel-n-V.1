import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  // Obtener todos los productos
  Future<List<Product>> getProducts() async {
    try {
      final response = await supabase
          .from('productos')
          .select('sku, nombre, imagen_url, precio')  // aquí 'precio'
          .order('nombre', ascending: true)
          .limit(100);

      return (response as List)
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error obteniendo productos: $e');
      rethrow;
    }
  }

  // Obtener TODOS los productos con precio (método mejorado)
  // Intenta diferentes nombres de tabla automáticamente
  Future<List<Product>> getAllProducts() async {
    // Lista de posibles nombres de tabla/vista
    final posiblesTablas = [
      'productos',
      'productos_soriana',
      'Productos_Soriana',
      'productos_soriana_view',
    ];

    for (final nombreTabla in posiblesTablas) {
      try {
        print('🔍 Intentando tabla: $nombreTabla');
        
        final response = await supabase
            .from(nombreTabla)
            .select('sku, nombre, imagen_url, precio')
            .order('nombre', ascending: true)
            .limit(100);

        print('✅ Respuesta recibida de tabla: $nombreTabla');
        print('📊 Tipo de respuesta: ${response.runtimeType}');
        print('📊 Longitud de respuesta: ${(response as List).length}');
        
        if ((response as List).isEmpty) {
          print('⚠️ Tabla $nombreTabla existe pero está vacía');
          continue; // Intentar siguiente tabla
        }
        
        final products = (response as List)
            .map((item) {
              print('📦 Item recibido: $item');
              return Product.fromJson(item as Map<String, dynamic>);
            })
            .toList();
        
        print('✅ Productos parseados desde $nombreTabla: ${products.length}');
        return products;
      } catch (e, stackTrace) {
        print('❌ Error con tabla $nombreTabla: $e');
        print('Stack trace: $stackTrace');
        // Continuar con siguiente tabla
        continue;
      }
    }
    
    // Si ninguna tabla funcionó, intentar sin especificar columnas
    print('🔄 Intentando obtener todas las columnas de "productos"...');
    try {
      final response = await supabase
          .from('productos')
          .select()  // Obtener todas las columnas
          .limit(5);  // Solo 5 para ver estructura
      
      print('📋 Estructura de datos recibida: $response');
      if ((response as List).isNotEmpty) {
        print('📋 Primer registro: ${(response as List).first}');
      }
    } catch (e) {
      print('❌ Error obteniendo estructura: $e');
    }
    
    print('⚠️ No se encontraron productos en ninguna tabla');
    return [];
  }

  // Filtrar por rango de precio
  Future<List<Product>> getByPriceRange(double minPrice, double maxPrice) async {
    try {
      final response = await supabase
          .from('productos')
          .select('sku, nombre, imagen_url, precio')  // aquí 'precio'
          .gte('precio', minPrice)  // aquí 'precio'
          .lte('precio', maxPrice)  // aquí 'precio'
          .order('precio', ascending: true);  // aquí 'precio'

      return (response as List)
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error filtrando por precio: $e');
      return [];
    }
  }

  // Buscar productos por nombre
  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await supabase
          .from('productos')
          .select('sku, nombre, imagen_url, precio')  // aquí 'precio'
          .ilike('nombre', '%$query%')
          .order('nombre', ascending: true);

      return (response as List)
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error buscando productos: $e');
      return [];
    }
  }

  // Obtener un producto por SKU
  Future<Product?> getProductBySku(String sku) async {
    try {
      final response = await supabase
          .from('productos')
          .select()
          .eq('sku', sku)
          .single();

      return Product.fromJson(response);
    } catch (e) {
      print('Producto no encontrado: $e');
      return null;
    }
  }

  // Agregar imagen optimizada de R2
  String getOptimizedImageUrl(String? imagenUrl) {
    if (imagenUrl == null || imagenUrl.isEmpty) return '';
    
    // Si ya es una URL de R2, agregar parámetros de optimización
    if (imagenUrl.contains('r2.cloudflarestorage.com')) {
      return '$imagenUrl?format=auto&width=500&quality=80';
    }
    
    return imagenUrl;
  }
}
