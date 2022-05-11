import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:first_project/core/error/exceptions.dart';
import 'package:first_project/core/error/failures.dart';
import 'package:first_project/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:first_project/features/number_trivia/domain/enitities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';
import 'package:first_project/features/number_trivia/data/repositories/numbre_trivia_repository_impl.dart';

void main() {
  late NumberTriviaRepositoryImpl repository;
  late MockNumberTriviaLocalDataSource mockLocalDataSource;
  late MockNumberTriviaRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  setUp(() {
    mockLocalDataSource = MockNumberTriviaLocalDataSource();
    mockRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTrivalModel =
        NumberTriviaModel(number: tNumber, text: 'Test trivia');
    final NumberTrivia tNumerTriva = tNumberTrivalModel;
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      final result = await mockNetworkInfo.isConnected;
      // assert
      expect(result, true);
    });
    void runTestsOnline(Function body) {
      group('device is online', () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });
        body();
      });
    }

    void runTestsOffline(Function body) {
      group('device is offline', () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });
        body();
      });
    }

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTrivalModel);
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        expect(result, equals(Right(tNumerTriva)));
      });
      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTrivalModel);
        //act
        await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTrivalModel));
      });
      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(const Left(ServerFailure('Server Failure'))));
      });
    });

    runTestsOffline(() {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test(
          'should return last locally cached data when the cache data is present',
          () async {
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTrivalModel);
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Right(tNumerTriva)));
      });
      test('should return cache failure when the cache data is not present',
          () async {
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        //act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(const Left(CacheFailure('Cache Failure'))));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTrivalModel =
        NumberTriviaModel(number: 1, text: 'Test trivia');
    final NumberTrivia tNumerTriva = tNumberTrivalModel;
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      final result = await mockNetworkInfo.isConnected;
      // assert
      expect(result, true);
    });
    void runTestsOnline(Function body) {
      group('device is online R', () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });
        body();
      });
    }

    void runTestsOffline(Function body) {
      group('device is offline R', () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        });
        body();
      });
    }

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTrivalModel);
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        expect(result, equals(Right(tNumerTriva)));
      });
      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTrivalModel);
        //act
        await repository.getRandomNumberTrivia();
        //assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTrivalModel));
      });
      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenThrow(ServerException());
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(const Left(ServerFailure('Server Failure'))));
      });
    });

    runTestsOffline(() {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test(
          'should return last locally cached data when the cache data is present',
          () async {
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTrivalModel);
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Right(tNumerTriva)));
      });
      test('should return cache failure when the cache data is not present',
          () async {
        //arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        //act
        final result = await repository.getRandomNumberTrivia();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(const Left(CacheFailure('Cache Failure'))));
      });
    });
  });
}
