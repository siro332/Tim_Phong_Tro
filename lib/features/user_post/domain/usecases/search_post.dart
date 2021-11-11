import 'package:dartz/dartz.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/post_preview.dart';
import 'package:tim_phong_tro/features/user_post/domain/repositories/user_post_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class SearchUserPosts
    implements UseCase<List<UserPostPreview>, SearchListPostsParam> {
  final UserPostRepository repository;

  SearchUserPosts(this.repository);

  @override
  Future<Either<Failure, List<UserPostPreview>>> call(
      SearchListPostsParam params) async {
    return await repository.searchPost(
        page: params.page,
        size: params.size,
        sortDirection: params.sortDirection,
        sortParam: params.sortParam,
        searchParams: params.searchParams);
  }
}

class SearchListPostsParam {
  final int page;
  final int size;
  final String sortParam;
  final int sortDirection;
  final List<SearchParam> searchParams;
  SearchListPostsParam(
      {required this.searchParams,
      this.page = 0,
      this.size = 3,
      this.sortDirection = 0,
      this.sortParam = "postingDate"});
}

class SearchParam {
  final String orPredicate;
  final String key;
  final String operation;
  final value;

  SearchParam(
      {required this.orPredicate,
      required this.key,
      required this.operation,
      required this.value});
  Map<String, dynamic> toJson() => {
        "orPredicate": orPredicate,
        "key": key,
        "value": value,
        "operation": operation
      };
}
