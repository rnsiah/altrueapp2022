import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Presentation/Widgets/NonProfit_Details/nonprofit_atrocity_showcase.dart';
import 'package:mobile/Presentation/Widgets/NonProfit_Details/nonprofit_shirt_showcase.dart';
import 'package:mobile/Presentation/Widgets/NonProfit_Details/nonprofit_volunteer_showcase.dart';

class NonProfitDetailTabs extends StatefulWidget {
  final NonProfit nonProfit;
  final Profile profile;

  NonProfitDetailTabs(
      {Key? key, required this.nonProfit, required this.profile})
      : super(key: key);

  @override
  _NonProfitDetailTabsState createState() => _NonProfitDetailTabsState();
}

class _NonProfitDetailTabsState extends State<NonProfitDetailTabs>
    with TickerProviderStateMixin {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    List<Tab> _tabs = [
      new Tab(
        text: 'Shirts',
      ),
      new Tab(
        text: 'Atrocities',
      ),
      new Tab(
        text: 'Volunteer Opportunities',
      )
    ];
    List<Widget> _pages = [
      new NonProfitShirtCase(
        nonProfit: widget.nonProfit,
        profile: widget.profile,
      ),
      new NonprofitAtrocityShowcase(
        nonprofit: widget.nonProfit,
        profile: widget.profile,
      ),
      new NonProfitVolunteerShowcase(nonProfit: widget.nonProfit)
    ];

    TabController controller =
        new TabController(length: _tabs.length, vsync: this);
    return Padding(
      padding: EdgeInsets.all(4),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            child: TabBar(
              controller: controller,
              tabs: _tabs,
              indicatorColor: Colors.amber,
              unselectedLabelColor: Colors.white,
            ),
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(300.0),
            child: TabBarView(
              controller: controller,
              children: _pages,
            ),
          )
        ],
      ),
    );
  }
}
