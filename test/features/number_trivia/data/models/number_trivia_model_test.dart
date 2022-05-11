

import 'dart:convert';

import 'package:first_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:first_project/features/number_trivia/domain/enitities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main(){
  final tNumberTriviaModel= NumberTriviaModel(number:1,text:'Test Text');

  test('should be a subclass of NumberTrivia entity',
   ()async{
     //assert
     expect(tNumberTriviaModel, isA<NumberTrivia>());
   });

   group('fromJson',(){
     test('should return a valid model when the JSON number is an integer',
     ()async{
       //arranget
       final Map<String,dynamic> jsonMap=json.decode(fixture('trivia.json'));
       //act
        final result = NumberTriviaModel.fromJson(jsonMap);
       //assert
        expect(result, tNumberTriviaModel);
     });
      test('should return a valid model when the JSON number is regarded as double',
     ()async{
       //arranget
       final Map<String,dynamic> jsonMap=json.decode(fixture('trivia_double.json'));
       //act
        final result = NumberTriviaModel.fromJson(jsonMap);
       //assert
        expect(result, tNumberTriviaModel);
     });
   });

   group('toJson', (){
     test("should return a JSON map containing the proper data", ()async{
       //act
       final result=tNumberTriviaModel.toJson();
       //assert
       final expectedMap={"text":"Test Text",
    "number":1};
       expect(result, expectedMap);
     });
   });
}