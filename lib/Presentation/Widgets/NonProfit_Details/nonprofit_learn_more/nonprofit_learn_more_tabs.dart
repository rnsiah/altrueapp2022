import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mobile/Data_Layer/Models/link_model.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/nonprofit_project_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:awesome_select/awesome_select.dart' show S2Choice, SmartSelect;
import 'package:selection_menu/selection_menu.dart';

class NpDonate extends StatefulWidget {
  final NonProfit nonProfit;
  final Profile profile;

  const NpDonate({Key? key, required this.nonProfit, required this.profile})
      : super(key: key);

  @override
  _NpDonateState createState() => _NpDonateState();
}

List<ListTile> list = [];

ListTile? npProjectsList(NonProfit nonprofit) {
  if (nonprofit.projects != null && nonprofit.projects!.length > 1) {
    for (var project in nonprofit.projects!) {
      ListTile love = ListTile(title: Text(project.title));
      return love;
    }
  } else {
    return null;
  }
}

class _NpDonateState extends State<NpDonate> {
  @override
  void initState() {
    list.add(npProjectsList(widget.nonProfit)!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(children: [
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
              decoration: InputDecoration(
            labelText: 'Amount to Donate',
          )),
        ),
        // SelectionMenu<ListTile>(
        //     itemBuilder:this.itemBuilder(context, , () { }),
        //     itemsList: list,
        //     onItemSelected: onItemSelected)
      ]),
    );
  }

  Widget itemBuilder(BuildContext context, NonProfitProject project,
      OnItemTapped onItemTapped) {
    return ListTile(
      title: Text(project.title),
      onTap: onItemTapped,
    );
  }

  void onItemSelected(NonProfitProject project) {
    print(project.title);
  }
}
