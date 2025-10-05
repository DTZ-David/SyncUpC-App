import 'package:http/http.dart' as http;

/// Extensión para agregar timeout a peticiones HTTP de forma uniforme
extension HttpTimeout on Future<http.Response> {
  /// Agrega un timeout de 30 segundos a la petición HTTP
  Future<http.Response> withTimeout() {
    return timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw Exception('La solicitud tardó demasiado. Verifica tu conexión');
      },
    );
  }
}
