/*
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../core/api/api_manager.dart';
import '../data/model/news_response.dart';
import '../data/model/source_response.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;
  List<Source> sourceList = [];
  final PagingController<int, News> pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 1);

  void changeSelectedIndex(int index) {
    selectedIndex = index;
    pagingController.refresh();
    emit(NewsChangeSelectedIndex());
  }

  Future<void> fetchPage(int pageKey, sourceId) async {
    try {
      emit(NewsLoading());
      print(
          'sourceList[selectedIndex].id in fetchPage : ${sourceList[selectedIndex].id}');
      final newNews =
          await ApiManager.getNewsByPaganition(sourceId ?? "", pageKey);
      emit(NewsSuccess(newNews.articles!));
      print('newNews.articles!.length ${newNews.articles!.length}');
      print('newNews.articles! ${newNews.articles!.toList()}');
      const pageSize = 10;
      final isLastPage = newNews.articles!.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newNews.articles!);
        print('last page $pageKey');
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newNews.articles!, pageKey + 1);
        emit(NewsSuccess(newNews.articles!));
        print('next page $nextPageKey');
        print('pageKey $pageKey');
      }
    } catch (error) {
      pagingController.error = error;
      emit(NewsError(error.toString()));
    }
  }
}
*/


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../data/model/news_response.dart';
import '../data/model/source_response.dart';
import '../data/repo/news_repo.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository newsRepository;
  NewsCubit({required this.newsRepository}) : super(NewsInitial());

  static NewsCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;
  List<Source> sourceList = [];
  final PagingController<int, News> pagingController = PagingController(firstPageKey: 1, invisibleItemsThreshold: 1);

  void changeSelectedIndex(int index) {
    selectedIndex = index;
    pagingController.refresh();
    emit(NewsChangeSelectedIndex());
  }
  Future<void> fetchPage(int pageKey, String? sourceId) async {
    try {
      emit(NewsLoading());
      final newNews = await newsRepository.getNewsByPagination(sourceId ?? "", pageKey);
      const pageSize = 10;
      final isLastPage = newNews.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newNews);
      } else {
        pagingController.appendPage(newNews, pageKey + 1);
      }
      emit(NewsSuccess(newNews));
    } catch (error) {
      pagingController.error = error;
      emit(NewsError(error.toString()));
    }
  }
}