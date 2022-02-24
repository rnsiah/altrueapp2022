import 'dart:math';

import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/nonprofit_project_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:awesome_select/awesome_select.dart' show S2Choice, SmartSelect;
import 'package:mobile/Presentation/Widgets/NonProfit_Details/np_donation_modal.dart';
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

  List<Widget> getRecentDonors(NonProfit nonProfit) {
    List<ProfileRepresentation> list = nonProfit.recentDonors!.toSet().toList();
    if (list.length < 5) {
      return list.map((e) {
        return ProfileDot(profile: e);
      }).toList();
    }
    return list.take(4).toList().map((e) {
      return ProfileDot(profile: e);
    }).toList();
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
          children: [
            NonProfitInfo(nonProfit: widget.nonProfit),
            SizedBox(height: 10),
            Container(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Donors',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                      height: 80,
                      child: widget.nonProfit.recentDonors == null ||
                              widget.nonProfit.recentDonors!.length < 1
                          ? Text('No Recent Donors')
                          : ListView(
                              padding: EdgeInsets.symmetric(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: getRecentDonors(widget.nonProfit),
                            ))
                ],
              ),
            ),
            Divider(
              height: 16,
              color: Colors.black54,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.nonProfit.logo,
                  height: 70,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    children: [
                      // DriverInfo(),
                      SizedBox(
                        height: 12,
                      ),
                      Text('Donate To Specific Project'),
                      SizedBox(
                        height: 12,
                      ),
                      DropdownButton<String>(
                        value: _selectedItem,
                        items: projects(widget.nonProfit).map((e) {
                          return DropdownMenuItem<String>(
                            child: Text(
                              e,
                              style: TextStyle(fontSize: 12),
                            ),
                            value: e,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedItem = value!;
                          });
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.all(2),
                        child: SfSlider(
                            min: 0,
                            max: widget.profile.balance,
                            value: _amount,
                            interval: 1,
                            showTicks: true,
                            activeColor: Colors.black,
                            showLabels: true,
                            enableTooltip: true,
                            thumbIcon: Container(
                              child: Icon(Icons.add),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onChanged: (dynamic value) {
                              setState(() {
                                _amount = value;
                              });
                            }),
                      ),
                      DonationButton(),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    // child: Column(
    //   crossAxisAlignment: CrossAxisAlignment.end,
    //   children: [
    //     Container(
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(30),
    //         color: Colors.white,
    //       ),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           Container(
    //             child: Column(
    //               children: [
    //                 Text(
    //                   widget.profile.username!,
    //                   style: TextStyle(color: Colors.amber, fontSize: 22),
    //                 ),
    //                 SizedBox(
    //                   height: 6,
    //                 ),
    //                 Text(
    //                   'Altrue Balance',
    //                   style: TextStyle(color: Colors.amber),
    //                 ),
    //                 Text(
    //                   widget.profile.balance.toString(),
    //                   style: TextStyle(color: Colors.amber),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Container(
    //             color: Colors.black,
    //             child: Column(
    //               children: [
    //                 Text(
    //                   widget.nonProfit.name,
    //                   style: TextStyle(color: Colors.amber),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     Container(
    //       width: 180,
    //       child: TextFormField(
    //           initialValue: _amount.toString(),
    //           decoration: InputDecoration(
    //             labelText: 'Amount to Donate',
    //           )),
    //     ),
    // Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: SfSlider(
    //       min: 0,
    //       max: widget.profile.balance,
    //       value: _amount,
    //       interval: 1,
    //       showTicks: true,
    //       showLabels: true,
    //       enableTooltip: true,
    //       thumbIcon: Container(
    //         child: Icon(Icons.add),
    //         decoration:
    //             BoxDecoration(borderRadius: BorderRadius.circular(90)),
    //       ),
    //       onChanged: (dynamic value) {
    //         setState(() {
    //           _amount = value;
    //         });
    //       }),
    // ),

    // Text('Donate To Specific Project'),
    // SizedBox(
    //   height: 12,
    // ),
    // DropdownButton<String>(
    //   value: _selectedItem,
    //   items: projects(widget.nonProfit).map((e) {
    //     return DropdownMenuItem<String>(
    //       child: Text(e),
    //       value: e,
    //     );
    //   }).toList(),
    //   onChanged: (value) {
    //     setState(() {
    //       _selectedItem = value!;
    //     });
    //   },
    // ),

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

    //     SizedBox(
    //       height: 120,
    //     ),
    //     Text("\$" + finalAmount.toString())

    //     // SelectionMenu<ListTile>(
    //     //     itemBuilder:this.itemBuilder(context, , () { }),
    //     //     itemsList: list,
    //     //     onItemSelected: onItemSelected)
    //   ],
    // ),
  }

  Widget itemBuilder(BuildContext context, NonProfitProject project,
      OnItemTapped onItemTapped) {
    return ListTile(
      title: Text(project.title),
      onTap: onItemTapped,
    );
  }
}
