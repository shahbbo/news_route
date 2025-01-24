import 'package:flutter/material.dart';
import 'package:news_app/features/home_view/presentation/widgets/drawer.dart';
import 'package:news_app/features/news_view/data/model/source_response.dart';
import 'package:news_app/features/news_view/presentation/widgets/search_bar.dart';
import 'package:news_app/features/news_view/presentation/widgets/source_tab_widget.dart';

import '../../../core/api/api_manager.dart';
import '../../../core/app_utls/app_colors.dart';
import '../../home_view/data/model/CategoryModel.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key,});

  static const String routeName = 'news_screen';

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  int selectedIndex = 0;

  List<Source> sourceList = [];
  @override
  Widget build(BuildContext context) {
    CategoryModel category = ModalRoute.of(context)!.settings.arguments as CategoryModel;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        forceMaterialTransparency: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text(category.title),
        actions: [
          SearchBarr(sourceList: sourceList, sourceNumber: selectedIndex,),
        ],
      ),
      body: FutureBuilder(
          future: ApiManager.getSources(category.id),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.black,
                ),);
            }else if (snapshot.hasError){
              return Column(
                children: [
                  const Text('Something went wrong'),
                  ElevatedButton(
                      onPressed: (){
                        ApiManager.getSources(category.id);
                        setState(() {});
                      },
                      child: const Text('Try Again'))
                ],
              );
            }
            if (snapshot.data!.status == 'error'){
              return Column(
                children: [
                  Text(snapshot.data!.message!),
                  ElevatedButton(
                      onPressed: (){
                        ApiManager.getSources(category.id);
                        setState(() {});
                      },
                      child: const Text('Try Again'))
                ],
              );
            }
            sourceList = snapshot.data!.sources ?? [];
            return SourceTabWidget(sourceList: sourceList, selectedIndex: selectedIndex);
          }),
    );
  }
}
