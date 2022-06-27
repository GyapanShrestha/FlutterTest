import 'dart:io';

import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:first_project/core/network/network_info.dart';
import 'package:first_project/core/util/input_converter.dart';
import 'package:first_project/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:first_project/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:first_project/features/number_trivia/domain/enitities/number_trivia.dart';
import 'package:first_project/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([
  NumberTriviaRespository,
  NumberTriviaRemoteDataSource,
  NumberTriviaLocalDataSource,
  DataConnectionChecker,
  SharedPreferences,
  NetworkInfo,
  InputConverter
  ], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
