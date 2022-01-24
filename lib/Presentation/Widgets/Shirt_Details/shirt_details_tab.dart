import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Presentation/Widgets/Shirt_Details/shirt_atrocity_showcase.dart';
import 'package:mobile/Presentation/Widgets/Shirt_Details/shirt_statistics.dart';

class ShirtDetailTabs extends StatefulWidget {
  final Shirt shirt;
  ShirtDetailTabs({Key? key, required this.shirt}) : super(key: key);

  @override
  _ShirtDetailTabsState createState() => _ShirtDetailTabsState();
}

class _ShirtDetailTabsState extends State<ShirtDetailTabs>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Tab> _tabs = [
      Tab(
        text: 'Atrocities',
      ),
      Tab(
        text: 'Shirts',
      ),
    ];
    List<Widget> pages = [
      ShirtAtrocityShowcase(shirt: widget.shirt),
      ShirtStatistics(shirt: widget.shirt)
    ];
    TabController tabController =
        TabController(length: _tabs.length, vsync: this);


    return Padding(
      padding: EdgeInsets.all(4),
      child: Column(children: [
        Container(color: Colors.black,
        child: TabBar(controller:tabController, tabs: _tabs, indicatorColor: Colors.amber, unselectedLabelColor: Colors.white,),
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(300),
          child: TabBarView(children: pages, controller: tabController,),
        )
      ],),
    );
  }
}
