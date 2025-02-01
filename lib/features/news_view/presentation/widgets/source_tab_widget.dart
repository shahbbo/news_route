import 'package:flutter/material.dart';
import 'package:news_app/features/news_view/presentation/widgets/source_name_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_utls/app_colors.dart';
import '../../bloc/news_cubit.dart';

class SourceTabWidget extends StatelessWidget {
  const SourceTabWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    NewsCubit newsCubit = BlocProvider.of<NewsCubit>(context);
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: newsCubit.sourceList.length,
          child: Column(
            children: [
              TabBar(
                  dividerColor: AppColors.transparent,
                  indicatorColor: AppColors.black,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  onTap: (index) {
                    newsCubit.changeSelectedIndex(index);
                  },
                  tabs: newsCubit.sourceList.map((source) {
                    return SourceNameWidget(
                        source: source,
                        isSelected: newsCubit.selectedIndex == newsCubit.sourceList.indexOf(source));
                  }).toList()),
            ],
          ),
        );
      },
    );
  }
}
