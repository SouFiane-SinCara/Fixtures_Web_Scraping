import 'package:dartz/dartz.dart';
import 'package:fixtures_web_scraping/core/failures/failures.dart';

typedef StreamFutureEither<T> = Stream<Future<Either<Failure, T>>>;