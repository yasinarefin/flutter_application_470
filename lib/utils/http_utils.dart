import 'package:http/http.dart' as http;

class HTTPUtils {
  static var client = http.Client();

  static final String endpoint = "http://192.140.252.28:8000";

  static final postHeaders = {
    "Content-Type": "application/json",
  };

  static Future<http.Response> post(
      {required String path,
      required String body,
      required Map<String, String> headers}) async {
    var tempHeaders = postHeaders;
    tempHeaders.addAll(headers);

    final response = await client
        .post(
      Uri.parse(endpoint + path),
      headers: tempHeaders,
      body: body,
    )
        .timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    );
    return response;
  }

  static Future<http.Response> get({
    required String path,
    required Map<String, String> headers,
  }) async {
    final response = await client
        .get(
      Uri.parse(endpoint + path),
      headers: headers,
    )
        .timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    );
    return response;
  }
}
