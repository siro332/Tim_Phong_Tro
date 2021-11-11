import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tim_phong_tro/core/error/failure.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/post_preview.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/user_post.dart';
import 'package:tim_phong_tro/features/user_post/domain/usecases/get_list_posts.dart';
import 'package:tim_phong_tro/features/user_post/domain/usecases/get_post_detail.dart';
import 'package:tim_phong_tro/features/user_post/domain/usecases/search_post.dart';

import '../../../../../constants.dart';

part 'user_post_event.dart';
part 'user_post_state.dart';

class UserPostBloc extends Bloc<UserPostEvent, UserPostState> {
  final GetListUserPosts getListPost;
  final GetPostDetail getPostDetail;
  final SearchUserPosts searchUserPosts;
  UserPostBloc({
    required this.getListPost,
    required this.getPostDetail,
    required this.searchUserPosts,
  }) : super(NoData());

  @override
  Stream<UserPostState> mapEventToState(UserPostEvent event) async* {
    if (event is GetListPostEvent) {
      if (event.page == 0) {
        yield FirstPageLoading();
        final getData = await getListPost(new GetListPostsParam(
            page: event.page,
            size: event.size,
            sortDirection: event.sortDirection,
            sortParam: event.sortParam));
        yield getData.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (getData) => HaveListPostData(listPost: getData));
      } else {
        yield OtherPageLoading();
        final getData = await getListPost(new GetListPostsParam(
            page: event.page,
            size: event.size,
            sortDirection: event.sortDirection,
            sortParam: event.sortParam));
        yield getData.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (getData) => HaveListPostData(listPost: getData));
      }
    } else if (event is GetPostDetailEvent) {
      yield PostDetailLoading();
      final getData =
          await getPostDetail(new GetPostDetailParams(postId: event.id));
      yield getData.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (getData) => HavePostDetailData(userPost: getData));
    } else if (event is GetUserListPostsEvent) {
      yield UserListPostsLoading();
      final getData = await getListPost(new GetListPostsParam(
        page: event.page,
        size: event.size,
      ));
      yield getData.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (getData) => HaveUserListPostsData(listPost: getData));
    } else if (event is SearchPostEvent) {
      yield SearchPostsLoading();
      final getData = await searchUserPosts(new SearchListPostsParam(
          searchParams: event.searchParams,
          page: event.page,
          size: event.size,
          sortDirection: event.sortDirection,
          sortParam: event.sortParam));
      yield getData.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (getData) => HaveSearchData(listPost: getData));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return kNetworkError;
      case AuthFailure:
        AuthFailure authFailure = failure as AuthFailure;
        return authFailure.message;
      default:
        return "Unexpected Error";
    }
  }
}
