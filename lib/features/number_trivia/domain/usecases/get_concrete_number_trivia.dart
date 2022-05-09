import 'package:dartz/dartz.dart';
import 'package:first_project/core/error/failures.dart';
import 'package:first_project/features/number_trivia/domain/enitities/number_trivia.dart';
import 'package:first_project/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import '../repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia{
    final NumberTriviaRespository respository;

    GetConcreteNumberTrivia(this.respository);

    Future<Either<Failure,NumberTrivia>> execute(int number) {
      return respository.getConcreteNumberTrivia(number);
    
  }
}