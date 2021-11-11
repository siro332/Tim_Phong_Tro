part of 'user_post_bloc.dart';

abstract class UserPostEvent extends Equatable {
  const UserPostEvent();

  @override
  List<Object> get props => [];
}

class GetListPostEvent extends UserPostEvent {
  final int page;
  final int size;
  final String sortParam;
  final int sortDirection;
  GetListPostEvent(
      {required this.page,
      required this.size,
      required this.sortParam,
      required this.sortDirection});
}

class GetUserListPostsEvent extends UserPostEvent {
  final int page;
  final int size;
  final String uid;
  GetUserListPostsEvent(
      {required this.page, required this.size, required this.uid});
}

class GetPostDetailEvent extends UserPostEvent {
  final int id;
  GetPostDetailEvent({required this.id});
}

class SearchPostEvent extends UserPostEvent {
  final int page;
  final int size;
  final String sortParam;
  final int sortDirection;
  final List<SearchParam> searchParams;
  SearchPostEvent(
      {required this.page,
      required this.size,
      required this.sortParam,
      required this.sortDirection,
      required this.searchParams});
}
