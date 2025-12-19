import '../models/tienda.dart';

class TiendasData {
  static const List<Tienda> tiendas = [
    Tienda(
      id: 1,
      nombre: 'PUEBLA HERMANOS SERDAN',
      idSitio: '0913',
      direccionTexto: 'BLVD. HERMANOS SERDAN 630, PUEBLA, 72020 MX',
      latitud: 19.0803,
      longitud: -98.2269,
    ),
    Tienda(
      id: 6,
      nombre: 'PUEBLA PLAZA SAN PEDRO',
      idSitio: '0871',
      direccionTexto: 'BLVD. NORTE HEROES 5 DE MAYO 2410, PUEBLA, 72070 MX',
      latitud: 19.0656,
      longitud: -98.2121,
    ),
    Tienda(
      id: 7,
      nombre: 'CAPU',
      idSitio: '0087',
      direccionTexto: 'HEROES DEL 5 DE MAYO 1101, PUEBLA, 72080 MX',
      latitud: 19.0699,
      longitud: -98.1946,
    ),
    Tienda(
      id: 9,
      nombre: 'PUEBLA CENTRO',
      idSitio: '0694',
      direccionTexto: '7 SUR 1910, PUEBLA, 72000 MX',
      latitud: 19.0393,
      longitud: -98.2069,
    ),
    Tienda(
      id: 11,
      nombre: 'PUEBLA ZARAGOZA',
      idSitio: '0886',
      direccionTexto: 'PROLONGACION DIAGONAL DEFENSORE 220, PUEBLA, 72240 MX',
      latitud: 19.0648,
      longitud: -98.1777,
    ),
    Tienda(
      id: 15,
      nombre: 'PROVIDENCIA',
      idSitio: '0224',
      direccionTexto: 'CADETE VICENTE SUAREZ 1011, PUEBLA, 72340 MX',
      latitud: 19.0428,
      longitud: -98.1642,
    ),
    Tienda(
      id: 16,
      nombre: 'PUEBLA ANGELOPOLIS',
      idSitio: '0932',
      direccionTexto: 'BLVD. DEL NIÑO POBLANO S/N, PUEBLA, 72240 MX',
      latitud: 19.029,
      longitud: -98.2355,
    ),
    Tienda(
      id: 24,
      nombre: 'TORRECILLAS',
      idSitio: '0096',
      direccionTexto: 'BLVD MUNICIPIO LIBRE 555, PUEBLA, 72490 MX',
      latitud: 19.0,
      longitud: -98.2303,
    ),
  ];

  /// Obtener todas las tiendas
  static List<Tienda> getTodas() => tiendas;

  /// Obtener una tienda por ID
  static Tienda? getTiendaById(int id) {
    try {
      return tiendas.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }
}



