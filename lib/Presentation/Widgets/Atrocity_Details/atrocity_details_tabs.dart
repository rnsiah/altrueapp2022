import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Presentation/Widgets/Atrocity_Details/atrocity_nonprofit_showcase.dart';
import 'package:mobile/Presentation/Widgets/Atrocity_Details/atrocity_shirt_showcase.dart';

class AtrocityDetailTabs extends StatefulWidget {
  final Atrocity atrocity;
  AtrocityDetailTabs({Key? key, required this.atrocity}) : super(key: key);

  @override
  _AtrocityDetailTabState createState() => _AtrocityDetailTabState();
}

class _AtrocityDetailTabState extends State<AtrocityDetailTabs>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Tab> _tabs = [
      Tab(
        text: 'Shirts',
      ),
      Tab(
        text: 'Altrue Organizations',
      ),
    ];
    List<Widget> pages = [
      AtrocityShirtShowcase(widget.atrocity),
      AtrocityNonProfitShowcase(atrocity: widget.atrocity)
    ];
    TabController tabController =
        TabController(length: _tabs.length, vsync: this);

    return Padding(
      padding: EdgeInsets.all(4),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            child: TabBar(
              controller: tabController,
              tabs: _tabs,
              indicatorColor: Colors.amber,
              unselectedLabelColor: Colors.white,
            ),
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(200),
            child: TabBarView(
              children: pages,
              controller: tabController,
            ),
          )
        ],
      ),
    );
  }
}
