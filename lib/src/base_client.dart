import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

abstract class BaseClient {
  BaseClient({
    required String baseUrl,
    http.Client? httpClient,
  })  : _baseUrl = baseUrl,
        _httpClient = httpClient ?? http.Client();

  final String _baseUrl;

  final http.Client _httpClient;

  Future<Document> send(
    String method,
    String path, {
    int? mi,
    int? bbsId,
    Map<String, dynamic> params = const {},
  }) async {
    final upperMethod = method.toUpperCase();
    final query = ({
      'mi': mi,
      'bbsId': bbsId,
      ...params,
    }..removeWhere((key, value) => value == null))
        .map((key, value) => MapEntry(key, '$value'));

    final request = http.Request(
      upperMethod,
      upperMethod == 'GET'
          ? Uri.parse(_baseUrl + path).replace(queryParameters: query)
          : Uri.parse(_baseUrl + path),
    );

    if (upperMethod == 'POST') request.bodyFields = query;

    final response = await _httpClient.send(request);

    final body = await response.stream.bytesToString();

    return parser.parse(body);
  }
}
