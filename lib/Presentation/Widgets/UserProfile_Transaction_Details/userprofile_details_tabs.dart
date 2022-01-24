import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Presentation/Widgets/UserProfile_Transaction_Details/userprofile_details_donationsTab.dart';
import 'package:mobile/Presentation/Widgets/UserProfile_Transaction_Details/userprofle_orders_tab.dart';

class UserProfileDetailTabs extends StatefulWidget {
  final Profile profile;

  const UserProfileDetailTabs({Key? key, required this.profile})
      : super(key: key);

  @override
  _UserProfileDetailTabsState createState() => _UserProfileDetailTabsState();
}

class _UserProfileDetailTabsState extends State<UserProfileDetailTabs>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
      new Tab(
        text: 'My Orders',
      ),
      new Tab(text: 'My Donations'),
    ];
    List<Widget> pages = [
      UserProfileOrdersTab(profile: widget.profile),
      UserProfileDonationsTab(profile: widget.profile),
    ];
    TabController controller =
        new TabController(length: tabs.length, vsync: this);

    return Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              color: Colors.black,
              child: TabBar(
                controller: controller,
                tabs: tabs,
                indicatorColor: Colors.amber,
                unselectedLabelColor: Colors.white,
              ),
            ),
            SizedBox.fromSize(
              size: Size.fromHeight(300.0),
              child: TabBarView(
                controller: controller,
                children: pages,
              ),
            )
          ],
        ));
  }
}
