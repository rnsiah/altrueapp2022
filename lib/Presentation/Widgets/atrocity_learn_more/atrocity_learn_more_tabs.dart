import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Presentation/Widgets/atrocity_learn_more/atroc.dart';
import 'package:mobile/Presentation/Widgets/atrocity_learn_more/atrocity_learn_more.dart';
import 'package:mobile/Presentation/Widgets/atrocity_learn_more/atrocity_statistics.dart';

class AtrocityLearnMoreTabs extends StatefulWidget {
  final Atrocity atrocity;

  AtrocityLearnMoreTabs({Key? key, required this.atrocity}) : super(key: key);

  @override
  _AtrocityLearnMoreTabsState createState() => _AtrocityLearnMoreTabsState();
}

class _AtrocityLearnMoreTabsState extends State<AtrocityLearnMoreTabs>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Tab> _tabs = [
      Tab(
        child: Container(
          width: 175,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(width: 3, color: Colors.amber)),
          child: Center(
              child: Text(
            'Relevant Links',
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
          )),
        ),
      ),
      Tab(
        child: Container(
          width: 175,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.amber, width: 3)),
          child: Center(
            child: Text(
              'Altrue Statistics',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ];

    List<Widget> _pages = [
      AtroLearn(atrocity: widget.atrocity),
      AtrocityStatistics(atrocity: widget.atrocity)
    ];

    TabController tabController =
        TabController(length: _tabs.length, vsync: this);

    return Padding(
      padding: EdgeInsets.all(4),
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: _tabs,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.white,
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(300),
            child: TabBarView(
              children: _pages,
              controller: tabController,
            ),
          )
        ],
      ),
    );
  }
}
