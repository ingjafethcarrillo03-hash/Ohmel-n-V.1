import 'dart:math';

class LocationService {
  // Constante: radio de la Tierra en kilómetros
  static const double EARTH_RADIUS_KM = 6371.0;
  static const double DELIVERY_RADIUS_KM = 20.0;

  /// Calcula distancia entre dos puntos usando la fórmula de Haversine
  /// Retorna la distancia en kilómetros
  static double calculateDistance(
    double userLat,
    double userLng,
    double storeLat,
    double storeLng,
  ) {
    // Validar coordenadas
    if (userLat.isNaN || userLng.isNaN || storeLat.isNaN || storeLng.isNaN) {
      return double.infinity; // Retornar distancia infinita si hay coordenadas inválidas
    }

    // Convertir diferencias de latitud y longitud a radianes
    final dLat = _toRadians(storeLat - userLat);
    final dLng = _toRadians(storeLng - userLng);

    // Fórmula de Haversine: a = sin²(Δlat/2) + cos(lat1) * cos(lat2) * sin²(Δlon/2)
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(userLat)) *
            cos(_toRadians(storeLat)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    // c = 2 * atan2(√a, √(1−a))
    final c = 2 * asin(sqrt(a));
    
    // Distancia = R * c (donde R es el radio de la Tierra)
    final distance = EARTH_RADIUS_KM * c;

    return distance;
  }

  /// Verifica si el usuario está dentro del rango de entrega (20 km)
  static bool isWithinDeliveryRange(
    double userLat,
    double userLng,
    double storeLat,
    double storeLng,
  ) {
    final distance = calculateDistance(userLat, userLng, storeLat, storeLng);
    return distance <= DELIVERY_RADIUS_KM;
  }

  /// Convierte grados a radianes
  static double _toRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  /// Retorna distancia formateada para mostrar
  static String formatDistance(double distance) {
    if (distance < 1) {
      return '${(distance * 1000).toStringAsFixed(0)} m';
    }
    return '${distance.toStringAsFixed(1)} km';
  }
}

