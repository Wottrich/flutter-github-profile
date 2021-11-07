import 'package:flutter_github_profile/datasource/network_interceptors.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class NetworkConfig {

  static String baseUrl = "https://api.github.com";

  static final Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
      requestTimeout: const Duration(seconds: 30)
  );

}