import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../enitities/number_trivia.dart';

abstract class NumberTriviaRespository{
    Future<Either<Failure,NumberTrivia>> getConcreteNumberTrivia(int number);
    Future<Either<Failure,NumberTrivia>> getRandomNumberTrivia();
}