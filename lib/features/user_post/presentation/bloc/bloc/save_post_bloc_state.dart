part of 'save_post_bloc.dart';

abstract class SavePostBlocState extends Equatable {
  const SavePostBlocState([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

class NoData extends SavePostBlocState {}

class SavePostBlocInitial extends SavePostBlocState {}

class GetSavedPostsLoading extends SavePostBlocState {}

class HaveSavedPostsData extends SavePostBlocState {
  final List<UserPostPreview> listPost;
  HaveSavedPostsData({required this.listPost}) : super([listPost]);
}

class Error extends SavePostBlocState {
  final String message;

  Error({required this.message}) : super([message]);
}
