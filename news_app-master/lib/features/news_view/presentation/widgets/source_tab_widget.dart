import 'package:flutter/material.dart';
import 'package:news_app/features/news_view/presentation/widgets/source_name_widget.dart';

import '../../../../core/app_utls/app_colors.dart';
import '../../data/model/source_response.dart';
import 'news_widget.dart';

class SourceTabWidget extends StatefulWidget {
   final List<Source> sourceList;
   int? selectedIndex;
   SourceTabWidget({super.key, required this.sourceList, this.selectedIndex});
  @override
  State<SourceTabWidget> createState() => _SourceTabWidgetState();
}
class _SourceTabWidgetState extends State<SourceTabWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourceList.length,
      child: Column(
        children: [
          TabBar(
              dividerColor: AppColors.transparent,
              indicatorColor: AppColors.black,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              onTap: (index) {
                setState(() {
                  widget.selectedIndex = index;
                });
              },
              tabs: widget.sourceList.map((source) {
                return SourceNameWidget(
                    source: source,
                    isSelected: widget.selectedIndex == widget.sourceList.indexOf(source));
              }).toList()),
          Expanded(child: NewsWidget(source: widget.sourceList[widget.selectedIndex!]))
        ],
      ),
    );
  }
}
