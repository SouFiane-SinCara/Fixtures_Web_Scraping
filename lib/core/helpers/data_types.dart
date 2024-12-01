import 'package:dartz/dartz.dart';
import 'package:fixtures_web_scraping/core/failures/failures.dart'; 

typedef FutureEither<T> = Future<Either<Failure,T>>;
