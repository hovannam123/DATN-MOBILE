import 'dart:convert';

import 'package:safe_food/src/resource/store_data/store_data.dart';
import 'package:http/http.dart' as http;

class BaseApi {
  BaseApi() {
    domain = "http://192.168.1.23:3000/api/v1";
  }
  late String _domain;

  set domain(String newDomain) => _domain = newDomain;

  Future<dynamic> getMethod(url, {Map<String, String>? headers}) async {
    String? token = await StoreData().retrieveToken();
    headers ??= <String, String>{};
    headers.addAll(
        {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'});
    Uri uri = Uri.parse('$_domain$url');
    http.Response response = await http.get(uri, headers: headers);
    int statusCode = response.statusCode;
    return _handleResponse(statusCode, response);
  }

  Future<dynamic> postMethod(url,
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    headers ??= <String, String>{};

    headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${StoreData().retrieveToken()}'
    });

    Uri uri = Uri.parse('$_domain$url');
    http.Response response =
        await http.post(uri, headers: headers, body: jsonEncode(body));

    int statusCode = response.statusCode;
    return _handleResponse(statusCode, response);
  }

  Future<dynamic> putMethod(url,
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    headers ??= <String, String>{};

    headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${StoreData().retrieveToken()}'
    });

    Uri uri = Uri.parse('$_domain$url');
    http.Response response =
        await http.put(uri, headers: headers, body: jsonEncode(body));
    int statusCode = response.statusCode;
    return _handleResponse(statusCode, response);
  }

  Future<dynamic> deleteMethod(url,
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    headers ??= <String, String>{};

    headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${StoreData().retrieveToken()}'
    });

    Uri uri = Uri.parse('$_domain$url');
    http.Response response =
        await http.delete(uri, headers: headers, body: jsonEncode(body));
    int statusCode = response.statusCode;
    return _handleResponse(statusCode, response);
  }

  _handleResponse(int statusCode, http.Response response) {
    if (statusCode == 200) {
      return json.decode(response.body);
    }
    if (statusCode == 400) {
      throw Exception(json.decode(response.body)["message"]);
    } else if (500 <= response.statusCode && response.statusCode <= 599) {
      throw Exception('Server Error');
    }
    throw Exception('Unhandled error');
  }
}
