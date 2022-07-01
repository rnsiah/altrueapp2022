import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/company_model.dart';
import 'package:selection_menu/components_configurations.dart';
import 'package:selection_menu/selection_menu.dart';

class CompanyMatchScreen extends StatefulWidget {
  final ForProfitCompany company;
  CompanyMatchScreen({
    required this.company,
  });

  @override
  _CompanyMatchScreenState createState() => _CompanyMatchScreenState();
}

class _CompanyMatchScreenState extends State<CompanyMatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Image(
          image: AssetImage('images/Altrue Logo White.png'),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 7),
            onPressed: () => print('Search'),
            icon: Icon(Icons.search),
            iconSize: 30,
            color: Colors.black,
          ),
        ],
      ),
      body: ListView(
        children: [
          Row(children: [
            SelectionMenu(
              componentsConfiguration:
                  DropdownComponentsConfiguration<String>(),
              itemsList: <String>[
                "1st atrocity",
                "2nd atrocity",
                "3rd atrocity"
              ],
              onItemSelected: (String selectedItem) {
                print(selectedItem);
              },
              itemBuilder: (BuildContext context, String item,
                  OnItemTapped onItemTapped) {
                return InkWell(
                  onTap: onItemTapped,
                  child: Text(item),
                );
              },
            ),
            SelectionMenu(
              componentsConfiguration:
                  DropdownComponentsConfiguration<String>(),
              itemsList: <String>[
                "1st atrocity",
                "2nd atrocity",
                "3rd atrocity"
              ],
              onItemSelected: (String selectedItem) {
                print(selectedItem);
              },
              itemBuilder: (BuildContext context, String item,
                  OnItemTapped onItemTapped) {
                return InkWell(
                  onTap: onItemTapped,
                  child: Text(item),
                );
              },
            ),
          ])
        ],
      ),
    );
  }
}
