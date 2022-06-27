import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:first_project/core/error/exceptions.dart';
import 'package:first_project/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:first_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../helper/test_helper.mocks.dart';
import 'package:http/http.dart' as http;
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late NumberTriviaRemoteDataSourceImp dataSource;
  late MockHttpClient mockHttpClient;
  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImp(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() =>
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  void setUpMockHttpClientFailure404() =>
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));
  group('getConcreteNumberTrivia', () {

    const tNumber = 1;
    final tNumberTrivialModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''should perform a GET request on a URL with number 
      being the endpoint and with application/json header''', () async {
      //arragne
      setUpMockHttpClientSuccess200();

      //act
      dataSource.getConcreteNumberTrivia(tNumber);

      //assert
      Uri myUri = Uri.parse('http://numbersapi/$tNumber');
      verify(mockHttpClient
          .get(myUri, headers: {'Content-Type': 'application/json'}));
    });
    test('should return number trivial when the response code is 200 (success)',
        () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      expect(result, equals(tNumberTrivialModel));
    });
    test('should throw a SeverException when the response code is not 200',
        () async {
      setUpMockHttpClientFailure404();

      final call = dataSource.getConcreteNumberTrivia;

      expect(
          () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });
   group('getRandomNumberTrivia', () {

   
    final tNumberTrivialModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''should perform a GET request on a URL with number 
      being the endpoint and with application/json header''', () async {
      //arragne
      setUpMockHttpClientSuccess200();

      //act
      dataSource.getRandomNumberTrivia();

      //assert
      Uri myUri = Uri.parse('http://numbersapi/random');
      verify(mockHttpClient
          .get(myUri, headers: {'Content-Type': 'application/json'}));
    });
    test('should return number trivial when the response code is 200 (success)',
        () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSource.getRandomNumberTrivia();

      expect(result, equals(tNumberTrivialModel));
    });
    test('should throw a SeverException when the response code is not 200',
        () async {
      setUpMockHttpClientFailure404();

      final call = dataSource.getRandomNumberTrivia;

      expect(
          () => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
  
}
