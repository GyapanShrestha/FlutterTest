import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:first_project/core/error/failures.dart';
import 'package:first_project/core/usecases/usecase.dart';
import 'package:first_project/features/number_trivia/domain/enitities/number_trivia.dart';
import 'package:first_project/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import '../repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements Usecase<NumberTrivia,NoParams>{
    final NumberTriviaRespository respository;

    GetRandomNumberTrivia(this.respository);

    @override
    Future<Either<Failure,NumberTrivia>> call(NoParams noParams) {
      return respository.getRandomNumberTrivia();
  }
}

