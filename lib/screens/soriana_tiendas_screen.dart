import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/tienda.dart';
import '../data/tiendas_data.dart';
import '../services/location_service.dart';
import '../widgets/tienda_card.dart';
import '../utils/logger.dart';

class SorianaTiendasScreen extends StatefulWidget {
  const SorianaTiendasScreen({super.key});

  @override
  State<SorianaTiendasScreen> createState() => _SorianaTiendasScreenState();
}

class _SorianaTiendasScreenState extends State<SorianaTiendasScreen> {
  List<Tienda> _tiendas = [];
  bool _isLoading = true;
  String? _errorMessage;
  Position? _userPosition;
  final AppLogger _logger = AppLogger();

  @override
  void initState() {
    super.initState();
    _cargarTiendasSorianaCercanas();
  }

  // Obtener tiendas desde TiendasData
  List<Tienda> _getTiendasSorianaPredeterminadas() {
    return TiendasData.getTodas();
  }

  Future<void> _cargarTiendasSorianaCercanas() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Verificar permisos de ubicación
      _logger.logInfo('Verificando permisos de ubicación...');
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = 'El servicio de ubicación está desactivado. Por favor, actívalo en la configuración.';
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage = 'Los permisos de ubicación fueron denegados. Por favor, actívalos en la configuración.';
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _errorMessage = 'Los permisos de ubicación están denegados permanentemente. Por favor, actívalos en la configuración de la app.';
          _isLoading = false;
        });
        return;
      }

      // Obtener ubicación del usuario con timeout
      _logger.logInfo('Solicitando ubicación del usuario...');
      try {
        _userPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 15),
        ).timeout(
          const Duration(seconds: 15),
          onTimeout: () {
            _logger.logError('Timeout al obtener ubicación');
            throw TimeoutException('No se pudo obtener la ubicación en el tiempo esperado');
          },
        );
      } catch (e) {
        _logger.logError('Error obteniendo ubicación: $e');
        setState(() {
          _errorMessage = 'No se pudo obtener tu ubicación. Por favor, activa el GPS y vuelve a intentar.';
          _isLoading = false;
        });
        return;
      }

      if (_userPosition == null) {
        setState(() {
          _errorMessage = 'No se pudo obtener tu ubicación. Por favor, activa el GPS.';
          _isLoading = false;
        });
        return;
      }

      _logger.logSuccess('✓ Ubicación obtenida: ${_userPosition!.latitude}, ${_userPosition!.longitude}');
      _logger.logInfo('Coordenadas del usuario: Lat=${_userPosition!.latitude}, Lng=${_userPosition!.longitude}');
      _logger.logInfo('Cargando tiendas Soriana predeterminadas (sin Supabase)...');

      // Obtener lista predeterminada de tiendas
      final todasLasTiendas = _getTiendasSorianaPredeterminadas();
      _logger.logInfo('Tiendas predeterminadas cargadas: ${todasLasTiendas.length}');

      // Mostrar TODAS las tiendas (sin filtrar por distancia)
      // Calcular distancia para cada tienda para ordenarlas
      final tiendasConDistancia = <MapEntry<Tienda, double>>[];
      
      for (var tienda in todasLasTiendas) {
        // Calcular distancia usando fórmula de Haversine
        final distancia = LocationService.calculateDistance(
          _userPosition!.latitude,
          _userPosition!.longitude,
          tienda.latitud,
          tienda.longitud,
        );

        _logger.logInfo('Tienda ${tienda.nombre}: distancia ${distancia.toStringAsFixed(2)} km');
        tiendasConDistancia.add(MapEntry(tienda, distancia));
      }

      // Ordenar por distancia (más cercanas primero)
      tiendasConDistancia.sort((a, b) => a.value.compareTo(b.value));

      // Extraer solo las tiendas ordenadas
      final tiendasOrdenadas = tiendasConDistancia.map((e) => e.key).toList();

      setState(() {
        _tiendas = tiendasOrdenadas;
        _isLoading = false;
      });

      _logger.logSuccess('Tiendas Soriana cargadas: ${tiendasOrdenadas.length} tiendas disponibles');
      
      if (tiendasOrdenadas.isEmpty) {
        _logger.logWarning('No hay tiendas Soriana disponibles');
      }
    } catch (e, stackTrace) {
      _logger.logError('Error cargando tiendas Soriana: $e');
      _logger.logInfo('Stack trace: $stackTrace');
      setState(() {
        _errorMessage = 'Error al cargar tiendas: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    await _cargarTiendasSorianaCercanas();
  }

  void _mostrarLogs(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logs de Debug'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: _logger.logs.map((log) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    log.toString(),
                    style: TextStyle(
                      color: log.color,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          TextButton(
            onPressed: () {
              _logger.clearLogs();
              Navigator.pop(context);
            },
            child: const Text('Limpiar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tiendas Soriana'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _onRefresh,
            tooltip: 'Actualizar',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 64,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _cargarTiendasSorianaCercanas,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  ),
                )
              : _tiendas.isEmpty
                  ? Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.store_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'No hay tiendas Soriana disponibles en este radio',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Verifica que las tiendas estén configuradas correctamente.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Botón para ver logs de debug
                            ElevatedButton.icon(
                              onPressed: () {
                                _mostrarLogs(context);
                              },
                              icon: const Icon(Icons.bug_report),
                              label: const Text('Ver Logs de Debug'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: _tiendas.length,
                        itemBuilder: (context, index) {
                          final tienda = _tiendas[index];
                          // Usar el nuevo TiendaCard optimizado
                          return TiendaCard(tienda: tienda);
                        },
                      ),
                    ),
    );
  }
}

