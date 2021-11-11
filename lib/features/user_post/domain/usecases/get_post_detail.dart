import 'package:dartz/dartz.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/user_post.dart';
import 'package:tim_phong_tro/features/user_post/domain/repositories/user_post_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class GetPostDetail implements UseCase<UserPost, GetPostDetailParams> {
  final UserPostRepository repository;

  GetPostDetail(this.repository);

  @override
  Future<Either<Failure, UserPost>> call(GetPostDetailParams params) async {
    return await repository.getPostDetail(postId: params.postId);
  }
}

class GetPostDetailParams {
  final int postId;
  GetPostDetailParams({required this.postId});
}
