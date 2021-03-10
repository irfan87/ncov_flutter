import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';

class APIService {
  final API api;

  APIService(this.api);

  Future<String> getAccessToken() async {
    // if the api.tokenUri() is not working, apply toString()
    // example apli.tokenUri().toString()
    final response = await http.post(
      api.tokenUri(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];

      if (accessToken != null) {
        return accessToken;
      }
    }

    print(
        'Request ${api.tokenUri()} failed\nRespnse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<int> getEndpointData({
    @required String accessToken,
    @required Endpoint endpoint,
  }) async {
    final uri = api.endPoint(endpoint);
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        final String responseJSONKey = _responseJSONKeys[endpoint];
        final int result = endpointData[responseJSONKey];

        if (result != null) {
          return result;
        }
      }
    }

    print(
        'Request ${api.tokenUri()} failed\nRespnse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  static Map<Endpoint, String> _responseJSONKeys = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'data',
    Endpoint.casesConfirmed: 'data',
    Endpoint.deaths: 'data',
    Endpoint.recovered: 'data',
  };
}
