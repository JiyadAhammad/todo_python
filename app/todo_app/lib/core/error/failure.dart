abstract class Error {
  final String failureMessage;

  Error({required this.failureMessage});
}

class ServerError extends Error {
  ServerError({required super.failureMessage});
}

class ClientError extends Error {
  ClientError({required super.failureMessage});
}
