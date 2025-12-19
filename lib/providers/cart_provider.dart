import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/producto.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  int get totalQuantity {
    int total = 0;
    _items.forEach((key, item) {
      total += item.cantidad;
    });
    return total;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, item) {
      total += item.subtotal;
    });
    return total;
  }

  void addItem(Producto producto) {
    if (_items.containsKey(producto.sku)) {
      _items.update(
        producto.sku,
        (existingItem) => CartItem(
          producto: existingItem.producto,
          cantidad: existingItem.cantidad + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        producto.sku,
        () => CartItem(
          producto: producto,
          cantidad: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String sku) {
    _items.remove(sku);
    notifyListeners();
  }

  void removeSingleItem(String sku) {
    if (!_items.containsKey(sku)) return;

    if (_items[sku]!.cantidad > 1) {
      _items.update(
        sku,
        (existingItem) => CartItem(
          producto: existingItem.producto,
          cantidad: existingItem.cantidad - 1,
        ),
      );
    } else {
      _items.remove(sku);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
