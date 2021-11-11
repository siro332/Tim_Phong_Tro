import 'package:dartz/dartz.dart';
import 'package:tim_phong_tro/core/error/failure.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/post_preview.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/user_post.dart';
import 'package:tim_phong_tro/features/user_post/domain/usecases/search_post.dart';

abstract class UserPostRepository {
  Future<Either<Failure, List<UserPostPreview>>> getListPosts(
      {required int page,
      required int size,
      required String sortParam,
      required int sortDirection});
  Future<Either<Failure, UserPost>> getPostDetail({required int postId});
  Future<Either<Failure, List<UserPostPreview>>> getUserListPosts({
    required int page,
    required int size,
    required String uid,
  });
  Future<Either<Failure, List<UserPostPreview>>> searchPost(
      {required int page,
      required int size,
      required String sortParam,
      required int sortDirection,
      required List<SearchParam> searchParams});
  Future<Either<Failure, List<UserPostPreview>>> getSavedPosts(
      {required int page,
      required int size,
      required String sortParam,
      required int sortDirection,
      required String uid});
}
