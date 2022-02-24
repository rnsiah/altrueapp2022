import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';

class ProfileMatchBottomSheet extends StatefulWidget {
  final Profile profile;
  ProfileMatchBottomSheet({required this.profile});

  @override
  _ProfileMatchBottomSheetState createState() =>
      _ProfileMatchBottomSheetState();
}

class _ProfileMatchBottomSheetState extends State<ProfileMatchBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      color: Colors.white,
      child: widget.profile.userdonations!.length > 1
          ? ListView.builder(
              itemCount: widget.profile.userdonations!.length,
              itemBuilder: (context, int) {
                if (widget.profile.userdonations![int].nonprofit != null)
                  return ListTile(
                    title: Text(
                        widget.profile.userdonations![int].nonprofit!.name),
                    subtitle: Text(widget.profile.userdonations![int].amount),
                    trailing: MaterialButton(
                      child: Text(
                        'NonProfit \n Match',
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {},
                    ),
                  );
                else if (widget.profile.userdonations![int].atrocity != null) {
                  return ListTile(
                    title: Text(
                        widget.profile.userdonations![int].atrocity!.title),
                    subtitle: Text(widget.profile.userdonations![int].amount),
                    trailing: MaterialButton(
                      child: Text(
                        'Atrocity \n Match',
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {},
                    ),
                  );
                }
                return ListTile(
                  trailing: MaterialButton(
                    child: Text('General \nMatch', textAlign: TextAlign.center),
                    onPressed: () {},
                  ),
                  title: Text('General Altrue Donation'),
                  subtitle: Text(widget.profile.userdonations![int].amount),
                );
              })
          : Center(
              child: Container(
                child: Text(
                  'No Recent Donations',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
    );
  }
}
