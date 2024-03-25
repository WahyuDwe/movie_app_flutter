abstract class Failure {}

class ServerFailure extends Failure {
  final String? message;
  final int? code;

  ServerFailure({required this.message, required this.code});
}
