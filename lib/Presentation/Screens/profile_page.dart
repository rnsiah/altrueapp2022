import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:mobile/Data_Layer/Models/manage_followers_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Presentation/Widgets/profile_page/profile_big_info.dart';
import 'package:mobile/Presentation/Widgets/profile_page/profile_info.dart';
import 'package:mobile/Presentation/Widgets/profle_match_bottom_modal.dart';

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
    Profile myProfile = context.read<ProfileBloc>().state.profile!;
    List<int> list = context
        .read<ProfileBloc>()
        .state
        .profile!
        .following!
        .map((e) => e.id)
        .toList();
    return BlocProvider.value(
      value: context.read<ProfileBloc>(),
      child: Scaffold(
          body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      SafeArea(
                          child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                widget.profile.username!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
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
                    padding: EdgeInsets.only(top: 10),
                    color: Colors.white,
                    child: Table(
                      children: [
                        TableRow(children: [
                          ProfileInfoBigCard(
                            firstText: 'NonProfits Following',
                            secondText:
                                widget.profile.nonProfitList!.length.toString(),
                            icon: Icon(
                              Icons.person_add,
                            ),
                          ),
                          ProfileInfoBigCard(
                            firstText: 'Amount Of Followers',
                            secondText:
                                widget.profile.following!.length.toString(),
                            icon: Icon(
                              Icons.person_add,
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          ProfileInfoBigCard(
                            firstText: 'Amount Raised',
                            secondText:
                                '\$' + widget.profile.donationTotal.toString(),
                            icon: Icon(
                              Icons.person_add,
                            ),
                          ),
                          ProfileInfoBigCard(
                            firstText: 'Atrocities Following',
                            secondText:
                                widget.profile.atrocityList!.length.toString(),
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  // GestureDetector(
                  //   onTap: (){},
                  //     child: ProfileInfoCard(
                  //   firstText: 'Follow',
                  // )),
                  list.contains(widget.profile.user)
                      ? MaterialButton(
                          onPressed: () {
                            ManageFollower follow = ManageFollower(
                                follow: 'unfollow', id: widget.profile.user!);
                            context
                                .read<ProfileBloc>()
                                .add(RemoveFollower(interaction: follow));
                            print(context
                                .read<ProfileBloc>()
                                .state
                                .profile!
                                .username);
                          },
                          color: Colors.amber,
                          child: Row(children: [
                            Icon(Icons.add, color: Colors.black),
                            Text('Following',
                                style: TextStyle(color: Colors.black))
                          ]),
                        )
                      : MaterialButton(
                          onPressed: () {
                            ManageFollower follow = ManageFollower(
                                follow: 'follow', id: widget.profile.user!);
                            context
                                .read<ProfileBloc>()
                                .add(AddFollower(interaction: follow));
                            print(context
                                .read<ProfileBloc>()
                                .state
                                .profile!
                                .username);
                          },
                          color: Colors.black,
                          child: Row(children: [
                            Icon(Icons.add, color: Colors.black),
                            Text('Follow',
                                style: TextStyle(color: Colors.amber))
                          ]),
                        ),

                  MaterialButton(
                      color: Colors.black,
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.mail, color: Colors.amber),
                          Text(
                            'Mssage',
                            style: TextStyle(color: Colors.amber),
                          ),
                        ],
                      )),

                  // GestureDetector(
                  //   onTap: () {},
                  //   child: ProfileInfoCard(
                  //     firstText: 'love',
                  //   ),
                  // ),

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
                              fontWeight: FontWeight.bold, color: Colors.red),
                        )
                      ],
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return ProfileMatchBottomSheet(
                              profile: widget.profile,
                            );
                          });
                    },
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
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
