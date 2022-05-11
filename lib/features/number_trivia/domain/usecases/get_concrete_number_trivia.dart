import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../enitities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements Usecase<NumberTrivia,Params>{
    final NumberTriviaRespository respository;

    GetConcreteNumberTrivia(this.respository);

    @override
    Future<Either<Failure,NumberTrivia>> call(Params params) {
      return respository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable{
  final int number;
  const Params({required this.number});


  @override
  List<Object?> get props => [number];
  }