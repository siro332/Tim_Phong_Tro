import 'package:dartz/dartz.dart';
import 'package:tim_phong_tro/features/user_post/domain/usecases/search_post.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/post_preview.dart';
import '../../domain/entities/user_post.dart';
import '../../domain/repositories/user_post_repository.dart';
import '../datasources/user_post_remote_datasource.dart';

class UserPostRepositoryImplementation implements UserPostRepository {
  final UserPostRemoteDataSource remoteDataSource;
  // final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserPostRepositoryImplementation(
      {required this.remoteDataSource,
      // required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<UserPostPreview>>> getListPosts(
      {required int page,
      required int size,
      required String sortParam,
      required int sortDirection}) async {
    try {
      final listPosts = await remoteDataSource.getPostPreviewList(
          page, size, sortParam, sortDirection);
      //localDataSource.cacheUser(user);
      return Right(listPosts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserPost>> getPostDetail({required int postId}) async {
    try {
      final post = await remoteDataSource.getPostDetail(postId);
      //localDataSource.cacheUser(user);
      return Right(post);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserPostPreview>>> getUserListPosts(
      {required int page, required int size, required String uid}) async {
    try {
      final listPosts =
          await remoteDataSource.getUserListPosts(page, size, uid);
      return Right(listPosts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserPostPreview>>> searchPost(
      {required int page,
      required int size,
      required String sortParam,
      required int sortDirection,
      required List<SearchParam> searchParams}) async {
    try {
      final listPosts = await remoteDataSource.searchPost(
          page, size, sortParam, sortDirection, searchParams);
      //localDataSource.cacheUser(user);
      return Right(listPosts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserPostPreview>>> getSavedPosts(
      {required int page,
      required int size,
      required String sortParam,
      required int sortDirection,
      required String uid}) async {
    try {
      final listPosts = await remoteDataSource.getSavedPost(
          page, size, sortParam, sortDirection, uid);
      //localDataSource.cacheUser(user);
      return Right(listPosts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
