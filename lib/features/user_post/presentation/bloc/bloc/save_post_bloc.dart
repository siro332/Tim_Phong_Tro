import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tim_phong_tro/core/error/failure.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/post_preview.dart';
import 'package:tim_phong_tro/features/user_post/domain/usecases/get_saved_post.dart';

import '../../../../../constants.dart';

part 'save_post_bloc_event.dart';
part 'save_post_bloc_state.dart';

class SavePostBloc extends Bloc<SavePostBlocEvent, SavePostBlocState> {
  final GetSavedPosts getSavedPosts;
  SavePostBloc({required this.getSavedPosts}) : super(NoData());
  @override
  Stream<SavePostBlocState> mapEventToState(SavePostBlocEvent event) async* {
    if (event is GetSavedPostsEvent) {
      yield GetSavedPostsLoading();
      final getData = await getSavedPosts(new GetSavedPostsParam(
          uid: event.uid,
          page: event.page,
          size: event.size,
          sortDirection: event.sortDirection,
          sortParam: event.sortParam));
      yield getData.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (getData) => HaveSavedPostsData(listPost: getData));
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
