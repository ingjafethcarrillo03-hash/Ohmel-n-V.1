import '../models/producto.dart';
import '../models/product.dart';
import '../utils/logger.dart';
import 'supabase_service.dart';

class ProductService {
  final AppLogger logger;
  final SupabaseService? _supabaseService;

  ProductService(this.logger, {SupabaseService? supabaseService})
      : _supabaseService = supabaseService;

  // Mapa: id de tienda -> lista de productos de esa tienda
  // 200 productos hardcodeados distribuidos en 8 tiendas (25 productos cada una)
  Map<int, List<Producto>> getProductosPredeterminados() {
    return {
      // =======================
      // Tienda 1 - PUEBLA HERMANOS SERDAN
      // =======================
      1: [
        Producto(sku: '1000290', nombre: 'Margarina Princess con Sal', precio: 29.90, cantidad: 45, tiendaId: 1, marca: 'Princess', calidad: 'Premium'),
        Producto(sku: '1001405', nombre: 'Agua Mineral Topo Chico 1.5L', precio: 15.99, cantidad: 60, tiendaId: 1, marca: 'Topo Chico', calidad: 'Premium'),
        Producto(sku: '1001706', nombre: 'Concentrado para preparar Horchata', precio: 24.99, cantidad: 35, tiendaId: 1, marca: 'Tradicional', calidad: 'Estándar'),
        Producto(sku: '1001707', nombre: 'Chocolate para Taza', precio: 34.99, cantidad: 40, tiendaId: 1, marca: 'Abuelita', calidad: 'Premium'),
        Producto(sku: '1002081', nombre: 'Chocolate Lenguas de Gato', precio: 18.99, cantidad: 50, tiendaId: 1, marca: 'Picard', calidad: 'Estándar'),
        Producto(sku: '1002717', nombre: 'Salchicha Viena San Rafael', precio: 45.99, cantidad: 30, tiendaId: 1, marca: 'San Rafael', calidad: 'Premium'),
        Producto(sku: '1002777', nombre: "Chocolate Hersheys Cookies 'N' Creme", precio: 19.99, cantidad: 55, tiendaId: 1, marca: 'Hersheys', calidad: 'Estándar'),
        Producto(sku: '1002778', nombre: 'Chocolate Hersheys Con Leche y Almendras', precio: 21.99, cantidad: 42, tiendaId: 1, marca: 'Hersheys', calidad: 'Premium'),
        Producto(sku: '1003434', nombre: 'Té Infusionate de Salvia', precio: 32.99, cantidad: 28, tiendaId: 1, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1003531', nombre: 'Té de Boldo Infusionate', precio: 28.99, cantidad: 32, tiendaId: 1, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1003569', nombre: 'Salchicha para Asar Chimex Cerdo', precio: 52.99, cantidad: 25, tiendaId: 1, marca: 'Chimex', calidad: 'Premium'),
        Producto(sku: '1003814', nombre: 'Té de Cola de Caballo Infusionate', precio: 26.99, cantidad: 38, tiendaId: 1, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004093', nombre: 'Ensalada Mixta Mr Lucky', precio: 39.99, cantidad: 20, tiendaId: 1, marca: 'Mr Lucky', calidad: 'Premium'),
        Producto(sku: '1004096', nombre: 'Ensalada César Mr Lucky', precio: 42.99, cantidad: 18, tiendaId: 1, marca: 'Mr Lucky', calidad: 'Estándar'),
        Producto(sku: '1004366', nombre: 'Té de Estafiate Infusionate', precio: 25.99, cantidad: 40, tiendaId: 1, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004370', nombre: 'Té de Eucalipto Infusionate', precio: 26.99, cantidad: 35, tiendaId: 1, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004386', nombre: 'Té de Hoja Sen Infusionate', precio: 27.99, cantidad: 30, tiendaId: 1, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004410', nombre: 'Té de Menta Infusionate', precio: 25.99, cantidad: 45, tiendaId: 1, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004425', nombre: 'Té de Palo Azul Infusionate', precio: 28.99, cantidad: 33, tiendaId: 1, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004456', nombre: 'Leche Evaporada La Lechera', precio: 17.99, cantidad: 50, tiendaId: 1, marca: 'La Lechera', calidad: 'Estándar'),
        Producto(sku: '1004789', nombre: 'Jamón de Pavo Deli Gourmet', precio: 78.99, cantidad: 15, tiendaId: 1, marca: 'Deli Gourmet', calidad: 'Premium'),
        Producto(sku: '1005123', nombre: 'Queso Fresco Oaxaca', precio: 65.99, cantidad: 22, tiendaId: 1, marca: 'Quesera', calidad: 'Premium'),
        Producto(sku: '1005456', nombre: 'Pan Molde Bimbo Blanco', precio: 22.99, cantidad: 48, tiendaId: 1, marca: 'Bimbo', calidad: 'Estándar'),
        Producto(sku: '1005789', nombre: 'Cereales Corn Flakes', precio: 45.99, cantidad: 36, tiendaId: 1, marca: 'Kelloggs', calidad: 'Premium'),
        Producto(sku: '1006012', nombre: 'Café Molido Premium', precio: 89.99, cantidad: 20, tiendaId: 1, marca: 'Café Tradicional', calidad: 'Premium'),
      ],

      // =======================
      // Tienda 6 - PUEBLA PLAZA SAN PEDRO
      // =======================
      6: [
        Producto(sku: '1000290', nombre: 'Margarina Princess con Sal', precio: 29.90, cantidad: 42, tiendaId: 6, marca: 'Princess', calidad: 'Premium'),
        Producto(sku: '1001405', nombre: 'Agua Mineral Topo Chico 1.5L', precio: 15.99, cantidad: 58, tiendaId: 6, marca: 'Topo Chico', calidad: 'Premium'),
        Producto(sku: '1001706', nombre: 'Concentrado para preparar Horchata', precio: 24.99, cantidad: 33, tiendaId: 6, marca: 'Tradicional', calidad: 'Estándar'),
        Producto(sku: '1001707', nombre: 'Chocolate para Taza', precio: 34.99, cantidad: 38, tiendaId: 6, marca: 'Abuelita', calidad: 'Premium'),
        Producto(sku: '1002081', nombre: 'Chocolate Lenguas de Gato', precio: 18.99, cantidad: 48, tiendaId: 6, marca: 'Picard', calidad: 'Estándar'),
        Producto(sku: '1002717', nombre: 'Salchicha Viena San Rafael', precio: 45.99, cantidad: 28, tiendaId: 6, marca: 'San Rafael', calidad: 'Premium'),
        Producto(sku: '1002777', nombre: "Chocolate Hersheys Cookies 'N' Creme", precio: 19.99, cantidad: 52, tiendaId: 6, marca: 'Hersheys', calidad: 'Estándar'),
        Producto(sku: '1002778', nombre: 'Chocolate Hersheys Con Leche y Almendras', precio: 21.99, cantidad: 40, tiendaId: 6, marca: 'Hersheys', calidad: 'Premium'),
        Producto(sku: '1003434', nombre: 'Té Infusionate de Salvia', precio: 32.99, cantidad: 26, tiendaId: 6, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1003531', nombre: 'Té de Boldo Infusionate', precio: 28.99, cantidad: 30, tiendaId: 6, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1003569', nombre: 'Salchicha para Asar Chimex Cerdo', precio: 52.99, cantidad: 23, tiendaId: 6, marca: 'Chimex', calidad: 'Premium'),
        Producto(sku: '1003814', nombre: 'Té de Cola de Caballo Infusionate', precio: 26.99, cantidad: 36, tiendaId: 6, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004093', nombre: 'Ensalada Mixta Mr Lucky', precio: 39.99, cantidad: 18, tiendaId: 6, marca: 'Mr Lucky', calidad: 'Premium'),
        Producto(sku: '1004096', nombre: 'Ensalada César Mr Lucky', precio: 42.99, cantidad: 16, tiendaId: 6, marca: 'Mr Lucky', calidad: 'Estándar'),
        Producto(sku: '1004366', nombre: 'Té de Estafiate Infusionate', precio: 25.99, cantidad: 38, tiendaId: 6, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004370', nombre: 'Té de Eucalipto Infusionate', precio: 26.99, cantidad: 33, tiendaId: 6, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004386', nombre: 'Té de Hoja Sen Infusionate', precio: 27.99, cantidad: 28, tiendaId: 6, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004410', nombre: 'Té de Menta Infusionate', precio: 25.99, cantidad: 43, tiendaId: 6, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004425', nombre: 'Té de Palo Azul Infusionate', precio: 28.99, cantidad: 31, tiendaId: 6, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004456', nombre: 'Leche Evaporada La Lechera', precio: 17.99, cantidad: 48, tiendaId: 6, marca: 'La Lechera', calidad: 'Estándar'),
        Producto(sku: '1004789', nombre: 'Jamón de Pavo Deli Gourmet', precio: 78.99, cantidad: 13, tiendaId: 6, marca: 'Deli Gourmet', calidad: 'Premium'),
        Producto(sku: '1005123', nombre: 'Queso Fresco Oaxaca', precio: 65.99, cantidad: 20, tiendaId: 6, marca: 'Quesera', calidad: 'Premium'),
        Producto(sku: '1005456', nombre: 'Pan Molde Bimbo Blanco', precio: 22.99, cantidad: 46, tiendaId: 6, marca: 'Bimbo', calidad: 'Estándar'),
        Producto(sku: '1005789', nombre: 'Cereales Corn Flakes', precio: 45.99, cantidad: 34, tiendaId: 6, marca: 'Kelloggs', calidad: 'Premium'),
        Producto(sku: '1006012', nombre: 'Café Molido Premium', precio: 89.99, cantidad: 18, tiendaId: 6, marca: 'Café Tradicional', calidad: 'Premium'),
      ],

      // =======================
      // Tienda 7 - CAPU
      // =======================
      7: [
        Producto(sku: '1000290', nombre: 'Margarina Princess con Sal', precio: 29.90, cantidad: 40, tiendaId: 7, marca: 'Princess', calidad: 'Premium'),
        Producto(sku: '1001405', nombre: 'Agua Mineral Topo Chico 1.5L', precio: 15.99, cantidad: 55, tiendaId: 7, marca: 'Topo Chico', calidad: 'Premium'),
        Producto(sku: '1001706', nombre: 'Concentrado para preparar Horchata', precio: 24.99, cantidad: 31, tiendaId: 7, marca: 'Tradicional', calidad: 'Estándar'),
        Producto(sku: '1001707', nombre: 'Chocolate para Taza', precio: 34.99, cantidad: 36, tiendaId: 7, marca: 'Abuelita', calidad: 'Premium'),
        Producto(sku: '1002081', nombre: 'Chocolate Lenguas de Gato', precio: 18.99, cantidad: 46, tiendaId: 7, marca: 'Picard', calidad: 'Estándar'),
        Producto(sku: '1002717', nombre: 'Salchicha Viena San Rafael', precio: 45.99, cantidad: 26, tiendaId: 7, marca: 'San Rafael', calidad: 'Premium'),
        Producto(sku: '1002777', nombre: "Chocolate Hersheys Cookies 'N' Creme", precio: 19.99, cantidad: 50, tiendaId: 7, marca: 'Hersheys', calidad: 'Estándar'),
        Producto(sku: '1002778', nombre: 'Chocolate Hersheys Con Leche y Almendras', precio: 21.99, cantidad: 38, tiendaId: 7, marca: 'Hersheys', calidad: 'Premium'),
        Producto(sku: '1003434', nombre: 'Té Infusionate de Salvia', precio: 32.99, cantidad: 24, tiendaId: 7, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1003531', nombre: 'Té de Boldo Infusionate', precio: 28.99, cantidad: 28, tiendaId: 7, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1003569', nombre: 'Salchicha para Asar Chimex Cerdo', precio: 52.99, cantidad: 21, tiendaId: 7, marca: 'Chimex', calidad: 'Premium'),
        Producto(sku: '1003814', nombre: 'Té de Cola de Caballo Infusionate', precio: 26.99, cantidad: 34, tiendaId: 7, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004093', nombre: 'Ensalada Mixta Mr Lucky', precio: 39.99, cantidad: 16, tiendaId: 7, marca: 'Mr Lucky', calidad: 'Premium'),
        Producto(sku: '1004096', nombre: 'Ensalada César Mr Lucky', precio: 42.99, cantidad: 14, tiendaId: 7, marca: 'Mr Lucky', calidad: 'Estándar'),
        Producto(sku: '1004366', nombre: 'Té de Estafiate Infusionate', precio: 25.99, cantidad: 36, tiendaId: 7, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004370', nombre: 'Té de Eucalipto Infusionate', precio: 26.99, cantidad: 31, tiendaId: 7, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004386', nombre: 'Té de Hoja Sen Infusionate', precio: 27.99, cantidad: 26, tiendaId: 7, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004410', nombre: 'Té de Menta Infusionate', precio: 25.99, cantidad: 41, tiendaId: 7, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004425', nombre: 'Té de Palo Azul Infusionate', precio: 28.99, cantidad: 29, tiendaId: 7, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004456', nombre: 'Leche Evaporada La Lechera', precio: 17.99, cantidad: 46, tiendaId: 7, marca: 'La Lechera', calidad: 'Estándar'),
        Producto(sku: '1004789', nombre: 'Jamón de Pavo Deli Gourmet', precio: 78.99, cantidad: 11, tiendaId: 7, marca: 'Deli Gourmet', calidad: 'Premium'),
        Producto(sku: '1005123', nombre: 'Queso Fresco Oaxaca', precio: 65.99, cantidad: 18, tiendaId: 7, marca: 'Quesera', calidad: 'Premium'),
        Producto(sku: '1005456', nombre: 'Pan Molde Bimbo Blanco', precio: 22.99, cantidad: 44, tiendaId: 7, marca: 'Bimbo', calidad: 'Estándar'),
        Producto(sku: '1005789', nombre: 'Cereales Corn Flakes', precio: 45.99, cantidad: 32, tiendaId: 7, marca: 'Kelloggs', calidad: 'Premium'),
        Producto(sku: '1006012', nombre: 'Café Molido Premium', precio: 89.99, cantidad: 16, tiendaId: 7, marca: 'Café Tradicional', calidad: 'Premium'),
      ],

      // =======================
      // Tienda 9 - PUEBLA CENTRO
      // =======================
      9: [
        Producto(sku: '1000290', nombre: 'Margarina Princess con Sal', precio: 29.90, cantidad: 43, tiendaId: 9, marca: 'Princess', calidad: 'Premium'),
        Producto(sku: '1001405', nombre: 'Agua Mineral Topo Chico 1.5L', precio: 15.99, cantidad: 57, tiendaId: 9, marca: 'Topo Chico', calidad: 'Premium'),
        Producto(sku: '1001706', nombre: 'Concentrado para preparar Horchata', precio: 24.99, cantidad: 32, tiendaId: 9, marca: 'Tradicional', calidad: 'Estándar'),
        Producto(sku: '1001707', nombre: 'Chocolate para Taza', precio: 34.99, cantidad: 37, tiendaId: 9, marca: 'Abuelita', calidad: 'Premium'),
        Producto(sku: '1002081', nombre: 'Chocolate Lenguas de Gato', precio: 18.99, cantidad: 47, tiendaId: 9, marca: 'Picard', calidad: 'Estándar'),
        Producto(sku: '1002717', nombre: 'Salchicha Viena San Rafael', precio: 45.99, cantidad: 27, tiendaId: 9, marca: 'San Rafael', calidad: 'Premium'),
        Producto(sku: '1002777', nombre: "Chocolate Hersheys Cookies 'N' Creme", precio: 19.99, cantidad: 51, tiendaId: 9, marca: 'Hersheys', calidad: 'Estándar'),
        Producto(sku: '1002778', nombre: 'Chocolate Hersheys Con Leche y Almendras', precio: 21.99, cantidad: 39, tiendaId: 9, marca: 'Hersheys', calidad: 'Premium'),
        Producto(sku: '1003434', nombre: 'Té Infusionate de Salvia', precio: 32.99, cantidad: 25, tiendaId: 9, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1003531', nombre: 'Té de Boldo Infusionate', precio: 28.99, cantidad: 29, tiendaId: 9, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1003569', nombre: 'Salchicha para Asar Chimex Cerdo', precio: 52.99, cantidad: 22, tiendaId: 9, marca: 'Chimex', calidad: 'Premium'),
        Producto(sku: '1003814', nombre: 'Té de Cola de Caballo Infusionate', precio: 26.99, cantidad: 35, tiendaId: 9, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004093', nombre: 'Ensalada Mixta Mr Lucky', precio: 39.99, cantidad: 17, tiendaId: 9, marca: 'Mr Lucky', calidad: 'Premium'),
        Producto(sku: '1004096', nombre: 'Ensalada César Mr Lucky', precio: 42.99, cantidad: 15, tiendaId: 9, marca: 'Mr Lucky', calidad: 'Estándar'),
        Producto(sku: '1004366', nombre: 'Té de Estafiate Infusionate', precio: 25.99, cantidad: 37, tiendaId: 9, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004370', nombre: 'Té de Eucalipto Infusionate', precio: 26.99, cantidad: 32, tiendaId: 9, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004386', nombre: 'Té de Hoja Sen Infusionate', precio: 27.99, cantidad: 27, tiendaId: 9, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004410', nombre: 'Té de Menta Infusionate', precio: 25.99, cantidad: 42, tiendaId: 9, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004425', nombre: 'Té de Palo Azul Infusionate', precio: 28.99, cantidad: 30, tiendaId: 9, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004456', nombre: 'Leche Evaporada La Lechera', precio: 17.99, cantidad: 47, tiendaId: 9, marca: 'La Lechera', calidad: 'Estándar'),
        Producto(sku: '1004789', nombre: 'Jamón de Pavo Deli Gourmet', precio: 78.99, cantidad: 12, tiendaId: 9, marca: 'Deli Gourmet', calidad: 'Premium'),
        Producto(sku: '1005123', nombre: 'Queso Fresco Oaxaca', precio: 65.99, cantidad: 19, tiendaId: 9, marca: 'Quesera', calidad: 'Premium'),
        Producto(sku: '1005456', nombre: 'Pan Molde Bimbo Blanco', precio: 22.99, cantidad: 45, tiendaId: 9, marca: 'Bimbo', calidad: 'Estándar'),
        Producto(sku: '1005789', nombre: 'Cereales Corn Flakes', precio: 45.99, cantidad: 33, tiendaId: 9, marca: 'Kelloggs', calidad: 'Premium'),
        Producto(sku: '1006012', nombre: 'Café Molido Premium', precio: 89.99, cantidad: 17, tiendaId: 9, marca: 'Café Tradicional', calidad: 'Premium'),
      ],

      // =======================
      // Tienda 11 - PUEBLA ZARAGOZA
      // =======================
      11: [
        Producto(sku: '1000290', nombre: 'Margarina Princess con Sal', precio: 29.90, cantidad: 41, tiendaId: 11, marca: 'Princess', calidad: 'Premium'),
        Producto(sku: '1001405', nombre: 'Agua Mineral Topo Chico 1.5L', precio: 15.99, cantidad: 56, tiendaId: 11, marca: 'Topo Chico', calidad: 'Premium'),
        Producto(sku: '1001706', nombre: 'Concentrado para preparar Horchata', precio: 24.99, cantidad: 30, tiendaId: 11, marca: 'Tradicional', calidad: 'Estándar'),
        Producto(sku: '1001707', nombre: 'Chocolate para Taza', precio: 34.99, cantidad: 35, tiendaId: 11, marca: 'Abuelita', calidad: 'Premium'),
        Producto(sku: '1002081', nombre: 'Chocolate Lenguas de Gato', precio: 18.99, cantidad: 45, tiendaId: 11, marca: 'Picard', calidad: 'Estándar'),
        Producto(sku: '1002717', nombre: 'Salchicha Viena San Rafael', precio: 45.99, cantidad: 25, tiendaId: 11, marca: 'San Rafael', calidad: 'Premium'),
        Producto(sku: '1002777', nombre: "Chocolate Hersheys Cookies 'N' Creme", precio: 19.99, cantidad: 49, tiendaId: 11, marca: 'Hersheys', calidad: 'Estándar'),
        Producto(sku: '1002778', nombre: 'Chocolate Hersheys Con Leche y Almendras', precio: 21.99, cantidad: 37, tiendaId: 11, marca: 'Hersheys', calidad: 'Premium'),
        Producto(sku: '1003434', nombre: 'Té Infusionate de Salvia', precio: 32.99, cantidad: 23, tiendaId: 11, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1003531', nombre: 'Té de Boldo Infusionate', precio: 28.99, cantidad: 27, tiendaId: 11, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1003569', nombre: 'Salchicha para Asar Chimex Cerdo', precio: 52.99, cantidad: 20, tiendaId: 11, marca: 'Chimex', calidad: 'Premium'),
        Producto(sku: '1003814', nombre: 'Té de Cola de Caballo Infusionate', precio: 26.99, cantidad: 33, tiendaId: 11, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004093', nombre: 'Ensalada Mixta Mr Lucky', precio: 39.99, cantidad: 15, tiendaId: 11, marca: 'Mr Lucky', calidad: 'Premium'),
        Producto(sku: '1004096', nombre: 'Ensalada César Mr Lucky', precio: 42.99, cantidad: 13, tiendaId: 11, marca: 'Mr Lucky', calidad: 'Estándar'),
        Producto(sku: '1004366', nombre: 'Té de Estafiate Infusionate', precio: 25.99, cantidad: 35, tiendaId: 11, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004370', nombre: 'Té de Eucalipto Infusionate', precio: 26.99, cantidad: 30, tiendaId: 11, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004386', nombre: 'Té de Hoja Sen Infusionate', precio: 27.99, cantidad: 25, tiendaId: 11, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004410', nombre: 'Té de Menta Infusionate', precio: 25.99, cantidad: 40, tiendaId: 11, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004425', nombre: 'Té de Palo Azul Infusionate', precio: 28.99, cantidad: 28, tiendaId: 11, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004456', nombre: 'Leche Evaporada La Lechera', precio: 17.99, cantidad: 45, tiendaId: 11, marca: 'La Lechera', calidad: 'Estándar'),
        Producto(sku: '1004789', nombre: 'Jamón de Pavo Deli Gourmet', precio: 78.99, cantidad: 10, tiendaId: 11, marca: 'Deli Gourmet', calidad: 'Premium'),
        Producto(sku: '1005123', nombre: 'Queso Fresco Oaxaca', precio: 65.99, cantidad: 17, tiendaId: 11, marca: 'Quesera', calidad: 'Premium'),
        Producto(sku: '1005456', nombre: 'Pan Molde Bimbo Blanco', precio: 22.99, cantidad: 43, tiendaId: 11, marca: 'Bimbo', calidad: 'Estándar'),
        Producto(sku: '1005789', nombre: 'Cereales Corn Flakes', precio: 45.99, cantidad: 31, tiendaId: 11, marca: 'Kelloggs', calidad: 'Premium'),
        Producto(sku: '1006012', nombre: 'Café Molido Premium', precio: 89.99, cantidad: 15, tiendaId: 11, marca: 'Café Tradicional', calidad: 'Premium'),
      ],

      // =======================
      // Tienda 15 - PROVIDENCIA
      // =======================
      15: [
        Producto(sku: '1000290', nombre: 'Margarina Princess con Sal', precio: 29.90, cantidad: 44, tiendaId: 15, marca: 'Princess', calidad: 'Premium'),
        Producto(sku: '1001405', nombre: 'Agua Mineral Topo Chico 1.5L', precio: 15.99, cantidad: 59, tiendaId: 15, marca: 'Topo Chico', calidad: 'Premium'),
        Producto(sku: '1001706', nombre: 'Concentrado para preparar Horchata', precio: 24.99, cantidad: 34, tiendaId: 15, marca: 'Tradicional', calidad: 'Estándar'),
        Producto(sku: '1001707', nombre: 'Chocolate para Taza', precio: 34.99, cantidad: 39, tiendaId: 15, marca: 'Abuelita', calidad: 'Premium'),
        Producto(sku: '1002081', nombre: 'Chocolate Lenguas de Gato', precio: 18.99, cantidad: 49, tiendaId: 15, marca: 'Picard', calidad: 'Estándar'),
        Producto(sku: '1002717', nombre: 'Salchicha Viena San Rafael', precio: 45.99, cantidad: 29, tiendaId: 15, marca: 'San Rafael', calidad: 'Premium'),
        Producto(sku: '1002777', nombre: "Chocolate Hersheys Cookies 'N' Creme", precio: 19.99, cantidad: 53, tiendaId: 15, marca: 'Hersheys', calidad: 'Estándar'),
        Producto(sku: '1002778', nombre: 'Chocolate Hersheys Con Leche y Almendras', precio: 21.99, cantidad: 41, tiendaId: 15, marca: 'Hersheys', calidad: 'Premium'),
        Producto(sku: '1003434', nombre: 'Té Infusionate de Salvia', precio: 32.99, cantidad: 27, tiendaId: 15, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1003531', nombre: 'Té de Boldo Infusionate', precio: 28.99, cantidad: 31, tiendaId: 15, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1003569', nombre: 'Salchicha para Asar Chimex Cerdo', precio: 52.99, cantidad: 24, tiendaId: 15, marca: 'Chimex', calidad: 'Premium'),
        Producto(sku: '1003814', nombre: 'Té de Cola de Caballo Infusionate', precio: 26.99, cantidad: 37, tiendaId: 15, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004093', nombre: 'Ensalada Mixta Mr Lucky', precio: 39.99, cantidad: 19, tiendaId: 15, marca: 'Mr Lucky', calidad: 'Premium'),
        Producto(sku: '1004096', nombre: 'Ensalada César Mr Lucky', precio: 42.99, cantidad: 17, tiendaId: 15, marca: 'Mr Lucky', calidad: 'Estándar'),
        Producto(sku: '1004366', nombre: 'Té de Estafiate Infusionate', precio: 25.99, cantidad: 39, tiendaId: 15, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004370', nombre: 'Té de Eucalipto Infusionate', precio: 26.99, cantidad: 34, tiendaId: 15, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004386', nombre: 'Té de Hoja Sen Infusionate', precio: 27.99, cantidad: 29, tiendaId: 15, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004410', nombre: 'Té de Menta Infusionate', precio: 25.99, cantidad: 44, tiendaId: 15, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004425', nombre: 'Té de Palo Azul Infusionate', precio: 28.99, cantidad: 32, tiendaId: 15, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004456', nombre: 'Leche Evaporada La Lechera', precio: 17.99, cantidad: 49, tiendaId: 15, marca: 'La Lechera', calidad: 'Estándar'),
        Producto(sku: '1004789', nombre: 'Jamón de Pavo Deli Gourmet', precio: 78.99, cantidad: 14, tiendaId: 15, marca: 'Deli Gourmet', calidad: 'Premium'),
        Producto(sku: '1005123', nombre: 'Queso Fresco Oaxaca', precio: 65.99, cantidad: 21, tiendaId: 15, marca: 'Quesera', calidad: 'Premium'),
        Producto(sku: '1005456', nombre: 'Pan Molde Bimbo Blanco', precio: 22.99, cantidad: 47, tiendaId: 15, marca: 'Bimbo', calidad: 'Estándar'),
        Producto(sku: '1005789', nombre: 'Cereales Corn Flakes', precio: 45.99, cantidad: 35, tiendaId: 15, marca: 'Kelloggs', calidad: 'Premium'),
        Producto(sku: '1006012', nombre: 'Café Molido Premium', precio: 89.99, cantidad: 19, tiendaId: 15, marca: 'Café Tradicional', calidad: 'Premium'),
      ],

      // =======================
      // Tienda 16 - PUEBLA ANGELOPOLIS
      // =======================
      16: [
        Producto(sku: '1000290', nombre: 'Margarina Princess con Sal', precio: 29.90, cantidad: 46, tiendaId: 16, marca: 'Princess', calidad: 'Premium'),
        Producto(sku: '1001405', nombre: 'Agua Mineral Topo Chico 1.5L', precio: 15.99, cantidad: 61, tiendaId: 16, marca: 'Topo Chico', calidad: 'Premium'),
        Producto(sku: '1001706', nombre: 'Concentrado para preparar Horchata', precio: 24.99, cantidad: 36, tiendaId: 16, marca: 'Tradicional', calidad: 'Estándar'),
        Producto(sku: '1001707', nombre: 'Chocolate para Taza', precio: 34.99, cantidad: 41, tiendaId: 16, marca: 'Abuelita', calidad: 'Premium'),
        Producto(sku: '1002081', nombre: 'Chocolate Lenguas de Gato', precio: 18.99, cantidad: 51, tiendaId: 16, marca: 'Picard', calidad: 'Estándar'),
        Producto(sku: '1002717', nombre: 'Salchicha Viena San Rafael', precio: 45.99, cantidad: 31, tiendaId: 16, marca: 'San Rafael', calidad: 'Premium'),
        Producto(sku: '1002777', nombre: "Chocolate Hersheys Cookies 'N' Creme", precio: 19.99, cantidad: 56, tiendaId: 16, marca: 'Hersheys', calidad: 'Estándar'),
        Producto(sku: '1002778', nombre: 'Chocolate Hersheys Con Leche y Almendras', precio: 21.99, cantidad: 43, tiendaId: 16, marca: 'Hersheys', calidad: 'Premium'),
        Producto(sku: '1003434', nombre: 'Té Infusionate de Salvia', precio: 32.99, cantidad: 29, tiendaId: 16, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1003531', nombre: 'Té de Boldo Infusionate', precio: 28.99, cantidad: 33, tiendaId: 16, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1003569', nombre: 'Salchicha para Asar Chimex Cerdo', precio: 52.99, cantidad: 26, tiendaId: 16, marca: 'Chimex', calidad: 'Premium'),
        Producto(sku: '1003814', nombre: 'Té de Cola de Caballo Infusionate', precio: 26.99, cantidad: 39, tiendaId: 16, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004093', nombre: 'Ensalada Mixta Mr Lucky', precio: 39.99, cantidad: 21, tiendaId: 16, marca: 'Mr Lucky', calidad: 'Premium'),
        Producto(sku: '1004096', nombre: 'Ensalada César Mr Lucky', precio: 42.99, cantidad: 19, tiendaId: 16, marca: 'Mr Lucky', calidad: 'Estándar'),
        Producto(sku: '1004366', nombre: 'Té de Estafiate Infusionate', precio: 25.99, cantidad: 41, tiendaId: 16, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004370', nombre: 'Té de Eucalipto Infusionate', precio: 26.99, cantidad: 36, tiendaId: 16, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004386', nombre: 'Té de Hoja Sen Infusionate', precio: 27.99, cantidad: 31, tiendaId: 16, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004410', nombre: 'Té de Menta Infusionate', precio: 25.99, cantidad: 46, tiendaId: 16, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004425', nombre: 'Té de Palo Azul Infusionate', precio: 28.99, cantidad: 34, tiendaId: 16, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004456', nombre: 'Leche Evaporada La Lechera', precio: 17.99, cantidad: 51, tiendaId: 16, marca: 'La Lechera', calidad: 'Estándar'),
        Producto(sku: '1004789', nombre: 'Jamón de Pavo Deli Gourmet', precio: 78.99, cantidad: 16, tiendaId: 16, marca: 'Deli Gourmet', calidad: 'Premium'),
        Producto(sku: '1005123', nombre: 'Queso Fresco Oaxaca', precio: 65.99, cantidad: 23, tiendaId: 16, marca: 'Quesera', calidad: 'Premium'),
        Producto(sku: '1005456', nombre: 'Pan Molde Bimbo Blanco', precio: 22.99, cantidad: 49, tiendaId: 16, marca: 'Bimbo', calidad: 'Estándar'),
        Producto(sku: '1005789', nombre: 'Cereales Corn Flakes', precio: 45.99, cantidad: 37, tiendaId: 16, marca: 'Kelloggs', calidad: 'Premium'),
        Producto(sku: '1006012', nombre: 'Café Molido Premium', precio: 89.99, cantidad: 21, tiendaId: 16, marca: 'Café Tradicional', calidad: 'Premium'),
      ],

      // =======================
      // Tienda 24 - TORRECILLAS
      // =======================
      24: [
        Producto(sku: '1000290', nombre: 'Margarina Princess con Sal', precio: 29.90, cantidad: 39, tiendaId: 24, marca: 'Princess', calidad: 'Premium'),
        Producto(sku: '1001405', nombre: 'Agua Mineral Topo Chico 1.5L', precio: 15.99, cantidad: 54, tiendaId: 24, marca: 'Topo Chico', calidad: 'Premium'),
        Producto(sku: '1001706', nombre: 'Concentrado para preparar Horchata', precio: 24.99, cantidad: 29, tiendaId: 24, marca: 'Tradicional', calidad: 'Estándar'),
        Producto(sku: '1001707', nombre: 'Chocolate para Taza', precio: 34.99, cantidad: 34, tiendaId: 24, marca: 'Abuelita', calidad: 'Premium'),
        Producto(sku: '1002081', nombre: 'Chocolate Lenguas de Gato', precio: 18.99, cantidad: 44, tiendaId: 24, marca: 'Picard', calidad: 'Estándar'),
        Producto(sku: '1002717', nombre: 'Salchicha Viena San Rafael', precio: 45.99, cantidad: 24, tiendaId: 24, marca: 'San Rafael', calidad: 'Premium'),
        Producto(sku: '1002777', nombre: "Chocolate Hersheys Cookies 'N' Creme", precio: 19.99, cantidad: 48, tiendaId: 24, marca: 'Hersheys', calidad: 'Estándar'),
        Producto(sku: '1002778', nombre: 'Chocolate Hersheys Con Leche y Almendras', precio: 21.99, cantidad: 36, tiendaId: 24, marca: 'Hersheys', calidad: 'Premium'),
        Producto(sku: '1003434', nombre: 'Té Infusionate de Salvia', precio: 32.99, cantidad: 22, tiendaId: 24, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1003531', nombre: 'Té de Boldo Infusionate', precio: 28.99, cantidad: 26, tiendaId: 24, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1003569', nombre: 'Salchicha para Asar Chimex Cerdo', precio: 52.99, cantidad: 19, tiendaId: 24, marca: 'Chimex', calidad: 'Premium'),
        Producto(sku: '1003814', nombre: 'Té de Cola de Caballo Infusionate', precio: 26.99, cantidad: 32, tiendaId: 24, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004093', nombre: 'Ensalada Mixta Mr Lucky', precio: 39.99, cantidad: 14, tiendaId: 24, marca: 'Mr Lucky', calidad: 'Premium'),
        Producto(sku: '1004096', nombre: 'Ensalada César Mr Lucky', precio: 42.99, cantidad: 12, tiendaId: 24, marca: 'Mr Lucky', calidad: 'Estándar'),
        Producto(sku: '1004366', nombre: 'Té de Estafiate Infusionate', precio: 25.99, cantidad: 34, tiendaId: 24, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004370', nombre: 'Té de Eucalipto Infusionate', precio: 26.99, cantidad: 29, tiendaId: 24, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004386', nombre: 'Té de Hoja Sen Infusionate', precio: 27.99, cantidad: 24, tiendaId: 24, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004410', nombre: 'Té de Menta Infusionate', precio: 25.99, cantidad: 39, tiendaId: 24, marca: 'Herbal', calidad: 'Premium'),
        Producto(sku: '1004425', nombre: 'Té de Palo Azul Infusionate', precio: 28.99, cantidad: 27, tiendaId: 24, marca: 'Herbal', calidad: 'Estándar'),
        Producto(sku: '1004456', nombre: 'Leche Evaporada La Lechera', precio: 17.99, cantidad: 44, tiendaId: 24, marca: 'La Lechera', calidad: 'Estándar'),
        Producto(sku: '1004789', nombre: 'Jamón de Pavo Deli Gourmet', precio: 78.99, cantidad: 9, tiendaId: 24, marca: 'Deli Gourmet', calidad: 'Premium'),
        Producto(sku: '1005123', nombre: 'Queso Fresco Oaxaca', precio: 65.99, cantidad: 16, tiendaId: 24, marca: 'Quesera', calidad: 'Premium'),
        Producto(sku: '1005456', nombre: 'Pan Molde Bimbo Blanco', precio: 22.99, cantidad: 42, tiendaId: 24, marca: 'Bimbo', calidad: 'Estándar'),
        Producto(sku: '1005789', nombre: 'Cereales Corn Flakes', precio: 45.99, cantidad: 30, tiendaId: 24, marca: 'Kelloggs', calidad: 'Premium'),
        Producto(sku: '1006012', nombre: 'Café Molido Premium', precio: 89.99, cantidad: 14, tiendaId: 24, marca: 'Café Tradicional', calidad: 'Premium'),
      ],
    };
  }

  // Obtener productos de UNA tienda específica, usando el id de tienda
  Future<List<Producto>> getStoreProducts(int storeId) async {
    try {
      logger.logInfo('Obteniendo productos para tienda ID: $storeId');
      
      // Intentar obtener de Supabase primero
      if (_supabaseService != null) {
        try {
          logger.logInfo('Intentando obtener productos desde Supabase para tienda $storeId...');
          final supabaseProducts = await _supabaseService!.getProducts();
          
          if (supabaseProducts.isNotEmpty) {
            // Filtrar por tiendaId (ajustar según tu esquema de Supabase)
            final productosFiltrados = supabaseProducts
                .map((product) => Producto(
                      sku: product.sku,
                      nombre: product.nombre,
                      precio: 0.0,
                      cantidad: 1,
                      tiendaId: storeId,
                      imagenUrl: product.imagenUrl,
                    ))
                .toList();
            
            if (productosFiltrados.isNotEmpty) {
              logger.logSuccess(
                '✓ Productos obtenidos de Supabase para tienda $storeId: ${productosFiltrados.length} productos',
              );
              return productosFiltrados;
            }
          }
        } catch (e) {
          logger.logWarning('Error obteniendo productos de Supabase: $e');
          logger.logInfo('Usando datos hardcodeados como fallback...');
        }
      }
      
      // Fallback a datos hardcodeados
      final productosPorTienda = getProductosPredeterminados();
      
      if (productosPorTienda.containsKey(storeId)) {
        final productos = productosPorTienda[storeId]!;
        logger.logSuccess(
          'Productos obtenidos (hardcodeados) para tienda $storeId: ${productos.length} productos',
        );
        return productos;
      } else {
        logger.logWarning('No hay productos predeterminados para tienda: $storeId');
        return [];
      }
    } catch (e) {
      logger.logError('Error obteniendo productos de tienda: $storeId - $e');
      return [];
    }
  }

  // Obtener todos los productos agrupados por tienda
  Future<Map<int, List<Producto>>> getProductsByStores() async {
    try {
      logger.logInfo('Obteniendo productos agrupados por tiendas');
      
      // Intentar obtener de Supabase primero
      if (_supabaseService != null) {
        try {
          logger.logInfo('Intentando obtener productos desde Supabase...');
          final supabaseProducts = await _supabaseService!.getProducts();
          
          if (supabaseProducts.isNotEmpty) {
            logger.logSuccess('✓ Productos obtenidos de Supabase: ${supabaseProducts.length}');
            
            // Convertir Product a Producto y agrupar por tienda
            final productosPorTienda = <int, List<Producto>>{};
            
            for (var product in supabaseProducts) {
              // Intentar obtener tiendaId desde Supabase o usar valor por defecto
              // Por ahora, agrupamos todos en tienda 1 si no hay tienda_id
              final tiendaId = 1; // TODO: Obtener tienda_id desde Supabase si está disponible
              
              final producto = Producto(
                sku: product.sku,
                nombre: product.nombre,
                precio: product.price ?? 0.0, // Usar price de Supabase si está disponible
                cantidad: 1,
                tiendaId: tiendaId,
                imagenUrl: product.imagenUrl,
              );
              
              productosPorTienda.putIfAbsent(tiendaId, () => []).add(producto);
            }
            
            logger.logSuccess(
              'Productos obtenidos de Supabase para ${productosPorTienda.length} tiendas',
            );
            
            productosPorTienda.forEach((idTienda, lista) {
              logger.logInfo('Tienda $idTienda: ${lista.length} productos');
            });
            
            return productosPorTienda;
          }
        } catch (e) {
          logger.logWarning('Error obteniendo productos de Supabase: $e');
          logger.logInfo('Usando datos hardcodeados como fallback...');
        }
      }
      
      // Fallback a datos hardcodeados
      final productosPorTienda = getProductosPredeterminados();
      
      logger.logSuccess(
        'Productos obtenidos (hardcodeados) para ${productosPorTienda.length} tiendas',
      );
      
      productosPorTienda.forEach((idTienda, lista) {
        logger.logInfo('Tienda $idTienda: ${lista.length} productos');
      });
      
      return productosPorTienda;
    } catch (e) {
      logger.logError('Error obteniendo productos por tiendas: $e');
      return {};
    }
  }

  // Buscar un producto específico por SKU en todas las tiendas
  Future<Producto?> getProductoBySku(String sku) async {
    try {
      final productosPorTienda = getProductosPredeterminados();
      
      for (var productos in productosPorTienda.values) {
        for (var producto in productos) {
          if (producto.sku == sku) {
            return producto;
          }
        }
      }
      
      logger.logWarning('Producto con SKU $sku no encontrado');
      return null;
    } catch (e) {
      logger.logError('Error buscando producto por SKU: $e');
      return null;
    }
  }

  // Buscar productos por nombre (búsqueda parcial)
  Future<List<Producto>> searchProductos(String query) async {
    try {
      final productosPorTienda = getProductosPredeterminados();
      final resultados = <Producto>[];
      final queryLower = query.toLowerCase();
      
      for (var productos in productosPorTienda.values) {
        for (var producto in productos) {
          if (producto.nombre.toLowerCase().contains(queryLower) ||
              producto.marca?.toLowerCase().contains(queryLower) == true) {
            // Evitar duplicados si el producto existe en múltiples tiendas
            if (!resultados.any((p) => p.sku == producto.sku)) {
              resultados.add(producto);
            }
          }
        }
      }
      
      logger.logSuccess('Búsqueda completada: ${resultados.length} resultados');
      return resultados;
    } catch (e) {
      logger.logError('Error en búsqueda de productos: $e');
      return [];
    }
  }

  // Obtener productos por marca
  Future<List<Producto>> getProductosByMarca(String marca) async {
    try {
      final productosPorTienda = getProductosPredeterminados();
      final resultados = <Producto>[];
      
      for (var productos in productosPorTienda.values) {
        for (var producto in productos) {
          if (producto.marca?.toLowerCase() == marca.toLowerCase()) {
            if (!resultados.any((p) => p.sku == producto.sku)) {
              resultados.add(producto);
            }
          }
        }
      }
      
      return resultados;
    } catch (e) {
      logger.logError('Error obteniendo productos por marca: $e');
      return [];
    }
  }

  // Obtener productos por calidad
  Future<List<Producto>> getProductosByCalidad(String calidad) async {
    try {
      final productosPorTienda = getProductosPredeterminados();
      final resultados = <Producto>[];
      
      for (var productos in productosPorTienda.values) {
        for (var producto in productos) {
          if (producto.calidad?.toLowerCase() == calidad.toLowerCase()) {
            if (!resultados.any((p) => p.sku == producto.sku)) {
              resultados.add(producto);
            }
          }
        }
      }
      
      return resultados;
    } catch (e) {
      logger.logError('Error obteniendo productos por calidad: $e');
      return [];
    }
  }

  // ============================================
  // NUEVOS MÉTODOS PARA PRODUCTOS CON PRECIO
  // ============================================

  // Obtener TODOS los productos con precio desde Supabase (método simple)
  Future<List<Product>> getAllProducts() async {
    if (_supabaseService != null) {
      try {
        logger.logInfo('Obteniendo productos con precio desde Supabase...');
        final products = await _supabaseService!.getAllProducts();
        logger.logSuccess('✓ Productos con precio obtenidos: ${products.length}');
        return products;
      } catch (e) {
        logger.logWarning('Error obteniendo productos con precio: $e');
        return [];
      }
    }
    logger.logWarning('SupabaseService no disponible');
    return [];
  }

  // Obtener TODOS los productos con precio desde Supabase (método con nombre completo)
  Future<List<Product>> getAllProductsWithPrice() async {
    return getAllProducts();
  }

  // Filtrar productos por rango de precio
  Future<List<Product>> getProductsByPriceRange(double minPrice, double maxPrice) async {
    if (_supabaseService != null) {
      try {
        logger.logInfo('Filtrando productos por precio: \$$minPrice - \$$maxPrice');
        final products = await _supabaseService!.getByPriceRange(minPrice, maxPrice);
        logger.logSuccess('✓ Productos encontrados: ${products.length}');
        return products;
      } catch (e) {
        logger.logWarning('Error filtrando por precio: $e');
        return [];
      }
    }
    logger.logWarning('SupabaseService no disponible');
    return [];
  }


  // Buscar productos por nombre
  Future<List<Product>> searchProductsByName(String query) async {
    if (_supabaseService != null) {
      try {
        logger.logInfo('Buscando productos: "$query"');
        final products = await _supabaseService!.searchProducts(query);
        logger.logSuccess('✓ Productos encontrados: ${products.length}');
        return products;
      } catch (e) {
        logger.logWarning('Error buscando productos: $e');
        return [];
      }
    }
    logger.logWarning('SupabaseService no disponible');
    return [];
  }
}
