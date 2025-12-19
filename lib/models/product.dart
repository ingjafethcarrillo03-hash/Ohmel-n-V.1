class Product {
  final String sku;
  final String nombre;
  final String? imagenUrl;
  final double? price;  // NUEVO CAMPO

  Product({
    required this.sku,
    required this.nombre,
    this.imagenUrl,
    this.price,  // NUEVO CAMPO
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      sku: json['sku'] as String,
      nombre: json['nombre'] as String,
      imagenUrl: json['imagen_url'] as String?,
      // OJO: la columna se llama 'precio' en BD
      price: (json['precio'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'sku': sku,
    'nombre': nombre,
    'imagen_url': imagenUrl,
    'price': price,
  };
}

