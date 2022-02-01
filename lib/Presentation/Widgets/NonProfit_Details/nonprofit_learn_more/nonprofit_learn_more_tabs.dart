import 'dart:math';

import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/nonprofit_project_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:awesome_select/awesome_select.dart' show S2Choice, SmartSelect;
import 'package:mobile/Presentation/Widgets/shirt_order/project_picker.dart';

import 'package:selection_menu/selection_menu.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class NpDonate extends StatefulWidget {
  final NonProfit nonProfit;
  final Profile profile;

  const NpDonate({Key? key, required this.nonProfit, required this.profile})
      : super(key: key);

  @override
  _NpDonateState createState() => _NpDonateState();
}

class _NpDonateState extends State<NpDonate> {
  double _amount = 0;

  List<String> projects(NonProfit nonProfit) {
    List<String> titles = ['None'];
    for (var project in nonProfit.projects!) {
      titles.add(project.title);
    }

    return titles;
  }

  List<String> projectTitles(NonProfit nonProfit) {
    List<String> titles = [];
    for (var project in nonProfit.projects!) {
      titles.add(project.title);
    }
    return titles;
  }

  String _selectedItem = 'None';

  @override
  void initState() {
    // _list = projectTitles(widget.nonProfit);
    // _selectedItem = 'Pick A Project';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double finalAmount = double.parse((_amount).toStringAsFixed(2));
    return GestureDetector(
      child: Container(
        // key: _scaffoldKey,
        height: 800,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(widget.profile.username!),
                    SizedBox(
                      height: 6,
                    ),
                    Text('Altrue Balance'),
                    Text(widget.profile.balance.toString())
                  ],
                ),
                Column(
                  children: [
                    Text(widget.nonProfit.name),
                  ],
                ),
              ],
            ),
            Container(
              width: 180,
              child: TextFormField(
                  initialValue: _amount.toString(),
                  decoration: InputDecoration(
                    labelText: 'Amount to Donate',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SfSlider(
                  min: 0,
                  max: widget.profile.balance,
                  value: _amount,
                  interval: 1,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  thumbIcon: Container(
                    child: Icon(Icons.add),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                  ),
                  onChanged: (dynamic value) {
                    setState(() {
                      _amount = value;
                    });
                  }),
            ),

            Text('Donate To Specific Project'),
            SizedBox(
              height: 12,
            ),
            DropdownButton<String>(
              value: _selectedItem,
              items: projects(widget.nonProfit).map((e) {
                return DropdownMenuItem<String>(
                  child: Text(e),
                  value: e,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedItem = value!;
                });
              },
            ),

            // AwesomeDropDown(
            //     selectedItem: _selectedItem,
            //     onDropDownItemClick: (selectedItem) {
            //       setState(() {
            //         _selectedItem = selectedItem;
            //       });
            //     },
            //     numOfListItemToShow: 7,
            //     dropDownList: title(widget.nonProfit)),

            // SmartSelect.single(
            //   selectedValue: value,
            //   choiceItems: love,
            // ),

            SizedBox(
              height: 120,
            ),
            Text("\$" + finalAmount.toString())

            // SelectionMenu<ListTile>(
            //     itemBuilder:this.itemBuilder(context, , () { }),
            //     itemsList: list,
            //     onItemSelected: onItemSelected)
          ],
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, NonProfitProject project,
      OnItemTapped onItemTapped) {
    return ListTile(
      title: Text(project.title),
      onTap: onItemTapped,
    );
  }
}
