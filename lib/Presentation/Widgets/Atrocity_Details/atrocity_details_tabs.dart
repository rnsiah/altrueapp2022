import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Presentation/Widgets/Atrocity_Details/atrocity_nonprofit_showcase.dart';
import 'package:mobile/Presentation/Widgets/Atrocity_Details/atrocity_shirt_showcase.dart';

class AtrocityDetailTabs extends StatefulWidget {
  final Atrocity atrocity;
  final Profile profile;
  AtrocityDetailTabs({Key? key, required this.atrocity, required this.profile})
      : super(key: key);

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
      AtrocityShirtShowcase(
        atrocity: widget.atrocity,
        profile: widget.profile,
      ),
      AtrocityNonProfitShowcase(
        atrocity: widget.atrocity,
        profile: widget.profile,
      )
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
