import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api_service.dart';
import 'package:flutter/foundation.dart';

class DataRepository {
  final APIService apiService;

  DataRepository({@required this.apiService});

  Future<int> getEndpointData(Endpoint endpoint) async {
    final accessToken = await apiService.getAccessToken();

    return await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: endpoint,
    );
  }
}
