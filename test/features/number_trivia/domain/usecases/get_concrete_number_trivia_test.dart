import 'package:dartz/dartz.dart';
import 'package:first_project/features/number_trivia/domain/enitities/number_trivia.dart';
import 'package:first_project/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:first_project/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
class MockNumnerTriviaRepository extends Mock implements NumberTriviaRespository{

}

@GenerateMocks([MockNumnerTriviaRepository]
)
void main(){
    late GetConcreteNumberTrivia usecase;
    late MockNumnerTriviaRepository mockNumberTriviaRepository;

    setUp((){
        mockNumberTriviaRepository=MockNumnerTriviaRepository();
        usecase=GetConcreteNumberTrivia(mockNumberTriviaRepository);
    });

    const tNumber=1;
    final tNumberTrivia= NumberTrivia(text: "test", number: 1);
    test(
      'should get trivia for the number form the reporitory',
      ()async{
        //arrange
        when(mockNumberTriviaRepository.getConcreteNumberTrivia(1))
        .thenAnswer((_)async => Right(tNumberTrivia));
        //act
        final result = await usecase(number:tNumber);
        //assert
        expect(result, Right(tNumberTrivia));
        verify(mockNumberTriviaRepository.getConcreteNumberTrivia((tNumber)));
        verifyNoMoreInteractions(mockNumberTriviaRepository);
      },
    );
}