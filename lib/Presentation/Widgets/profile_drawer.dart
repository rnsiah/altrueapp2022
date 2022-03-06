import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/Data_Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/session_cubit.dart';
import 'package:mobile/Data_Layer/Models/company_model.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/company_repository.dart';
import 'package:mobile/Data_Layer/Repoositories/nonProfit_repository.dart';
import 'package:mobile/Presentation/Router/functionality_router.dart';

class ProfileDrawer extends StatefulWidget {
  final Profile profile;

  final NonProfitRespository nonProfitRespository = NonProfitRespository();
  final CompanyRepository companyRepository = CompanyRepository();

  ProfileDrawer({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

final ImagePicker _picker = ImagePicker();

Future<dynamic> _getImage() async {
  try {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  } catch (e) {
    Exception(e.toString());
  }
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
        ),
        child: Drawer(
            child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Container(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        try {
                          await _getImage().then((value) => context
                              .read<ProfileBloc>()
                              .add(
                                  ChangeProfilePicture(profilePicture: value)));
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                      child: CircleAvatar(
                        radius: 45.0,
                        // foregroundImage:
                        //     NetworkImage(widget.profile.profilePicture!.url),
                        backgroundImage:
                            NetworkImage(widget.profile.profilePicture!.url),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          widget.profile.username!,
                          style: TextStyle(color: Colors.amber),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 3),
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Colors.black87,
                child: ListTile(
                  leading: Icon(Icons.person, color: Colors.amberAccent),
                  title: Text(
                    'My Profile',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  onTap: () => Navigator.of(context)
                      .pushNamed('/userProfile', arguments: widget.profile),
                ),
              ),
            ),
            Card(
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                    onTap: () => Navigator.of(context).pushNamed(
                        '/usernonprofits',
                        arguments: widget.profile),
                    leading: Icon(Icons.favorite, color: Colors.white),
                    title: Text(
                      'My Non Profits',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ))),
            Card(
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                  onTap: () => Navigator.of(context)
                      .pushNamed('/supporters', arguments: widget.profile),
                  leading: Icon(Icons.people, color: Colors.amber),
                  title: Text(
                    'My Supporters',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                )),
            Card(
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListTile(
                    leading: Icon(Icons.camera, color: Colors.white),
                    title: Text(
                      'My Altrue Code',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/myQrCode', arguments: widget.profile);
                    })),
            Card(
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                leading: Icon(Icons.store, color: Colors.white),
                title: widget.profile.hasCompany!
                    ? Text('My Company Details',
                        style: TextStyle(color: Colors.white, fontSize: 18))
                    : Text('Register A Company',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                onTap: widget.profile.hasCompany!
                    ? () async {
                        ForProfitCompany company = await widget
                            .companyRepository
                            .fetchCompanyById(widget.profile.comp!.id);
                        Navigator.of(context).pushNamed('/CompanyHome',
                            arguments: CompanyHomeArguments(
                                company: company, profile: widget.profile));
                      }
                    : () {
                        Navigator.of(context).pushNamed('/companyRegister');
                      },
              ),
            ),
            Card(
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                leading: Icon(Icons.store, color: Colors.amber),
                title: widget.profile.hasNonProfit!
                    ? Text('My NonProfit Details',
                        style: TextStyle(color: Colors.white, fontSize: 18))
                    : Text('Register A NonProfit',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                onTap: () async {
                  if (widget.profile.hasNonProfit == true) {
                    NonProfit nonprofit = await widget.nonProfitRespository
                        .fetchNonProfit(widget.profile.np!.id);
                    Navigator.of(context).pushNamed('/mynonprofit',
                        arguments: MyNonProfitDetailArgments(
                            nonprofit: nonprofit, profile: widget.profile));
                  }

                  Navigator.of(context).pushNamed('/nonprofitRegister',
                      arguments: widget.profile);
                },
              ),
            ),
            Card(
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.amberAccent),
                title: Text(
                  'My Dashboard',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                onTap: () {},
              ),
            ),
            Card(
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListTile(
                leading: Icon(Icons.close, color: Colors.amber),
                title: Text(
                  'Sign Out Now',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                onTap: () {
                  context.read<SessionBLoc>().signOut();
                },
              ),
            ),
            Column(children: [
              Text("Altrue Balance:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  )),
              Text(widget.profile.balance.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  )),
            ]),
            Center(
                child: GestureDetector(
              onTap: _getImage,
              child: Text('Change Profile Picture'),
            ))
          ]),
        )));
  }
}
