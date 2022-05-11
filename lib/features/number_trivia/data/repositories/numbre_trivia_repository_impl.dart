import 'package:first_project/core/error/exceptions.dart';
import 'package:first_project/core/platform/network_info.dart';
import 'package:first_project/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:first_project/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:first_project/features/number_trivia/domain/enitities/number_trivia.dart';
import 'package:first_project/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:first_project/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRespository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia =
            await remoteDataSource.getConcreteNumberTrivia(number);
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return const Left(CacheFailure('Cache Failure'));
      }
    }
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia =
            await remoteDataSource.getRandomNumberTrivia();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return const Left(CacheFailure('Cache Failure'));
      }
    }
  }
}
