import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/company_model.dart';
import 'package:mobile/Presentation/Widgets/company/CompanyDetailTabs/company_coupons_info.dart';
import 'package:mobile/Presentation/Widgets/company/CompanyDetailTabs/company_finance_data.dart';
import 'package:mobile/Presentation/Widgets/company/CompanyDetailTabs/company_matching_info.dart';

class ComapnyDetailTabs extends StatefulWidget {
  final ForProfitCompany company;
  const ComapnyDetailTabs({Key? key, required this.company}) : super(key: key);

  @override
  _ComapnyDetailTabsState createState() => _ComapnyDetailTabsState();
}

class _ComapnyDetailTabsState extends State<ComapnyDetailTabs>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Tab> _tabs = [
      Tab(
        text: 'Altrue Info',
      ),
      Tab(
        text: 'Company Matching',
      ),
      Tab(
        text: 'Altrue Deals',
      )
    ];
    List<Widget> pages = [
      CompanyFInanceData(company: widget.company),
      CompanyMatchingInfo(company: widget.company),
      CompanyCouponInfo(company: widget.company),
    ];
    TabController tabController =
        TabController(length: _tabs.length, vsync: this);

    return Padding(
      padding: EdgeInsets.all(4),
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            child: TabBar(
              isScrollable: true,
              labelColor: Colors.amber,
              controller: tabController,
              tabs: _tabs,
              indicatorColor: Colors.amber,
              unselectedLabelColor: Colors.black,
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
