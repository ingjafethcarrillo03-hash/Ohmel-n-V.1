# 📋 Código: FutureBuilder y GridView.builder

## 🎯 home_screen.dart (Estado Local - Sin FutureBuilder)

Este archivo usa estado local (`_isLoading`, `_productos`) en lugar de FutureBuilder.

### GridView.builder (líneas 508-576)

```dart
RefreshIndicator(
  onRefresh: _loadProducts,
  child: GridView.builder(
    padding: const EdgeInsets.all(12),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.65,
    ),
    itemCount: _productos.length,
    itemBuilder: (context, index) {
      final producto = _productos[index];
      return ProductCard(
        product: producto,
        onAddToCart: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${producto.nombre} agregado al carrito',
              ),
              backgroundColor: Colors.green,
            ),
          );
        },
        onViewDetails: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(producto.nombre),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (producto.imagenUrl != null)
                      CachedNetworkImage(
                        imageUrl: _supabaseService.getOptimizedImageUrl(producto.imagenUrl),
                        height: 200,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 48,
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    Text('SKU: ${producto.sku}'),
                    Text('Precio: \$${producto.precio.toStringAsFixed(2)}'),
                    Text('Stock: ${producto.cantidad}'),
                    Text('Tienda ID: ${producto.tiendaId}'),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cerrar'),
                ),
              ],
            ),
          );
        },
      );
    },
  ),
)
```

### Manejo de Estados (líneas 432-505)

```dart
child: _isLoading
    ? const Center(
        child: CircularProgressIndicator(),
      )
    : _errorMessage != null
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _loadProducts,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          )
        : _productos.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No hay productos disponibles',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'En un radio de ${_distanceFilter.toStringAsFixed(1)} Km',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => _mostrarLogs(context),
                      icon: const Icon(Icons.bug_report),
                      label: const Text('Ver Logs de debug'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: _loadProducts,
                child: GridView.builder(...),
              )
```

---

## 🎯 home_screen_supabase.dart (Con FutureBuilder)

Este archivo SÍ usa FutureBuilder.

### FutureBuilder Completo (líneas 31-101)

```dart
FutureBuilder<List<Product>>(
  future: _productsFuture,
  builder: (context, snapshot) {
    // Cargando
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // Error
    if (snapshot.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red),
            SizedBox(height: 16),
            Text('Error: ${snapshot.error}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _productsFuture = supabaseService.getAllProducts();
                });
              },
              child: Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    // Sin datos
    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(
        child: Text('No hay productos disponibles'),
      );
    }

    final products = snapshot.data!;

    // Grid de productos
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.65,  // IMPORTANTE: ajustado para mostrar precio
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCardSupabase(
          product: products[index],
          onTap: () {
            // Acción al tocar la tarjeta
            final price = products[index].price != null
                ? '\$${products[index].price!.toStringAsFixed(2)}'
                : 'N/A';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${products[index].nombre} - $price'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        );
      },
    );
  },
)
```

### GridView.builder dentro del FutureBuilder (líneas 74-100)

```dart
GridView.builder(
  padding: EdgeInsets.all(8),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
    childAspectRatio: 0.65,  // IMPORTANTE: ajustado para mostrar precio
  ),
  itemCount: products.length,
  itemBuilder: (context, index) {
    return ProductCardSupabase(
      product: products[index],
      onTap: () {
        // Acción al tocar la tarjeta
        final price = products[index].price != null
            ? '\$${products[index].price!.toStringAsFixed(2)}'
            : 'N/A';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${products[index].nombre} - $price'),
            duration: Duration(seconds: 2),
          ),
        );
      },
    );
  },
)
```

### Inicialización del Future (líneas 17-20)

```dart
@override
void initState() {
  super.initState();
  _productsFuture = supabaseService.getAllProducts();
}
```

---

## 📊 Comparación de Enfoques

### home_screen.dart (Estado Local)
- ✅ Más control sobre el estado
- ✅ Mejor para lógica compleja (geolocalización, filtros)
- ✅ Manejo manual de loading/error
- ❌ Más código boilerplate

### home_screen_supabase.dart (FutureBuilder)
- ✅ Código más limpio y declarativo
- ✅ Manejo automático de estados
- ✅ Ideal para operaciones simples
- ❌ Menos control sobre el flujo

---

## 🔧 Configuración del GridView

### Parámetros Importantes

```dart
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,              // 2 columnas
  crossAxisSpacing: 8,            // Espacio horizontal entre columnas
  mainAxisSpacing: 8,             // Espacio vertical entre filas
  childAspectRatio: 0.65,         // Relación ancho/alto (más alto = más pequeño)
)
```

**childAspectRatio:**
- `0.65` = Tarjetas más altas (mejor para mostrar precio)
- `0.7` = Tarjetas más anchas
- `0.8` = Tarjetas muy anchas

---

## 💡 Ejemplo Completo con FutureBuilder

Si quieres convertir `home_screen.dart` para usar FutureBuilder:

```dart
class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Producto>> _productsFuture;
  final ProductService _productService = ProductService(AppLogger());
  
  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProductsFuture();
  }
  
  Future<List<Producto>> _loadProductsFuture() async {
    // Tu lógica de carga aquí
    final productsByStore = await _productService.getProductsByStores();
    final productos = <Producto>[];
    for (var entry in productsByStore.entries) {
      productos.addAll(entry.value);
    }
    return productos;
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Producto>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay productos'));
        }
        
        final productos = snapshot.data!;
        
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemCount: productos.length,
          itemBuilder: (context, index) {
            return ProductCard(product: productos[index]);
          },
        );
      },
    );
  }
}
```

---

## ✅ Resumen

**home_screen.dart:**
- Usa estado local (`_isLoading`, `_productos`)
- GridView.builder en líneas 508-576
- Manejo manual de estados

**home_screen_supabase.dart:**
- Usa FutureBuilder
- GridView.builder dentro del FutureBuilder (líneas 74-100)
- Manejo automático de estados

