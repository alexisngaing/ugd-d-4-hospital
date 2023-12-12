class ApiClient {
  final String domainName = 'http://20.40.99.235:8000';
  late final String baseUrl;
  ApiClient() {
    baseUrl = '$domainName/api';
  }
}
