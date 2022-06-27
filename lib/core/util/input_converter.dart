import 'package:dartz/dartz.dart';
import 'package:first_project/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer=int.parse(str);
      if(integer<0) throw const FormatException();
      return Right(integer);
      
    } on FormatException {
      return const Left(InvalidInputFailure("Invalid Integer"));
    }
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(String message) : super(message);
}
