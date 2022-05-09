import 'package:dartz/dartz.dart';
import 'package:first_project/features/number_trivia/domain/enitities/number_trivia.dart';
import 'package:first_project/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helper/test_helper.mocks.dart';

void main(){
    late MockNumberTriviaRespository mockNumberTriviaRepository;
    late GetConcreteNumberTrivia usecase;

    setUp((){
        mockNumberTriviaRepository=MockNumberTriviaRespository();
        usecase=GetConcreteNumberTrivia(mockNumberTriviaRepository);
    });

    const tNumber=1;
    const tNumberTrivia= NumberTrivia(text: "test", number: 1);
    test(
      'should get trivia for the number form the reporitory',
      ()async{
        //arrange
        when(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber))
        .thenAnswer((_)async =>const Right(tNumberTrivia));
        //act
        final result = await usecase.execute(tNumber); 
        //assert
        expect(result, equals(const Right(tNumberTrivia)));
      },
    );
   
}