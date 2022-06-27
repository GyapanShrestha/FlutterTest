import 'dart:math';

import 'package:first_project/core/util/input_converter.dart';

import '../../helper/test_helper.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

void main() {
  late InputConverter inputConverter;

  setUp((){
    inputConverter=InputConverter();
  });
  group('stringToUnsignedInt', (){
    test('should return an integer when the string represents an unsugned integer',() async{

      const str="123";

      final result=inputConverter.stringToUnsignedInteger(str);

      expect(result, const Right(123));

    });

    test('should return failure when not an integer',() async{

      const str="abc";

      final result=inputConverter.stringToUnsignedInteger(str);

      expect(result, const Left(InvalidInputFailure("Invalid Integer")));

    });
     test('should return failure when string is negative integer',() async{

      const str="-123";

      final result=inputConverter.stringToUnsignedInteger(str);

      expect(result, const Left(InvalidInputFailure("Invalid Integer")));

    });
  });
}

