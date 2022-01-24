import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/Data_Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_event.dart';
import 'package:mobile/Data_Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_state.dart';
import 'package:mobile/Data_Layer/Local%20Storage/user_data_access_object.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Presentation/Widgets/UserProfile_Transaction_Details/userprofile_details_tabs.dart';

class ProfileScreen extends StatelessWidget {
  final Profile profile;

  const ProfileScreen({required this.profile}) : super();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(fit: StackFit.expand, children: [
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.white, Colors.amber],
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
        )),
      ),
      Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Image(
            image: AssetImage('images/Altrue Logo White.png'),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      foregroundImage:
                          NetworkImage(profile.profilePicture!.url),
                      backgroundImage:
                          NetworkImage(profile.profilePicture.toString()),
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.username.toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          Text('Username',
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 12)),
                          SizedBox(
                            height: 25,
                          ),
                          MaterialButton(
                            color: Colors.amber,
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () async {
                              UserDao userdb = UserDao();
                              User? user = await userdb.getCurrentUser(0);
                              Navigator.of(context)
                                  .pushNamed('/editprofile', arguments: user!);
                            },
                          )
                        ]),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'My\nProfile',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, color: Colors.amber),
                ),
                Container(
                  height: height * 0.43,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double innerHeight = constraints.maxHeight;
                      double innerWidth = constraints.maxWidth;
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Container(
                              height: innerHeight * .72,
                              width: innerWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 80,
                                  ),
                                  Text(
                                    profile.username!,
                                    style: TextStyle(
                                      color: Colors.amber,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Orders',
                                          ),
                                          Text(profile.orders!.length
                                              .toString()),
                                        ],
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 8),
                                    child: Container(
                                      height: 50,
                                      width: 3,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [Text('Pending'), Text('1')],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: height * .5,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'My Transactions',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: UserProfileDetailTabs(profile: profile))
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget _profileForm() {
    return Form(
        child: Column(
      children: [
        _username(),
        _addressStreet(),
        // _confirmProfile()
      ],
    ));
  }
}

Widget _city() {
  return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
    builder: (context, state) {
      return TextFormField(
        style: TextStyle(color: Colors.amber),
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.amber)),
            labelText: 'City',
            labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
        onChanged: (value) => context
            .read<UserProfileEditBloc>()
            .add(UserProfileCityChange(city: value)),
        validator: (value) =>
            state.city.length > 3 ? null : "Select A Valid Ciy",
      );
    },
  );
}

Widget _username() {
  return TextFormField(
    style: TextStyle(color: Colors.amber),
    decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        labelText: 'Altrue Username',
        labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
    onChanged: (value) {},
  );
}

void _showSnackbar(BuildContext context, String message) {
  final snackbar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

// _confirmProfile() {
//   return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
//     builder: (context, state) {
//       return state.formStatus is FormSubmitting
//           ? CircularProgressIndicator()
//           : MaterialButton(
//               color: Colors.amber,
//               child: Text(
//                 'Create Profile',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//               onPressed: () {
//                 print([state.address, state.zip, state.country]);
//                 if (_formKey.currentState!.validate()) {
//                   context.read<UserProfileEditBloc>().add(
//                       UserProfileCompleted(
//                           profile: ProfileCompletion(
//                               address: state.address,
//                               city: state.city,
//                               dob: state.dob,
//                               country: state.country,
//                               zip: state.zip,
//                               title: state.title,
//                               username: state.username)));
//                 } else {
//                   context
//                       .read<UserProfileEditBloc>()
//                       .add(UserProfileEditFailure(error: "Exception"));
//                 }
//               },
//             );
//     },
//   );
// }

Widget _addressStreet() {
  return TextFormField(
      style: TextStyle(color: Colors.amber),
      decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          labelText: 'Street Address',
          labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
      onChanged: (value) {});
}

Widget _country() {
  return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
    builder: (context, state) {
      return CountryCodePicker(
          searchStyle: TextStyle(),
          showCountryOnly: true,
          onChanged: (value) {
            print(value.toCountryStringOnly());
            context.read<UserProfileEditBloc>().add(
                UserProfileCountryChange(country: value.toCountryStringOnly()));
          });
    },
  );
}

Widget _zipCode() {
  return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
    builder: (context, state) {
      return TextFormField(
        style: TextStyle(color: Colors.amber),
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.amber)),
            labelText: 'Zip Code',
            labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
        onChanged: (value) => context
            .read<UserProfileEditBloc>()
            .add(UserProfileZipChange(zip: value)),
        validator: (value) =>
            state.zip.length == 5 ? null : 'Please enter a valid zip code',
      );
    },
  );
}

Widget _birthday() {
  return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
    builder: (context, state) {
      return TextFormField(
          style: TextStyle(color: Colors.amber),
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'Birthday',
              labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
          onChanged: (value) => context
              .read<UserProfileEditBloc>()
              .add(UserProfileDobChange(dob: DateTime.now().toString())));
    },
  );
}

Widget _profilePicturePicker() {
  XFile picture;
  final ImagePicker _picker = ImagePicker();
  return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
    builder: (context, state) {
      return MaterialButton(
        color: Colors.black,
        child: Text(
          'Choose Profile Picture',
          style: TextStyle(color: Colors.amber),
        ),
        onPressed: () async {
          final XFile? profilePicture =
              await _picker.pickImage(source: ImageSource.gallery);
          picture = profilePicture!;
          context
              .read<UserProfileEditBloc>()
              .add(UserProfilePictureEdit(profilePicture: profilePicture));
        },
      );
    },
  );
}

  // Widget _genderPicker() {
  //   Gender? _gender = Gender.He;
  //   return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
  //     builder: (context, state) {
  //       return Column(
  //         children: [
  //           RadioListTile(
  //               activeColor: Colors.amber,
  //               title: Text(
  //                 'He',
  //                 style: TextStyle(color: Colors.amber),
  //               ),
  //               value: Gender.He,
  //               groupValue: _gender,
  //               onChanged: (Gender? value) {
  //                 _gender = value!;
  //                 print(_gender.toString().split('.').last);
  //                 context.read<UserProfileEditBloc>().add(
  //                     UserProfileTitleChange(
  //                         title: _gender.toString().split('.').last));
  //               }),
  //           RadioListTile(
  //               activeColor: Colors.amber,
  //               tileColor: Colors.black38,
  //               title: Text(
  //                 'She',
  //                 style: TextStyle(color: Colors.amber),
  //               ),
  //               value: Gender.She,
  //               groupValue: _gender,
  //               onChanged: (Gender? value) {
  //                 _gender = value;
  //                 print(_gender.toString().split('.').last);
  //                 context.read<UserProfileEditBloc>().add(
  //                     UserProfileTitleChange(
  //                         title: _gender.toString().split('.').last));
  //               }),
  //           RadioListTile(
  //               activeColor: Colors.amber,
  //               selectedTileColor: Colors.black12,
  //               value: Gender.They,
  //               title: Text('They', style: TextStyle(color: Colors.amber)),
  //               groupValue: _gender,
  //               onChanged: (Gender? value) {
  //                 print(value.toString().split('.').last);
  //                 _gender = value;
  //                 context.read<UserProfileEditBloc>().add(
  //                     UserProfileTitleChange(
  //                         title: _gender.toString().split('.').last));
  //               }),
  //         ],
  //       );
  //     },
  //   );
  // }}
