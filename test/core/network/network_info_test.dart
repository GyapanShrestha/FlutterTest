import 'package:first_project/core/network/network_info.dart';

import '../../helper/test_helper.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp((){
    mockDataConnectionChecker=MockDataConnectionChecker();
    networkInfoImpl=NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected',(){
    test('should forward the call to DataConnectionChecker.hasConnection', ()async{
      //arrange 
      final tHasConnectionFuture = Future.value(true);
      when(mockDataConnectionChecker.hasConnection).thenAnswer((_) =>tHasConnectionFuture );

      final result =  networkInfoImpl.isConnected;

      verify(mockDataConnectionChecker.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}