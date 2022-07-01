import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Presentation/Widgets/NonProfit_Details/np_donation_modal.dart';
import 'package:mobile/Presentation/Widgets/np_atributes.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AtrocityDonateModal extends StatefulWidget {
  final Atrocity atrocity;
  final Profile profile;
  const AtrocityDonateModal(
      {Key? key, required this.atrocity, required this.profile})
      : super(key: key);

  @override
  _AtrocityDonateModalState createState() => _AtrocityDonateModalState();
}

class _AtrocityDonateModalState extends State<AtrocityDonateModal> {
  double _amount = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
          children: [
            AtrocityInfo(atrocity: widget.atrocity),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Donors',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
                  height: widget.atrocity.recentDonors == null ||
                          widget.atrocity.recentDonors!.length < 1
                      ? 20
                      : 80,
                  child: widget.atrocity.recentDonors == null ||
                          widget.atrocity.recentDonors!.length < 1
                      ? Text('No Recent Donors')
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.atrocity.recentDonors!.length,
                          itemBuilder: (context, index) {
                            return ProfileDot(
                                profile: widget.atrocity.recentDonors![index]);
                          }),
                )
              ],
            ),
            Divider(
              height: 16,
              color: Colors.black54,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.atrocity.category![0].image!,
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
                      // DropdownButton<String>(
                      //   value: _selectedItem,
                      //   items: projects(widget.nonProfit).map((e) {
                      //     return DropdownMenuItem<String>(
                      //       child: Text(
                      //         e,
                      //         style: TextStyle(fontSize: 12),
                      //       ),
                      //       value: e,
                      //     );
                      //   }).toList(),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _selectedItem = value!;
                      //     });
                      //   },
                      // ),

                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2),
                        child: widget.profile.balance! >= 0
                            ? Container(
                                child: Column(
                                  children: [
                                    Text(
                                        'Please raise funds to donate to this atrocity'),
                                    MaterialButton(
                                        color: Colors.black.withOpacity(.7),
                                        child: Text(
                                          'Learn How',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {})
                                  ],
                                ),
                              )
                            : SfSlider(
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
                                      borderRadius: BorderRadius.circular(90)),
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
  }
}

class AtrocityInfo extends StatelessWidget {
  const AtrocityInfo({
    Key? key,
    required this.atrocity,
  }) : super(key: key);

  final Atrocity atrocity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Text(
                  atrocity.title,
                  style: TextStyle(
                    shadows: [
                      Shadow(
                          offset: Offset(.5, 0.5),
                          blurRadius: 1.0,
                          color: Colors.black),
                    ],
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: Attribute(
                  value: atrocity.category![0].name!,
                  name: 'Causes',
                  textColor: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Attribute(
              value: atrocity.balance.toString(),
              name: 'Donations This Wekk',
              textColor: Colors.black87,
            ),
          ],
        )
      ],
    );
  }
}

class ProfileDot extends StatelessWidget {
  final ProfileRepresentation profile;
  const ProfileDot({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            foregroundImage: NetworkImage(profile.profilePicture!.url),
            backgroundColor: Colors.black,
          ),
          Text(profile.username)
        ],
      ),
    );
  }
}
