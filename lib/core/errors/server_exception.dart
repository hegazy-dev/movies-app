class ServerException implements Exception {
  final int statusCode;

  ServerException(this.statusCode);

  @override
  String toString() => 'Server error: $statusCode';
}
