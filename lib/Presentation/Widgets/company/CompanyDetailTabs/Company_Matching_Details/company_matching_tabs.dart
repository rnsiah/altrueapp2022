import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/company_model.dart';
import 'package:mobile/Presentation/Widgets/company/CompanyDetailTabs/Company_Matching_Details/company_atrocity_matching_details.dart';
import 'package:mobile/Presentation/Widgets/company/CompanyDetailTabs/Company_Matching_Details/company_nonprofit_matching_details.dart';

class CompanyMatchingDetailTabs extends StatefulWidget {
  final ForProfitCompany company;
  const CompanyMatchingDetailTabs({Key? key, required this.company})
      : super(key: key);

  @override
  _CompanyMatchingDetailTabsState createState() =>
      _CompanyMatchingDetailTabsState();
}

class _CompanyMatchingDetailTabsState extends State<CompanyMatchingDetailTabs>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Tab> _tabs = [
      Tab(
        text: 'Atrocity Matches',
      ),
      Tab(
        text: 'NonProfit Matches',
      ),
    ];
    List<Widget> pages = [
      CompanyAtrocityMatches(
        company: widget.company,
      ),
      CompanyNonProfitMatches(company: widget.company)
    ];
    TabController tabController =
        TabController(length: _tabs.length, vsync: this);

    return Padding(
      padding: EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.transparent,
            child: TabBar(
              labelStyle: TextStyle(fontSize: 10),
              isScrollable: true,
              labelColor: Colors.amber,
              controller: tabController,
              tabs: _tabs,
              indicatorColor: Colors.amber,
              unselectedLabelColor: Colors.black,
            ),
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(80),
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
