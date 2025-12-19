class Producto {
  final String sku;
  final String nombre;
  final double precio;
  final int cantidad;
  final int tiendaId;
  final String? imagenUrl;
  final String? marca;
  final String? calidad;

  Producto({
    required this.sku,
    required this.nombre,
    required this.precio,
    this.cantidad = 1,
    required this.tiendaId,
    this.imagenUrl,
    this.marca,
    this.calidad,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      sku: json['sku']?.toString() ?? '',
      nombre: json['nombre']?.toString() ?? '',
      precio: json['precio'] != null ? (json['precio'] as num).toDouble() : 0.0,
      cantidad: json['cantidad'] != null ? (json['cantidad'] as num).toInt() : 1,
      tiendaId: json['tienda_id'] as int? ?? json['tiendaId'] as int? ?? 1,
      imagenUrl: json['imagen_url']?.toString() ?? json['imagenUrl']?.toString(),
      marca: json['marca']?.toString(),
      calidad: json['calidad']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'sku': sku,
    'nombre': nombre,
    'precio': precio,
    'cantidad': cantidad,
    'tienda_id': tiendaId,
    'imagen_url': imagenUrl,
    'marca': marca,
    'calidad': calidad,
  };

  @override
  String toString() =>
      'Producto(sku: $sku, nombre: $nombre, precio: $precio, tiendaId: $tiendaId)';
}
