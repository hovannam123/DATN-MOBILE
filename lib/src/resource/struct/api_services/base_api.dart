import 'dart:convert';

import 'package:safe_food/src/resource/store_data/store_data.dart';
import 'package:http/http.dart' as http;

class BaseApi {
  BaseApi() {
    domain = "http://localhost:3000/api/v1";
  }
  late String _domain;

  set domain(String newDomain) => _domain = newDomain;

  Future<dynamic> getMethod(url, {Map<String, String>? headers}) async {
    headers ??= <String, String>{};
    headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${StoreData().retrieveToken()}'
    });
    Uri uri = Uri.parse('$_domain$url');
    http.Response response = await http.get(uri, headers: headers);
    int statusCode = response.statusCode;
    _handleResponse(statusCode, response);
  }

  Future<dynamic> postMethod(url,
      {Map<String, String>? headers, Map<String, String>? body}) async {
    headers ??= <String, String>{};

    headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${StoreData().retrieveToken()}'
    });
    Uri uri = Uri.parse('$_domain$url');
    http.Response response = await http.post(uri, headers: headers, body: body);
    int statusCode = response.statusCode;
    return _handleResponse(statusCode, response);
  }

  Future<dynamic> putMethod(url,
      {Map<String, String>? headers, Map<String, String>? body}) async {
    headers ??= <String, String>{};

    headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${StoreData().retrieveToken()}'
    });

    Uri uri = Uri.parse('$_domain$url');
    http.Response response = await http.put(uri, headers: headers, body: body);
    int statusCode = response.statusCode;
    return _handleResponse(statusCode, response);
  }

  Future<dynamic> deleteMethod(url,
      {Map<String, String>? headers, Map<String, String>? body}) async {
    headers ??= <String, String>{};

    headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${StoreData().retrieveToken()}'
    });

    Uri uri = Uri.parse('$_domain$url');
    http.Response response =
        await http.delete(uri, headers: headers, body: body);
    int statusCode = response.statusCode;
    return _handleResponse(statusCode, response);
  }

  dynamic _handleResponse(int statusCode, http.Response response) {
    if (200 <= statusCode && statusCode <= 299) {
      return json.decode(response.body);
    }
    if (statusCode == 401 || statusCode == 403) {
      throw Exception('Token expired');
    }
    if (400 <= statusCode && statusCode <= 499) {
      throw Exception(json.decode(response.body)["message"]);
    } else if (500 <= response.statusCode && response.statusCode <= 599) {
      throw Exception('Server Error');
    }
    throw Exception('Unhandled error');
  }
}
