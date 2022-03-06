import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/company_model.dart';
import 'package:mobile/Presentation/Widgets/company/CompanyDetailTabs/company_detail_tabs.dart';

import 'CompanyDetailTabs/company_finance_data.dart';

class CompanyDetailsContent extends StatefulWidget {
  final ForProfitCompany company;
  const CompanyDetailsContent({Key? key, required this.company})
      : super(key: key);

  @override
  _CompanyDetailsContentState createState() => _CompanyDetailsContentState();
}

class _CompanyDetailsContentState extends State<CompanyDetailsContent> {
  List<Widget> _buildCompanyCauses() {
    if (widget.company.categories!.length < 2) {
      return widget.company.categories!.map((category) {
        return Padding(
          padding: EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () {},
            child: Chip(
              label: Text(category.name),
              backgroundColor: Colors.amber,
            ),
          ),
        );
      }).toList();
    } else {
      var categoryList = widget.company.categories!.take(2);
      return categoryList.map((category) {
        return Padding(
          padding: EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () {},
            child: Chip(
              label: Text(category.name),
              backgroundColor: Colors.amber,
            ),
          ),
        );
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(scrollDirection: Axis.vertical, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 128.0),
              child: Image(
                image: AssetImage('images/Altrue Logo White.png'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * .2),
                  child: Text(
                    widget.company.name,
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text('Most Supported Causes',
                      style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _buildCompanyCauses(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('NonProfits\n Supported',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final nonprofit in widget.company.nonprofits!)
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {},
                        child: ClipOval(
                          child: Image.network(
                            nonprofit.logo,
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Company Info',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 30, top: 18),
              child: Text(widget.company.description!),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Company Mission',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(widget.company.mission!),
            ),
            ComapnyDetailTabs(company: widget.company)
          ],
        ),
      ]),
    );
  }
}
