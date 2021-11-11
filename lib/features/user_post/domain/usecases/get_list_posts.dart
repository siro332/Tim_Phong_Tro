import 'package:dartz/dartz.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/post_preview.dart';
import 'package:tim_phong_tro/features/user_post/domain/repositories/user_post_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class GetListUserPosts
    implements UseCase<List<UserPostPreview>, GetListPostsParam> {
  final UserPostRepository repository;

  GetListUserPosts(this.repository);

  @override
  Future<Either<Failure, List<UserPostPreview>>> call(
      GetListPostsParam params) async {
    return await repository.getListPosts(
        page: params.page,
        size: params.size,
        sortDirection: params.sortDirection,
        sortParam: params.sortParam);
  }
}

class GetListPostsParam {
  final int page;
  final int size;
  final String sortParam;
  final int sortDirection;
  GetListPostsParam(
      {this.page = 0,
      this.size = 3,
      this.sortDirection = 0,
      this.sortParam = "postingDate"});
}
