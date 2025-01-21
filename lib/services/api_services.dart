import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl;
  final Map<String, String> defaultHeaders;
  bool enableLogging;
  ApiService({
    required this.baseUrl,
    this.enableLogging = false,
    this.defaultHeaders = const {},
  });

  Future<http.Response> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _handleRequest(
      () => http.delete(
        _buildUri(endpoint, queryParameters),
        headers: _mergeHeaders(headers),
      ),
    );
  }

  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _handleRequest(
      () => http.get(
        _buildUri(endpoint, queryParameters),
        headers: _mergeHeaders(headers),
      ),
    );
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _handleRequest(
      () => http.post(
        _buildUri(endpoint, queryParameters),
        headers: _mergeHeaders(headers),
        body: body,
      ),
    );
  }

  Future<http.Response> put(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _handleRequest(
      () => http.put(
        _buildUri(endpoint, queryParameters),
        headers: _mergeHeaders(headers),
        body: jsonEncode(body),
      ),
    );
  }

  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParameters) {
    return Uri.parse(baseUrl + endpoint).replace(
        queryParameters: queryParameters?.map(
      (key, value) => MapEntry(key, value.toString()),
    ));
  }

  Future<http.Response> _handleRequest(
      Future<http.Response> Function() request) async {
    try {
      final response = await request();
      return _parseResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Map<String, String> _mergeHeaders(Map<String, String>? headers) {
    return {
      ...defaultHeaders,
      if (headers != null) ...headers,
    };
  }

  http.Response _parseResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
      default:
        throw http.ClientException(
          'Request failed with status: ${response.statusCode}',
          response.request?.url,
        );
    }
  }
}
