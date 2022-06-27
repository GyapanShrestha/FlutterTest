import 'dart:convert';

import 'package:first_project/core/error/exceptions.dart';

import '../models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImp implements NumberTriviaRemoteDataSource {
  final http.Client client;
  NumberTriviaRemoteDataSourceImp({required this.client});
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    Uri myUri = Uri.parse('http://numbersapi/$number');
    return _getTriviaFromUrl(myUri);
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia()async {
   Uri myUri = Uri.parse('http://numbersapi/random');
   return _getTriviaFromUrl(myUri);
  }

  Future<NumberTriviaModel>_getTriviaFromUrl(Uri uri) async{
final response =
        await client.get(uri, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    }else {
      throw ServerException();
    }
  }
}
