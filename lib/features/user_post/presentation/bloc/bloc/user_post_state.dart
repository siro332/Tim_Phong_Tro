part of 'user_post_bloc.dart';

abstract class UserPostState extends Equatable {
  const UserPostState([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class UserPostInitial extends UserPostState {}

class NoData extends UserPostState {}

class FirstPageLoading extends UserPostState {}

class OtherPageLoading extends UserPostState {}

class PostDetailLoading extends UserPostState {}

class HaveListPostData extends UserPostState {
  final List<UserPostPreview> listPost;
  HaveListPostData({required this.listPost}) : super([listPost]);
}

class HavePostDetailData extends UserPostState {
  final UserPost userPost;
  HavePostDetailData({required this.userPost}) : super([userPost]);
}

class UserListPostsLoading extends UserPostState {}

class HaveUserListPostsData extends UserPostState {
  final List<UserPostPreview> listPost;
  HaveUserListPostsData({required this.listPost}) : super([listPost]);
}

class SearchPostsLoading extends UserPostState {}

class HaveSearchData extends UserPostState {
  final List<UserPostPreview> listPost;
  HaveSearchData({required this.listPost}) : super([listPost]);
}

class Error extends UserPostState {
  final String message;

  Error({required this.message}) : super([message]);
}
