sealed class Failure {
  final String message;
  const Failure({required this.message});
  const factory Failure.localFailure({required String message}) = LocalFailure;
  const factory Failure.serverFailure({required String message}) =
      ServerFailure;
  const factory Failure.authFailure({required String message}) = AuthFailure;
}

class LocalFailure extends Failure {
  const LocalFailure({required this.message}) : super(message: '');
  final String message;
}

class ServerFailure extends Failure {
  const ServerFailure({required this.message}) : super(message: '');
  final String message;
}

class AuthFailure extends Failure {
  const AuthFailure({required this.message}) : super(message: '');
  final String message;
}
