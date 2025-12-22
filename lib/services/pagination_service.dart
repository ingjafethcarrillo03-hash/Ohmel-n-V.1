import 'dart:developer' as developer;
import '../models/product.dart';
import 'supabase_service.dart';

/// 🎯 SERVICIO DE PAGINACIÓN PROFESIONAL
/// Soporta 3 tipos de carga:
/// 1. PAGINACIÓN TRADICIONAL (1, 2, 3... con botones)
/// 2. SCROLL INFINITO (Auto-carga al llegar al final)
/// 3. LOAD MORE (Botón "Cargar más")

class PaginationService {
  final SupabaseService _supabaseService = SupabaseService();
  static const String _logTag = '📋 PaginationService';

  // Constantes
  static const int DEFAULT_PAGE_SIZE = 50;
  static const int MAX_PAGE_SIZE = 100;

  // Cache para evitar consultas repetidas
  final Map<int, List<Product>> _cache = {};
  int _totalRecords = 0;
  bool _isCached = false;

  /// 💁 PAGINACIÓN TRADICIONAL
  /// El usuario elige qué página quiere (Amazon, eBay)
  Future<PaginationResult> getPage({
    required int page,
    int pageSize = DEFAULT_PAGE_SIZE,
  }) async {
    try {
      _validatePageSize(pageSize);
      final offset = (page - 1) * pageSize;

      developer.log(
        '💁 Página tradicional: $page (offset: $offset, size: $pageSize)',
        name: _logTag,
      );
      print('$_logTag: 💁 Cargando página $page...');

      final response = await _supabaseService.getProductsPaginated(
        page: page,
        pageSize: pageSize,
      );

      final items = response['items'] as List<Product>;
      _cache[page] = items;

      if (!_isCached) {
        _isCached = true;
        developer.log(🟡 Cache habilitado', name: _logTag);
      }

      return PaginationResult(
        items: items,
        currentPage: page,
        pageSize: pageSize,
        hasMore: response['hasMore'] ?? false,
        totalRecords: _totalRecords,
      );
    } on Exception catch (e) {
      developer.log('❌ ERROR en página $page: $e', name: _logTag, error: e);
      print('$_logTag: ❌ ERROR: $e');
      rethrow;
    }
  }

  /// ♾ SCROLL INFINITO
  /// Carga automática cuando el usuario llega al final (Instagram, TikTok)
  Future<InfiniteScrollResult> loadNextPage({
    int pageSize = DEFAULT_PAGE_SIZE,
    required int currentPage,
  }) async {
    try {
      _validatePageSize(pageSize);
      final nextPage = currentPage + 1;

      developer.log(
        '♾ Scroll infinito: Cargando página $nextPage...',
        name: _logTag,
      );
      print('$_logTag: ♾ Cargando más elementos...');

      final response = await _supabaseService.getProductsPaginated(
        page: nextPage,
        pageSize: pageSize,
      );

      final newItems = response['items'] as List<Product>;
      _cache[nextPage] = newItems;

      return InfiniteScrollResult(
        newItems: newItems,
        nextPage: nextPage,
        hasMorePages: response['hasMore'] ?? false,
        itemsLoaded: newItems.length,
      );
    } on Exception catch (e) {
      developer.log(
        '❌ ERROR en scroll infinito: $e',
        name: _logTag,
        error: e,
      );
      print('$_logTag: ❌ ERROR: $e');
      rethrow;
    }
  }

  /// 🗕 LOAD MORE
  /// Botón "Cargar más" al final (Reddit, Medium)
  Future<LoadMoreResult> loadMore({
    int pageSize = DEFAULT_PAGE_SIZE,
    required int currentPage,
    required List<Product> currentItems,
  }) async {
    try {
      _validatePageSize(pageSize);
      final nextPage = currentPage + 1;

      developer.log(
        '🗕 Load More: Página $nextPage (items actuales: ${currentItems.length})',
        name: _logTag,
      );
      print('$_logTag: 🗕 Cargando más productos...');

      final response = await _supabaseService.getProductsPaginated(
        page: nextPage,
        pageSize: pageSize,
      );

      final newItems = response['items'] as List<Product>;
      _cache[nextPage] = newItems;

      final allItems = [...currentItems, ...newItems];

      return LoadMoreResult(
        allItems: allItems,
        newItemsCount: newItems.length,
        totalLoadedCount: allItems.length,
        hasMore: response['hasMore'] ?? false,
        nextPage: nextPage,
      );
    } on Exception catch (e) {
      developer.log(
        '❌ ERROR en load more: $e',
        name: _logTag,
        error: e,
      );
      print('$_logTag: ❌ ERROR: $e');
      rethrow;
    }
  }

  /// 📄 OBTENER DEL CACHE (Si ya fue cargado)
  List<Product>? getFromCache(int page) {
    if (_cache.containsKey(page)) {
      developer.log('🟢 Cache HIT - Página $page', name: _logTag);
      print('$_logTag: 🟢 Usando cache para página $page');
      return _cache[page];
    }
    return null;
  }

  /// 🗙 LIMPIAR CACHE
  void clearCache() {
    _cache.clear();
    _isCached = false;
    developer.log('🗑 Cache limpiado', name: _logTag);
    print('$_logTag: 🗑 Cache limpiado');
  }

  /// 🔍 BUSCAR CON PAGINACIÓN
  Future<SearchResult> searchPaginated({
    required String query,
    int pageSize = DEFAULT_PAGE_SIZE,
  }) async {
    try {
      developer.log('🔍 Búsqueda: "$query" (pageSize: $pageSize)', name: _logTag);
      print('$_logTag: 🔍 Buscando "$query"...');

      final results = await _supabaseService.searchProducts(query);

      // Paginar resultados
      final pages = (results.length / pageSize).ceil();
      final paginatedResults = <int, List<Product>>{};

      for (int i = 0; i < pages; i++) {
        final start = i * pageSize;
        final end = (start + pageSize).clamp(0, results.length);
        paginatedResults[i + 1] = results.sublist(start, end);
      }

      developer.log(
        '✅ Búsqueda: ${results.length} resultados en $pages páginas',
        name: _logTag,
      );
      print('$_logTag: ✅ ${results.length} resultados encontrados');

      return SearchResult(
        allResults: results,
        paginatedResults: paginatedResults,
        totalResults: results.length,
        totalPages: pages,
      );
    } on Exception catch (e) {
      developer.log(
        '❌ ERROR en búsqueda: $e',
        name: _logTag,
        error: e,
      );
      print('$_logTag: ❌ ERROR: $e');
      rethrow;
    }
  }

  void _validatePageSize(int pageSize) {
    if (pageSize > MAX_PAGE_SIZE) {
      developer.log(
        '⚠ pageSize ($pageSize) excede máximo. Usando $MAX_PAGE_SIZE',
        name: _logTag,
      );
    }
  }
}

/// 📊 RESULTADOS
class PaginationResult {
  final List<Product> items;
  final int currentPage;
  final int pageSize;
  final bool hasMore;
  final int totalRecords;

  PaginationResult({
    required this.items,
    required this.currentPage,
    required this.pageSize,
    required this.hasMore,
    required this.totalRecords,
  });
}

class InfiniteScrollResult {
  final List<Product> newItems;
  final int nextPage;
  final bool hasMorePages;
  final int itemsLoaded;

  InfiniteScrollResult({
    required this.newItems,
    required this.nextPage,
    required this.hasMorePages,
    required this.itemsLoaded,
  });
}

class LoadMoreResult {
  final List<Product> allItems;
  final int newItemsCount;
  final int totalLoadedCount;
  final bool hasMore;
  final int nextPage;

  LoadMoreResult({
    required this.allItems,
    required this.newItemsCount,
    required this.totalLoadedCount,
    required this.hasMore,
    required this.nextPage,
  });
}

class SearchResult {
  final List<Product> allResults;
  final Map<int, List<Product>> paginatedResults;
  final int totalResults;
  final int totalPages;

  SearchResult({
    required this.allResults,
    required this.paginatedResults,
    required this.totalResults,
    required this.totalPages,
  });
}
