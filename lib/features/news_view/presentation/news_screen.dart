import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home_view/presentation/widgets/drawer.dart';
import 'package:news_app/features/news_view/bloc/news_cubit.dart';
import 'package:news_app/features/news_view/presentation/widgets/news_widget.dart';
import 'package:news_app/features/news_view/presentation/widgets/search_bar.dart';
import 'package:news_app/features/news_view/presentation/widgets/source_tab_widget.dart';

import '../../../core/api/api_manager.dart';
import '../../../core/app_utls/app_colors.dart';
import '../../home_view/data/model/CategoryModel.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({
    super.key,
  });

  static const String routeName = 'news_screen';

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    var newsCubit = BlocProvider.of<NewsCubit>(context);
    CategoryModel category = ModalRoute.of(context)!.settings.arguments as CategoryModel;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        forceMaterialTransparency: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text(category.title),
        actions: const [SearchBarr(),],
      ),
      body: FutureBuilder(
          future: ApiManager.getSources(category.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.black,
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  const Text('Something went wrong'),
                  ElevatedButton(
                      onPressed: () {
                        ApiManager.getSources(category.id);
                        setState(() {});
                      },
                      child: const Text('Try Again'))
                ],
              );
            }
            if (snapshot.data!.status == 'error') {
              return Column(
                children: [
                  Text(snapshot.data!.message!),
                  ElevatedButton(
                      onPressed: () {
                        ApiManager.getSources(category.id);
                        setState(() {});
                      },
                      child: const Text('Try Again'))
                ],
              );
            }
            newsCubit.sourceList = snapshot.data!.sources ?? [];
            return const Column(
              children: [
                SourceTabWidget(),
                Expanded(child: NewsWidget())
              ],
            );
          }),
    );
  }
}
