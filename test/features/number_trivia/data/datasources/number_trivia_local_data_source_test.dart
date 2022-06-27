import 'dart:convert';

import 'package:first_project/core/error/exceptions.dart';
import 'package:first_project/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:first_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../helper/test_helper.mocks.dart';
import '../../../../fixtures/fixture_reader.dart';

void main(){
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp((){
    mockSharedPreferences = MockSharedPreferences();
    dataSource= NumberTriviaLocalDataSourceImpl(  sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia',(){
    final tNumberTriviaModel=NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test("should return NumberTrivia from SharedPreference when there is one in the cache", () async{
      when(mockSharedPreferences.getString(any))
      .thenReturn(fixture('trivia_cached.json'));
      final result = await dataSource.getLastNumberTrivia();

      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));

    });
     test("should throw a CacheException when there is no cached value", () async{
      when(mockSharedPreferences.getString(any))
      .thenReturn(null);
      final call =  dataSource.getLastNumberTrivia;

      expect(()=>call(), throwsA(const TypeMatcher<CacheException>()));

    });
  });
  group('cacheNumberTrivia',(){
    final tNumberTriviaModel=NumberTriviaModel(number: 1,text: 'Test text');
    test('should call SharedPreferences to cache the data', ()
    async{
      when(dataSource.cacheNumberTrivia(tNumberTriviaModel)).thenAnswer((_) async=>true);
      
      //assert
      final expectJsonString = json.encode(tNumberTriviaModel.toJson());
      final result = await dataSource.cacheNumberTrivia(tNumberTriviaModel);
      verify(mockSharedPreferences.setString(CACHED_NUMBER_TRIVIA, expectJsonString));
      expect(result, equals(true));
    });
  });
}