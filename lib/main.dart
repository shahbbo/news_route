import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news_view/presentation/news_screen.dart';
import 'package:news_app/features/news_view/presentation/web_view_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/app_utls/app_theme.dart';
import 'features/home_view/bloc/home__cubit.dart';
import 'features/home_view/presentation/home_screen.dart';
import 'features/home_view/provider/language_provider.dart';
import 'features/home_view/provider/theme_provider.dart';
import 'features/news_view/bloc/news_cubit.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => HomeCubit()),
      BlocProvider(create: (context) => NewsCubit()),
    ],
    child: MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
      ChangeNotifierProvider(create: (context) => AppThemeProvider()),
    ], child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          NewsScreen.routeName: (context) => const NewsScreen(),
          WebViewPage.routeName: (context) => const WebViewPage(),
        },
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeProvider.appTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(languageProvider.appLanguage));
  }
}


