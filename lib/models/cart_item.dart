import 'producto.dart';

class CartItem {
  final Producto producto;
  int cantidad;

  CartItem({
    required this.producto,
    this.cantidad = 1,
  });

  double get subtotal => producto.precio * cantidad;

  Map<String, dynamic> toJson() => {
    'producto': producto.toJson(),
    'cantidad': cantidad,
    'subtotal': subtotal,
  };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      producto: Producto.fromJson(json['producto']),
      cantidad: json['cantidad'] ?? 1,
    );
  }

  @override
  String toString() => 'CartItem(producto: ${producto.nombre}, cantidad: $cantidad, subtotal: \$${subtotal.toStringAsFixed(2)})';
}
