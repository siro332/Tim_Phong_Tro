import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tim_phong_tro/components/post_preview_entity.dart';
import 'package:tim_phong_tro/constants.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/post_preview.dart';
import 'package:tim_phong_tro/features/user_post/domain/usecases/search_post.dart';
import 'package:tim_phong_tro/features/user_post/presentation/bloc/bloc/user_post_bloc.dart';
import 'package:tim_phong_tro/features/user_post/presentation/screens/search_screen/price_filter.dart';
import 'package:tim_phong_tro/features/user_post/presentation/screens/search_screen/room_type_filter.dart';
import 'package:tim_phong_tro/features/user_post/presentation/screens/search_screen/sort_by_filter.dart';

import '../../../../../injection_container.dart';
import 'capacity_filter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static String routeName = "/search";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const _pageSize = 7;
  final UserPostBloc _bloc = sl();
  int pageCount = 0;
  String sortParam = "postingDate";
  int sortDirection = 0;
  String search = "";
  RangeValues rangeValues = RangeValues(0, 0);
  String roomTypes = "";
  int capacity = 0;
  List<SearchParam> searchParams = [];
  final PagingController<int, UserPostPreview> _pagingController =
      PagingController(firstPageKey: 0);
  List<bool> filterIsSeleted = [false, false, false, false, false];

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) => _bloc.add(
        SearchPostEvent(
            page: pageKey,
            size: _pageSize,
            sortParam: sortParam,
            sortDirection: sortDirection,
            searchParams: searchParams)));
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
              child: Container(
                height: 60.0,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      search = value;
                      pageCount = 0;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () => submit(),
                      child: Icon(
                        Icons.search,
                        color: kPrimaryColor,
                      ),
                    ),
                    hintText: 'Search by post name or by street, ward, distric',
                    hintStyle: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      child: Stack(
                        children: [
                          ListView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: [
                              SizedBox(
                                width: 24,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    RangeValues? range =
                                        await _showPriceBottomSheet();
                                    if (range != null) {
                                      setState(() {
                                        rangeValues = range;
                                        filterIsSeleted[0] = true;
                                        pageCount = 0;
                                      });
                                    } else {
                                      setState(() {
                                        filterIsSeleted[0] = false;
                                        pageCount = 0;
                                      });
                                    }
                                  },
                                  child:
                                      buildFilter("Price", filterIsSeleted[0])),
                              GestureDetector(
                                  onTap: () async {
                                    String? type =
                                        await _showRoomtypeBottomSheet();
                                    if (type != "" && type != null) {
                                      print(type);
                                      setState(() {
                                        roomTypes = type;
                                        filterIsSeleted[1] = true;
                                        pageCount = 0;
                                      });
                                    } else {
                                      setState(() {
                                        roomTypes = "";
                                        filterIsSeleted[1] = false;
                                        pageCount = 0;
                                      });
                                    }
                                  },
                                  child: buildFilter(
                                      "Room Type", filterIsSeleted[1])),
                              GestureDetector(
                                  onTap: () async {
                                    int? capa =
                                        await _showCapacityBottomSheet();
                                    if (capa != null && capa != 0) {
                                      print(capa.toString());
                                      setState(() {
                                        capacity = capa;
                                        filterIsSeleted[2] = true;
                                        pageCount = 0;
                                      });
                                    } else {
                                      setState(() {
                                        filterIsSeleted[2] = false;
                                        pageCount = 0;
                                      });
                                    }
                                  },
                                  child: buildFilter(
                                      "Capacity", filterIsSeleted[2])),
                              GestureDetector(
                                  onTap: () async {
                                    String? sort =
                                        await _showSortByBottomSheet();
                                    if (sort != null && sort != "") {
                                      print(sort);
                                      setState(() {
                                        filterIsSeleted[3] = true;
                                        sortParam = sort.split(";")[0];
                                        sortDirection =
                                            int.parse(sort.split(";")[1]);
                                        pageCount = 0;
                                      });
                                    } else {
                                      setState(() {
                                        filterIsSeleted[3] = false;
                                        sortDirection = 0;
                                        sortParam = "postingDate";
                                        pageCount = 0;
                                      });
                                    }
                                  },
                                  child: buildFilter(
                                      "Sort by", filterIsSeleted[3])),
                              SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 28,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    Theme.of(context).scaffoldBackgroundColor,
                                    Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withOpacity(0.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 24),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          for (int i = 0; i < filterIsSeleted.length; i++) {
                            filterIsSeleted[i] = false;
                          }
                          pageCount = 0;
                          sortParam = "postingDate";
                          sortDirection = 0;
                          search = "";
                          rangeValues = RangeValues(0, 0);
                          roomTypes = "";
                          capacity = 0;
                        });
                      },
                      child: Text(
                        "Clear All",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
      backgroundColor: Colors.white,
      body:

          // Expanded(
          //     child: Container(
          //         padding: EdgeInsets.symmetric(horizontal: 20),
          //         child: ListRooms(properties: properties))),
          BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<UserPostBloc, UserPostState>(
          listener: (context, state) {
            if (state is HaveSearchData) {
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

  Widget buildFilter(String filterName, bool selected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          border: Border.all(
            color: selected ? kPrimaryColor : Color(0xFF000000),
            width: 1,
          )),
      child: Center(
        child: Text(
          filterName,
          style: TextStyle(
            color: selected ? kPrimaryColor : Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<RangeValues?> _showPriceBottomSheet() async {
    return await showModalBottomSheet<RangeValues>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              PriceFilter(),
            ],
          );
        });
  }

  Future<String?> _showRoomtypeBottomSheet() async {
    return await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              RoomTypeFilter(),
            ],
          );
        });
  }

  Future<int?> _showCapacityBottomSheet() async {
    return await showModalBottomSheet<int>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              CapacityFilter(),
            ],
          );
        });
  }

  Future<String?> _showSortByBottomSheet() async {
    return await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              SortByFilter(),
            ],
          );
        });
  }

  void submit() {
    searchParams.clear();
    if (search != "") {
      searchParams.add(
        new SearchParam(
            orPredicate: "",
            key: "name",
            operation: ":",
            value: "*" + search + "*"),
      );
      searchParams.add(
        new SearchParam(
            orPredicate: "'",
            key: "roomInfo.address.streetName",
            operation: ":",
            value: "*" + search + "*"),
      );
      searchParams.add(
        new SearchParam(
            orPredicate: "'",
            key: "roomInfo.address.ward.name",
            operation: ":",
            value: "*" + search + "*"),
      );
    }
    if (rangeValues.start != 0 && rangeValues.end != 0) {
      searchParams.add(
        new SearchParam(
            orPredicate: "",
            key: "roomInfo.rentalPrice",
            operation: ">=",
            value: rangeValues.start.toInt()),
      );
      searchParams.add(
        new SearchParam(
            orPredicate: "",
            key: "roomInfo.rentalPrice",
            operation: "<",
            value: rangeValues.end.toInt()),
      );
    }
    if (roomTypes != "") {
      searchParams.add(new SearchParam(
          orPredicate: "",
          key: "roomInfo.roomType.name",
          operation: ":",
          value: roomTypes));
    }
    if (capacity != 0) {
      searchParams.add(new SearchParam(
          orPredicate: "",
          key: "roomInfo.capacity",
          operation: ":",
          value: capacity));
    } else if (capacity >= 4) {
      searchParams.add(new SearchParam(
          orPredicate: "",
          key: "roomInfo.capacity",
          operation: ">=",
          value: capacity));
    }
    _pagingController.refresh();
  }
}
