import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/home_view/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../core/app_utls/app_colors.dart';
import '../../../../../core/app_utls/app_styles.dart';
import '../../data/model/news_response.dart';

class NewsItem extends StatefulWidget {
  final  News news;
  const NewsItem({super.key,
    required this.news
});

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {

  late final WebViewController controller = WebViewController();

  @override
  void initState() {
    super.initState();
    controller..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.news.url!));
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    bool isLight = themeProvider.appTheme == ThemeMode.light;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: height *0.02,
        horizontal: width*0.02
      ),
      margin:  EdgeInsets.symmetric(
          vertical: height *0.02,
          horizontal: width*0.02
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).indicatorColor,
          width: 2,
        )
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child:
            CachedNetworkImage(
              imageUrl: widget.news.urlToImage??"",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(child: CircularProgressIndicator(
                    color: AppColors.gray,
                      value: downloadProgress.progress)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          SizedBox(height: height*0.02,),
          Text(widget.news.title??'', style: AppStyle.black16medium.copyWith(
            color: isLight ? AppColors.black : AppColors.white
          ),),
          SizedBox(height: height*0.02,),
          Row(
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(widget.news.author??" ", style: AppStyle.white14medium.copyWith(
                color: AppColors.gray
              ))),
              Text(widget.news.publishedAt??"", style: AppStyle.white14medium.copyWith(
                color: AppColors.gray
              ))
            ],
          ),
          SizedBox(height: height*0.02,),
          ElevatedButton(
              onPressed: (){
                setState(() {
                  Navigator.pushNamed(context, 'web-view', arguments: controller);
                });
              },
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                padding: const WidgetStatePropertyAll(EdgeInsets.only(top: 16, bottom: 16, left: 70, right: 70)),
                backgroundColor: WidgetStatePropertyAll(isLight ? AppColors.black : AppColors.white),
              ),
              child: Text('View Full Article',style: AppStyle.black20w500.copyWith(
                color: isLight ? AppColors.white : AppColors.black
              ),))
        ],
      ),
    );
  }
}
