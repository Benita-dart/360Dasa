// api_service.dart

import 'package:http/http.dart' as http;

class APIService {
  static const String baseUrl =
      'https://360dasa.org/dasaapis/index.php/DasaApi';

  static Future<http.Response> post(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/createAccount');
    final response = await http.post(url, body: body);
    return response;
  }
}
