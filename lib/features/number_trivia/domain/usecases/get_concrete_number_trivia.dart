import 'package:dartz/dartz.dart';
import 'package:first_project/core/error/failures.dart';
import 'package:first_project/features/number_trivia/domain/enitities/number_trivia.dart';
import 'package:first_project/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import '../repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia{
    final NumberTriviaRespository respository;

    GetConcreteNumberTrivia(this.respository);

    Future<Either<Failure,NumberTrivia>> call({
      required int number
    }) async {
      return await respository.getConcreteNumberTrivia(number);
    }
}