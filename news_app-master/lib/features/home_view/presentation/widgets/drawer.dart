import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/features/home_view/presentation/home_screen.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_utls/app_colors.dart';
import '../../../../core/app_utls/app_styles.dart';
import '../../provider/language_provider.dart';
import '../../provider/theme_provider.dart';



class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Drawer(
      backgroundColor: AppColors.black,
      width: width * 0.7,
      child: Column(
        children: [
          Container(
            color: AppColors.white,
            height: height * 0.23,
            child: Center(
                child: Text(
              AppLocalizations.of(context)!.newsApp,
              style: AppStyle.black20w500,
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                InkWell(
                  onTap: () {
                      Navigator.popUntil(context, ModalRoute.withName(HomeScreen.routeName));
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.01,
                      ),
                      const Icon(
                        Icons.home_filled,
                        color: AppColors.white,
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Text(
                        AppLocalizations.of(context)!.goToHome,
                        style: AppStyle.white20medium,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Divider(
                  color: AppColors.white,
                  thickness: 1,
                  indent: width * 0.02,
                  endIndent: width * 0.05,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.01,
                    ),
                    const Icon(
                      Icons.format_paint,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style: AppStyle.white20medium,
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.white,
                      width: 2,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: themeProvider.appTheme == ThemeMode.dark
                            ? 'dark'
                            : 'light',
                        isExpanded: true,
                        dropdownColor: AppColors.black,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.white,
                          size: 35,
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'light',
                            child: Text(
                              AppLocalizations.of(context)!.light,
                              style: AppStyle.black20w500
                                  .copyWith(color: AppColors.white),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'dark',
                            child: Text(
                              AppLocalizations.of(context)!.dark,
                              style: AppStyle.black20w500
                                  .copyWith(color: AppColors.white),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            themeProvider.changeAppTheme(value == 'dark' ? ThemeMode.dark : ThemeMode.light);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Divider(
                  color: AppColors.white,
                  thickness: 1,
                  indent: width * 0.02,
                  endIndent: width * 0.05,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.01,
                    ),
                    const Icon(
                      Icons.sports_basketball_outlined,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: AppStyle.white20medium,
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.white,
                      width: 2,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: languageProvider.appLanguage,
                        isExpanded: true,
                        dropdownColor: AppColors.black,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.white,
                          size: 35,
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'en',
                            child: Text(
                              AppLocalizations.of(context)!.english,
                              style: AppStyle.black20w500
                                  .copyWith(color: AppColors.white),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'ar',
                            child: Text(
                              AppLocalizations.of(context)!.arabic,
                              style: AppStyle.black20w500
                                  .copyWith(color: AppColors.white),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            languageProvider.changeAppLanguage(value!);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
