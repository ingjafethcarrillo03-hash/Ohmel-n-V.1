import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../services/supabase_service.dart';
import '../widgets/product_card.dart';
import '../utils/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _productService = ProductService(AppLogger(), supabaseService: SupabaseService());
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    print('HomeScreen initState: Inicializando productos...');
    _productsFuture = _productService.getAllProducts();
    _productsFuture.then((products) {
      print('HomeScreen: Productos cargados en initState: ${products.length}');
    }).catchError((error) {
      print('HomeScreen: Error en initState: $error');
    });
  }

  Future<void> _reloadProducts() async {
    setState(() {
      _productsFuture = _productService.getAllProducts();
    });
    await _productsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),
      body: RefreshIndicator(
        onRefresh: _reloadProducts,
        child: FutureBuilder<List<Product>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              print('ERROR FUTUREBUILDER: ${snapshot.error}');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error: ${snapshot.error}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _reloadProducts,
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              );
            }

            print('snapshot.hasData = ${snapshot.hasData}');
            print('snapshot.data = ${snapshot.data}');

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              print('Productos recibidos (length): ${snapshot.data?.length}');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'No hay productos disponibles',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Productos recibidos: ${snapshot.data?.length ?? 0}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _reloadProducts,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        'Revisa la consola para ver los logs de debugging.\n'
                        'Si ves "response length: 0", verifica el nombre de la tabla en Supabase.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              );
            }

            final products = snapshot.data!;

            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.65,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final producto = products[index];
                return ProductCard(
                  product: producto,
                  onTap: () {
                    final price = producto.price != null
                        ? '\$${producto.price!.toStringAsFixed(2)}'
                        : 'N/A';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${producto.nombre} - $price'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
