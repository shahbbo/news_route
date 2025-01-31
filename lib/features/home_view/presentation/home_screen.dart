import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/features/home_view/presentation/widgets/category_fragment.dart';
import 'package:news_app/features/home_view/presentation/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        forceMaterialTransparency: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text(AppLocalizations.of(context)!.home),
      ),
      body: const CategoryFragment()
    );
  }
}
