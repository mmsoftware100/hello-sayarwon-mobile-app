class ServerException implements Exception {}

class CacheException implements Exception {}
class SerializationException implements Exception {}

class UnverifiedUserException implements Exception {}
class NeedToLoginException implements Exception {}
class NoDataException implements Exception {}

class ValidationException implements Exception {
  final Map<String,List<String>> errors;
  ValidationException({required this.errors});
}

class SingleMessageException implements Exception {
  final String message;
  SingleMessageException({required this.message});
}
