import 'package:dartz/dartz.dart';
import 'package:first_project/core/usecases/usecase.dart';
import 'package:first_project/features/number_trivia/domain/enitities/number_trivia.dart';
import 'package:first_project/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helper/test_helper.mocks.dart';

void main(){
    late MockNumberTriviaRespository mockNumberTriviaRepository;
    late GetRandomNumberTrivia usecase;

    setUp((){
        mockNumberTriviaRepository=MockNumberTriviaRespository();
        usecase=GetRandomNumberTrivia(mockNumberTriviaRepository);
    });

    const tNumberTrivia= NumberTrivia(text: "test", number: 1);
    test(
      'should get trivia form the reporitory',
      ()async{
        //arrange
        when(mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_)async =>const Right(tNumberTrivia));
        //act
        final result = await usecase(NoParams()); 
        //assert
        expect(result, equals(const Right(tNumberTrivia)));
      },
    );
   
}