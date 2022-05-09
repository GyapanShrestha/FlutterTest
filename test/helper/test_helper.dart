import 'package:first_project/features/number_trivia/domain/enitities/number_trivia.dart';
import 'package:first_project/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  NumberTriviaRespository,
  ], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
