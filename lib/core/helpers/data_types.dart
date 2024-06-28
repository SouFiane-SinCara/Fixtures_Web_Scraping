import 'package:dartz/dartz.dart';
import 'package:fixtures_app/core/failures/failures.dart'; 

typedef FutureEither<T> = Future<Either<Failure,T>>;
