import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../core/app_utls/app_colors.dart';
import '../../bloc/news_cubit.dart';
import '../../data/model/news_response.dart';
import 'news_item.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key,});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  void initState() {
    var newsCubit = BlocProvider.of<NewsCubit>(context);
    super.initState();
    newsCubit.pagingController.addPageRequestListener((pageKey) {
      newsCubit.fetchPage(pageKey, newsCubit.sourceList[newsCubit.selectedIndex].id);
    });
  }
  @override
  Widget build(BuildContext context) {
    var newsCubit = BlocProvider.of<NewsCubit>(context);
    return BlocConsumer<NewsCubit, NewsState>(
  listener: (context, state) {},
  builder: (context, state) {
    return PagedListView<int, News>(
      pagingController: newsCubit.pagingController,
      builderDelegate: PagedChildBuilderDelegate<News>(
        itemBuilder: (context, article, index) {
          return NewsItem(news: article);
        },
        firstPageProgressIndicatorBuilder: (context) => const Center(
          child: CircularProgressIndicator(color: AppColors.black),
        ),
        newPageProgressIndicatorBuilder: (context) => const Center(
          child: CircularProgressIndicator(color: AppColors.black),
        ),
        noItemsFoundIndicatorBuilder: (context) => const Center(
          child: Text('No news found'),
        ),
        noMoreItemsIndicatorBuilder: (context) => const Center(
          child: Text('No more news'),
        ),
      ),
    );
  },
);
  }

  @override
  void dispose() {
    var newsCubit = BlocProvider.of<NewsCubit>(context);
    newsCubit.pagingController.dispose();
    super.dispose();
  }
}
// import 'package:flutter/material.dart';
//
// import '../../../../core/api/api_manager.dart';
// import '../../../../core/app_utls/app_colors.dart';
// import '../../data/model/news_response.dart';
// import '../../data/model/source_response.dart';
// import 'news_item.dart';
// class NewsWidget extends StatefulWidget {
//   final Source source;
//   const NewsWidget({super.key, required this.source});
//   @override
//   State<NewsWidget> createState() => _NewsWidgetState();
// }
// class _NewsWidgetState extends State<NewsWidget> {
//   final ScrollController _scrollController = ScrollController();
//   List<News> _newsList = [];
//   bool _isLoading = false;
//   int _page = 1;
//   bool _hasMore = true;
//   Source? source;
//   @override
//   void initState() {
//     super.initState();
//     source = widget.source;
//     _loadInitialData();
//     _scrollController.addListener(_scrollListener);
//   }
//   Future<void> _loadInitialData() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       print('source!.id : ${source!.id}');
//       final newNews = await ApiManager.getNewsByPaganition(source!.id ?? "", _page);
//       setState(() {
//         _newsList = newNews.articles!;
//         _isLoading = false;
//       });
//     } catch (error) {
//       setState(() {
//         _isLoading = false;
//       });
//       print('Error loading initial data: $error');
//     }
//   }
//   Future<void> _loadMoreData() async {
//     if (_isLoading || !_hasMore) return;
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       final newNews = await ApiManager.getNewsByPaganition(source!.id ?? "", _page + 1);
//       setState(() {
//         if (newNews.articles!.isEmpty) {
//           _hasMore = false;
//         } else {
//           _newsList.addAll(newNews.articles!);
//           _page++;
//         }
//         _isLoading = false;
//       });
//     } catch (error) {
//       setState(() {
//         _isLoading = false;
//       });
//       print('Error loading more data: $error');
//     }
//   }
//   void _scrollListener() {
//     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
//       _loadMoreData();
//     }
//   }
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         controller: _scrollController,
//         itemCount: _newsList.length + 1,
//         itemBuilder: (context, index) {
//           if (index == _newsList.length) {
//             return _isLoading
//                 ? const Center(
//               child: CircularProgressIndicator(color: AppColors.black),
//             )
//                 : _hasMore
//                 ? const SizedBox.shrink()
//                 : const Center(
//               child: Text('No more news'),
//             );
//           }
//           return NewsItem(news: _newsList[index]);
//         },
//       ),
//     );
//   }
// }