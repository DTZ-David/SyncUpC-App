import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'login_service.dart';

class AuthHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();
  final LoginService _authService = LoginService();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    http.StreamedResponse response = await _inner.send(request);

    if (response.statusCode == 401) {
      final refreshToken = prefs.getString('refreshToken');
      if (refreshToken == null) return response;

      try {
        final tokens = await _authService.refreshAccessToken(refreshToken);
        final newToken = tokens['accessToken'];
        final newRefreshToken = tokens['refreshToken'];

        // Guardar nuevos tokens
        await prefs.setString('token', newToken);
        await prefs.setString('refreshToken', newRefreshToken);

        // Reintentar con el nuevo token
        final retryRequest = http.Request(request.method, request.url)
          ..headers.addAll(request.headers)
          ..headers['Authorization'] = 'Bearer $newToken';

        if (request is http.Request && request.bodyBytes.isNotEmpty) {
          retryRequest.bodyBytes = request.bodyBytes;
        }

        return await _inner.send(retryRequest);
      } catch (_) {
        return response; // Si falla el refresh, devolver el 401 original
      }
    }

    return response;
  }
}
