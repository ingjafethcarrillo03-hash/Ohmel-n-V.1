class Tienda {
  final int id;
  final String nombre;
  final String idSitio;
  final String direccionTexto;
  final double latitud;
  final double longitud;
  final String? googleMapsUrl;

  const Tienda({
    required this.id,
    required this.nombre,
    required this.idSitio,
    required this.direccionTexto,
    required this.latitud,
    required this.longitud,
    this.googleMapsUrl,
  });

  factory Tienda.fromJson(Map<String, dynamic> json) {
    return Tienda(
      id: json['id'] as int,
      nombre: json['nombre'] as String? ?? '',
      idSitio: json['id_sitio'] as String? ?? '',
      direccionTexto: json['direccion_texto'] as String? ?? json['direccion'] as String? ?? '',
      latitud: (json['latitud'] as num?)?.toDouble() ?? 0.0,
      longitud: (json['longitud'] as num?)?.toDouble() ?? 0.0,
      googleMapsUrl: json['link_maps'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'id_sitio': idSitio,
      'direccion_texto': direccionTexto,
      'latitud': latitud,
      'longitud': longitud,
      'link_maps': googleMapsUrl,
    };
  }

  // Getters para compatibilidad con código existente
  String get direccion => direccionTexto;
  
  String get googleMapsUrlComputed => googleMapsUrl ?? 
      'https://www.google.com/maps/search/$latitud,$longitud';
}

