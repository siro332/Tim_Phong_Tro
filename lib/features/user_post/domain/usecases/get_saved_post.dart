import 'package:dartz/dartz.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/post_preview.dart';
import 'package:tim_phong_tro/features/user_post/domain/repositories/user_post_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class GetSavedPosts
    implements UseCase<List<UserPostPreview>, GetSavedPostsParam> {
  final UserPostRepository repository;

  GetSavedPosts(this.repository);

  @override
  Future<Either<Failure, List<UserPostPreview>>> call(
      GetSavedPostsParam params) async {
    return await repository.getSavedPosts(
        page: params.page,
        size: params.size,
        sortDirection: params.sortDirection,
        sortParam: params.sortParam,
        uid: params.uid);
  }
}

class GetSavedPostsParam {
  final int page;
  final int size;
  final String sortParam;
  final int sortDirection;
  final String uid;
  GetSavedPostsParam(
      {this.page = 0,
      this.size = 3,
      this.sortDirection = 0,
      this.sortParam = "postingDate",
      required this.uid});
}
