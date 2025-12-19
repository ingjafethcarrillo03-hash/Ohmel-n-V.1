import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';
import '../services/supabase_service.dart';

class ProductCardSupabase extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCardSupabase({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Formato de precio
    String priceText = product.price != null
        ? '\$${(product.price!.toStringAsFixed(2))}'
        : 'N/A';

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGEN DEL PRODUCTO
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Container(
                height: 180,
                width: double.infinity,
                color: Colors.grey[200],
                child: _buildImageWidget(),
              ),
            ),
            // INFORMACIÓN (40% de la tarjeta)
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NOMBRE DEL PRODUCTO
                    Text(
                      product.nombre,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // PRECIO
                    Text(
                      priceText,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const Spacer(),
                    // BOTÓN AGREGAR
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: onTap,
                        icon: const Icon(Icons.shopping_cart, size: 16),
                        label: const Text('Agregar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Construye el widget de imagen con manejo de errores
  Widget _buildImageWidget() {
    final imageUrl = _getValidImageUrl();

    if (imageUrl == null || imageUrl.isEmpty) {
      return _buildPlaceholder('Sin imagen');
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 180,
      placeholder: (context, url) => Container(
        color: Colors.grey[200],
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ),
      ),
      errorWidget: (context, url, error) {
        print('❌ Error cargando imagen: $url\nError: $error');
        return _buildPlaceholder('Error en imagen');
      },
    );
  }

  /// Obtiene una URL válida de imagen
  /// Maneja NULL, cadenas vacías, y URLs de diferentes proveedores
  String? _getValidImageUrl() {
    if (product.imagenUrl == null || product.imagenUrl!.isEmpty) {
      return null;
    }

    String url = product.imagenUrl!.trim();

    // Si ya es una URL completa (http/https), retornarla
    if (url.startsWith('http://') || url.startsWith('https://')) {
      // Si es de Cloudflare R2, agregar parámetros de optimización
      if (url.contains('r2.cloudflarestorage.com') ||
          url.contains('cloudflare')) {
        // Cloudflare R2 soporta query params
        if (!url.contains('?')) {
          return '$url?format=auto&quality=80';
        }
      }
      return url;
    }

    // Si es una ruta relativa, construir URL de Supabase
    // Ejemplo: 'products/coca-cola.jpg' -> URL completa
    return 'https://gwapxyguzvhecorqgjeh.supabase.co/storage/v1/object/public/$url';
  }

  /// Widget placeholder para cuando no hay imagen
  Widget _buildPlaceholder(String message) {
    return Container(
      color: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 48,
            color: Colors.grey[500],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
