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
  }
}
