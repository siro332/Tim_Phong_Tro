part of 'save_post_bloc.dart';

abstract class SavePostBlocEvent extends Equatable {
  const SavePostBlocEvent();

  @override
  List<Object> get props => [];
}

class GetSavedPostsEvent extends SavePostBlocEvent {
  final int page;
  final int size;
  final String sortParam;
  final int sortDirection;
  final String uid;
  GetSavedPostsEvent(
      {required this.page,
      required this.size,
      required this.sortParam,
      required this.sortDirection,
      required this.uid});
}
