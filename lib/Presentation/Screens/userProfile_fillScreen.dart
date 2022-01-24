import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/Data_Layer/Blocs/form_submission_status.dart';
import 'package:mobile/Data_Layer/Blocs/session_cubit.dart';

import 'package:mobile/Data_Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_event.dart';
import 'package:mobile/Data_Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_state.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';

class UserProfileComplete extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final User user;

  UserProfileComplete({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
      body: BlocProvider(
        create: (context) => UserProfileEditBloc(
            sessionBLoc: context.read<SessionBLoc>(),
            userRepository: context.read<UserRepository>()),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Welcome To Altrue Global',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Complete Your Altrue Profile',
                  style: TextStyle(fontSize: 10, color: Colors.amber)),
              MaterialButton(
                child: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.amber),
                ),
                onPressed: () =>
                    BlocProvider.of<SessionBLoc>(context).signOut(),
              ),
              _profileForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileForm() {
    return BlocListener<UserProfileEditBloc, UserProfileEditState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFaiiled) {
          _showSnackbar(context, formStatus.exception.toString());
        }
      },
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              _username(),
              _addressStreet(),
              _city(),
              _zipCode(),
              _country(),
              _genderPicker(),
              _birthday(),
              _profilePicturePicker(),
              _confirmProfile()
            ],
          )),
    );
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
    return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
      builder: (context, state) {
        return TextFormField(
          style: TextStyle(color: Colors.amber),
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'Altrue Username',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => context
              .read<UserProfileEditBloc>()
              .add(UserProfileUsernameChange(username: value)),
        );
      },
    );
  }

  Widget _addressStreet() {
    return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
      builder: (context, state) {
        return TextFormField(
          style: TextStyle(color: Colors.amber),
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'Street Address',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => context
              .read<UserProfileEditBloc>()
              .add(UserProfileAddressChange(address: value)),
          validator: (value) => state.address.length > 10
              ? null
              : 'Please choose a valid address',
        );
      },
    );
  }

  Widget _country() {
    return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
      builder: (context, state) {
        return CountryCodePicker(
            searchStyle: TextStyle(),
            showCountryOnly: true,
            onChanged: (value) {
              print(value.toCountryStringOnly());
              context.read<UserProfileEditBloc>().add(UserProfileCountryChange(
                  country: value.toCountryStringOnly()));
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

  Widget _genderPicker() {
    Gender? _gender = Gender.He;
    return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
      builder: (context, state) {
        return Column(
          children: [
            RadioListTile(
                activeColor: Colors.amber,
                title: Text(
                  'He',
                  style: TextStyle(color: Colors.amber),
                ),
                value: Gender.He,
                groupValue: _gender,
                onChanged: (Gender? value) {
                  _gender = value!;
                  print(_gender.toString().split('.').last);
                  context.read<UserProfileEditBloc>().add(
                      UserProfileTitleChange(
                          title: _gender.toString().split('.').last));
                }),
            RadioListTile(
                activeColor: Colors.amber,
                tileColor: Colors.black38,
                title: Text(
                  'She',
                  style: TextStyle(color: Colors.amber),
                ),
                value: Gender.She,
                groupValue: _gender,
                onChanged: (Gender? value) {
                  _gender = value;
                  print(_gender.toString().split('.').last);
                  context.read<UserProfileEditBloc>().add(
                      UserProfileTitleChange(
                          title: _gender.toString().split('.').last));
                }),
            RadioListTile(
                activeColor: Colors.amber,
                selectedTileColor: Colors.black12,
                value: Gender.They,
                title: Text('They', style: TextStyle(color: Colors.amber)),
                groupValue: _gender,
                onChanged: (Gender? value) {
                  print(value.toString().split('.').last);
                  _gender = value;
                  context.read<UserProfileEditBloc>().add(
                      UserProfileTitleChange(
                          title: _gender.toString().split('.').last));
                }),
          ],
        );
      },
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  _confirmProfile() {
    return BlocBuilder<UserProfileEditBloc, UserProfileEditState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? CircularProgressIndicator()
            : MaterialButton(
                color: Colors.amber,
                child: Text(
                  'Create Profile',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  print([state.address, state.zip, state.country]);
                  if (_formKey.currentState!.validate()) {
                    context.read<UserProfileEditBloc>().add(
                        UserProfileCompleted(
                            profile: ProfileCompletion(
                                address: state.address,
                                city: state.city,
                                dob: state.dob,
                                country: state.country,
                                zip: state.zip,
                                title: state.title,
                                username: state.username)));
                  } else {
                    context
                        .read<UserProfileEditBloc>()
                        .add(UserProfileEditFailure(error: "Exception"));
                  }
                },
              );
      },
    );
  }
}

enum Gender { He, She, They }
