import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../components/post_preview_entity.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/post_preview.dart';
import '../../bloc/bloc/user_post_bloc.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  static const _pageSize = 7;
  final UserPostBloc _bloc = sl();
  int pageCount = 0;
  final PagingController<int, UserPostPreview> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener(
      (pageKey) => _bloc.add(GetListPostEvent(
          page: pageKey,
          size: _pageSize,
          sortParam: "postingDate",
          sortDirection: 1)),
    );
    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<UserPostBloc, UserPostState>(
          listener: (context, state) {
            if (state is HaveListPostData) {
              //Save record count instead of records list
              pageCount += 1;
              final isLastPage = state.listPost.length < _pageSize;
              if (isLastPage) {
                _pagingController.appendLastPage(state.listPost);
              } else {
                _pagingController.appendPage(state.listPost, pageCount);
              }
            }
            if (state is Error) {
              _pagingController.error = state.message;
            }
          },
          //Removed pagedListview from bloc builder
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () {
                  _pagingController.refresh();
                  pageCount = 0;
                },
              ),
              child: PagedListView<int, UserPostPreview>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<UserPostPreview>(
                  itemBuilder: (context, post, index) => PostPreviewEntityList(
                    property: post,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
