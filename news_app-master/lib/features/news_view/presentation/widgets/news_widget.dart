/*
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/api/api_manager.dart';
import '../../../../core/app_utls/app_colors.dart';
import '../../data/model/news_response.dart';
import '../../data/model/source_response.dart';
import 'news_item.dart';

class NewsWidget extends StatefulWidget {
  final Source source;
  const NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  final PagingController<int,News> _pagingController = PagingController(firstPageKey: 1,invisibleItemsThreshold: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newNews = await ApiManager.getNewsByPaganition(widget.source.id ?? "", pageKey);
      print('newNews.articles!.length ${newNews.articles!.length}');
      print('newNews.articles! ${newNews.articles!.toList()}');
      const pageSize = 10;
      final isLastPage = newNews.articles!.length < pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newNews.articles!);
        print('last page $pageKey');
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newNews.articles!, pageKey + 1);
        print('next page $nextPageKey');
        print('pageKey $pageKey');
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, News>(
      pagingController: _pagingController,
      // builderte: PagedChildBuilderDelegws>(
      //   itemBuilder: (context, article, index) {
      //     return NewsItem(news: article);
      //   },
      //   firstPageProgressIndicatorBuilder: (context) => const Center(
      //     child: CircularProgressIndicator(color: AppColors.black),
      //   ),
      //   newPageProgressIndicatorBuilder: (context) => const Center(
      //     child: CircularProgressIndicator(color: AppColors.black),
      //   ),
      //   noItemsFoundIndicatorBuilder: (context) => const Center(
      //     child: Text('No news found'),
      //   ),
      //   noMoreItemsIndicatorBuilder: (context) => const Center(
      //     child: Text('No more news'),
      //   ),
      // ),
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
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}*/
import 'package:flutter/material.dart';

import '../../../../core/api/api_manager.dart';
import '../../../../core/app_utls/app_colors.dart';
import '../../data/model/news_response.dart';
import '../../data/model/source_response.dart';
import 'news_item.dart';

class NewsWidget extends StatefulWidget {
  final Source source;
  const NewsWidget({super.key, required this.source});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  final ScrollController _scrollController = ScrollController();
  List<News> _newsList = [];
  bool _isLoading = false;
  int _page = 1;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final newNews = await ApiManager.getNewsByPaganition(widget.source.id ?? "", _page);
      setState(() {
        _newsList = newNews.articles!;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading initial data: $error');
    }
  }

  Future<void> _loadMoreData() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final newNews = await ApiManager.getNewsByPaganition(widget.source.id ?? "", _page + 1);
      setState(() {
        if (newNews.articles!.isEmpty) {
          _hasMore = false;
        } else {
          _newsList.addAll(newNews.articles!);
          _page++;
        }
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading more data: $error');
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
      _loadMoreData();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _newsList.length + 1,
        itemBuilder: (context, index) {
          if (index == _newsList.length) {
            return _isLoading
                ? const Center(
              child: CircularProgressIndicator(color: AppColors.black),
            )
                : _hasMore
                ? const SizedBox.shrink()
                : const Center(
              child: Text('No more news'),
            );
          }
          return NewsItem(news: _newsList[index]);
        },
      ),
    );
  }
}