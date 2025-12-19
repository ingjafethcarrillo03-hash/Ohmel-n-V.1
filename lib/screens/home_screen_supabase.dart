import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/supabase_service.dart';
import '../widgets/product_card_supabase.dart';

class HomeScreenSupabase extends StatefulWidget {
  const HomeScreenSupabase({super.key});

  @override
  State<HomeScreenSupabase> createState() => _HomeScreenSupabaseState();
}

class _HomeScreenSupabaseState extends State<HomeScreenSupabase> {
  late Future<List<Product>> _productsFuture;
  final supabaseService = SupabaseService();

  @override
  void initState() {
    super.initState();
    _productsFuture = supabaseService.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OhMelón - Marketplace'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<Product>>(
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
      ),
    );
  }
}

