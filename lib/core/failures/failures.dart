abstract class Failure {
  final String message;
  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure() : super(message: 'Server is down.');
}

class NoInternetConnectionFailure extends Failure {
  NoInternetConnectionFailure() : super(message: 'No internet connection.');
}

class GeneraleFailure extends Failure {
  GeneraleFailure() : super(message: 'An unknown error occurred.');
}
