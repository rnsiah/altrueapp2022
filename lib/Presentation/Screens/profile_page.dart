import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Presentation/Widgets/profile_page/opaque_image.dart';
import 'package:mobile/Presentation/Widgets/profile_page/profile_big_info.dart';
import 'package:mobile/Presentation/Widgets/profile_page/profile_info.dart';

class ProfilePage extends StatefulWidget {
  final Profile profile;
  const ProfilePage({Key? key, required this.profile}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Widget> _buildCompanyCauses() {
    if (widget.profile.nonProfitList!.length < 2) {
      return widget.profile.nonProfitList!.map((nonprofit) {
        return Padding(
          padding: EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () {},
            child: Chip(
              label: Text(nonprofit.name),
              backgroundColor: Colors.amber,
            ),
          ),
        );
      }).toList();
    } else {
      var npList = widget.profile.nonProfitList!.take(2);
      return widget.profile.nonProfitList!.map((nonprofit) {
        return Padding(
          padding: EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () {},
            child: Chip(
              label: Text(nonprofit.name),
              backgroundColor: Colors.amber,
            ),
          ),
        );
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    OpaqueImage(imageUrl: widget.profile.profilePicture),
                    SafeArea(
                        child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.profile.username!,
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          MyInfo(profile: widget.profile)
                        ],
                      ),
                    ))
                  ],
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Supported NonProfits',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final nonprofit in widget.profile.nonProfitList!)
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {},
                            child: ClipOval(
                              child: Image.network(
                                nonprofit.logo,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.only(top: 50),
                  color: Colors.white,
                  child: Table(
                    children: [
                      TableRow(children: [
                        ProfileInfoBigCard(
                          firstText: 'Amount Of Follower',
                          secondText:
                              widget.profile.nonProfitList!.length.toString(),
                          icon: Icon(
                            Icons.person_add,
                          ),
                        ),
                        ProfileInfoBigCard(
                          firstText: 'Amount Of Follower',
                          secondText:
                              widget.profile.nonProfitList!.length.toString(),
                          icon: Icon(
                            Icons.person_add,
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        ProfileInfoBigCard(
                          firstText: 'Amount Of Follower',
                          secondText:
                              widget.profile.nonProfitList!.length.toString(),
                          icon: Icon(
                            Icons.person_add,
                          ),
                        ),
                        ProfileInfoBigCard(
                          firstText: 'Amount Of Follower',
                          secondText:
                              widget.profile.nonProfitList!.length.toString(),
                          icon: Icon(
                            Icons.person_add,
                          ),
                        ),
                      ]),
                    ],
                  ),
                )),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * (3.15 / 10),
          left: 16,
          right: 16,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                // GestureDetector(
                //   onTap: (){},
                //     child: ProfileInfoCard(
                //   firstText: 'Follow',
                // )),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.black,
                  child: Row(children: [
                    Icon(Icons.add, color: Colors.amber),
                    Text('Follow',
                        style: TextStyle(fontSize: 16, color: Colors.amber))
                  ]),
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                    color: Colors.black,
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.mail, color: Colors.amber),
                        Text(
                          'Mssage',
                          style: TextStyle(color: Colors.amber, fontSize: 16),
                        ),
                      ],
                    )),

                // GestureDetector(
                //   onTap: () {},
                //   child: ProfileInfoCard(
                //     firstText: 'love',
                //   ),
                // ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  color: Colors.greenAccent,
                  child: Row(
                    children: [
                      Icon(
                        Icons.payment,
                        color: Colors.amber,
                      ),
                      Text(
                        'Match',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      )
                    ],
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}

class IconTile extends StatelessWidget {
  final String imgAssetPath;
  final Color backColor;

  IconTile({required this.imgAssetPath, required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imgAssetPath,
          width: 20,
        ),
      ),
    );
  }
}
