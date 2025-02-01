import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/home_view/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_utls/app_styles.dart';
import '../../data/model/source_response.dart';

class SourceNameWidget extends StatelessWidget {
  final bool isSelected;
  final Source source;

  const SourceNameWidget({super.key, required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    return Text(
      source.name ?? '',
      style: isSelected
          ? AppStyle.black16medium.copyWith(
        color: themeProvider.appTheme == ThemeMode.light
            ? Colors.black
            : Colors.white,
      )
          : AppStyle.blue16medium.copyWith(
        color: themeProvider.appTheme == ThemeMode.light
            ? Colors.black
            : Colors.white,
      ),
    );
  }
}
