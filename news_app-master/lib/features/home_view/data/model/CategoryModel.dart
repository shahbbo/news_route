import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/app_utls/assets_manager.dart';

class CategoryModel {
  String id;
  String title;
  String imagePath;

  CategoryModel({
    required this.id,
    required this.title,
    required this.imagePath,
  });

  static List<CategoryModel> getCategoriesList(BuildContext context) {
    return [
      CategoryModel(
          id: 'general',
          title: AppLocalizations.of(context)!.general,
          imagePath: AssetsManager.generalDark),
      CategoryModel(
          id: 'business',
          title: AppLocalizations.of(context)!.business,
          imagePath: AssetsManager.businessDark),
      CategoryModel(
          id: 'sports',
          title: AppLocalizations.of(context)!.sports,
          imagePath: AssetsManager.sportDark),
      CategoryModel(
          id: 'technology',
          title: AppLocalizations.of(context)!.technology,
          imagePath: AssetsManager.technologyDark),
      CategoryModel(
          id: 'science',
          title: AppLocalizations.of(context)!.science,
          imagePath: AssetsManager.scienceDark),
      CategoryModel(
          id: 'health',
          title: AppLocalizations.of(context)!.health,
          imagePath: AssetsManager.healthDark),
      CategoryModel(
          id: 'entertainment',
          title: AppLocalizations.of(context)!.entertainment,
          imagePath: AssetsManager.entertainmentDark),
    ];
  }
}
