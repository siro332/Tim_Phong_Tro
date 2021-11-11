import 'package:dartz/dartz.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/post_preview.dart';
import 'package:tim_phong_tro/features/user_post/domain/repositories/user_post_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class GetUserListPosts
    implements UseCase<List<UserPostPreview>, GetUserListPostsParam> {
  final UserPostRepository repository;

  GetUserListPosts(this.repository);

  @override
  Future<Either<Failure, List<UserPostPreview>>> call(
      GetUserListPostsParam params) async {
    return await repository.getUserListPosts(
        page: params.page, size: params.size, uid: params.uid);
  }
}

class GetUserListPostsParam {
  final int page;
  final int size;
  final String uid;
  GetUserListPostsParam({this.page = 0, this.size = 3, required this.uid});
}
