import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home_view/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/api/api_manager.dart';
import '../../../../core/app_utls/app_colors.dart';
import '../../bloc/news_cubit.dart';
import '../../data/model/news_response.dart';
import '../../data/model/source_response.dart';
import 'news_item.dart';

class SearchBarr extends StatefulWidget {
  const SearchBarr({super.key});

  @override
  State<SearchBarr> createState() => _SearchBarrState();
}

class _SearchBarrState extends State<SearchBarr> {
  SearchController searchControllerr = SearchController();

  @override
  Widget build(BuildContext context) {
    NewsCubit newsCubit = BlocProvider.of<NewsCubit>(context);
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    return SearchAnchor(
      viewBackgroundColor: themeProvider.appTheme == ThemeMode.light
          ? Colors.white
          : Colors.black,
      searchController: searchControllerr,
      viewElevation: 4.0,
      viewHintText: 'ابحث هنا...',
      textInputAction: TextInputAction.search,
      headerHintStyle: TextStyle(
        color: themeProvider.appTheme == ThemeMode.light
            ? Colors.black
            : Colors.white,
      ),
      headerTextStyle: TextStyle(
        color: themeProvider.appTheme == ThemeMode.light
            ? Colors.black
            : Colors.white,
      ),
      // viewBuilder: const TextField(),
      viewLeading: Icon(Icons.search,
          color: themeProvider.appTheme == ThemeMode.light
              ? Colors.black
              : Colors.white),
      viewTrailing: [
        IconButton(
          icon: Icon(Icons.close,
              color: themeProvider.appTheme == ThemeMode.light
                  ? Colors.black
                  : Colors.white),
          onPressed: () {
            searchControllerr.closeView('');
          },
        ),
      ],
      builder: (BuildContext context, searchControllerr) {
        return IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            if (searchControllerr.isOpen) {
              searchControllerr.closeView('');
            } else {
              searchControllerr.openView();
            }
          },
        );
      },
      suggestionsBuilder: (BuildContext context, searchControllerr) {
        return [
          const SizedBox(
            height: 15,
          ),
          FutureBuilder<NewsResponse>(
            future: ApiManager.getNewsBySourceId(newsCubit.sourceList[newsCubit.selectedIndex].id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.black,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    children: [
                      const Text('حدث خطأ ما'),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: const Text('حاول مرة أخرى'),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.data!.status != 'ok') {
                return Center(
                  child: Column(
                    children: [
                      Text(snapshot.data!.message!),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: const Text('حاول مرة أخرى'),
                      ),
                    ],
                  ),
                );
              }
              var newsList = snapshot.data!.articles!;
              final filteredNews = newsList.where((news) {
                final query = searchControllerr.text.toLowerCase();
                return news.title!.toLowerCase().contains(query) ||
                    news.description!.toLowerCase().contains(query);
              }).toList();
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.88,
                child: ListView.builder(
                  itemCount: filteredNews.length,
                  itemBuilder: (context, index) {
                    return NewsItem(news: filteredNews[index]);
                  },
                ),
              );
            },
          ),
        ];
      },
    );
  }
}
