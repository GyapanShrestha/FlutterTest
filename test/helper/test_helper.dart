import 'package:first_project/core/platform/network_info.dart';
import 'package:first_project/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:first_project/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:first_project/features/number_trivia/domain/enitities/number_trivia.dart';
import 'package:first_project/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  NumberTriviaRespository,
  NumberTriviaRemoteDataSource,
  NumberTriviaLocalDataSource,
  NetworkInfo
  ], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
