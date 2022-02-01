import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/Data_Layer/Blocs/bloc/NonProfit_Signup_bloc/bloc/nonprofitsignup_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/form_submission_status.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';

class NonProfitSignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Profile profile;
  NonProfitSignUp({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Image(
          image: AssetImage('images/Altrue Logo White.png'),
        ),
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 7),
            onPressed: () => print('Search'),
            icon: const Icon(Icons.search),
            iconSize: 30,
            color: Colors.black,
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => NonprofitsignupBloc(),
        child: Column(
          children: [
            const Text(
              'Welcome To Altrue Global',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Register Your Non Profit',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold)),
            Expanded(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: _nonprofitForm()),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  Widget _nonprofitForm() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              _name(),
              _yearStarted(),
              _addressStreet(),
              _description(),
              _missionStatement(),
              _visionStatement(),
              _website(),
              _instagram(),
              _facebook(),
              _registerNonProfit(),
              Container(
                height: 50,
              )
            ],
          ),
        ));
  }

  Widget _name() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'NonProfit Name',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => {
            print(value),
            context
                .read<NonprofitsignupBloc>()
                .add(NonProfitWebsiteChangeOnForm(npWebsite: value))
          },
          validator: (value) => state.name.length > 3
              ? null
              : "Invalid website, please correct the web address",
          // state.city.length > 3 ? null : "Select A Valid Ciy",
        );
      },
    );
  }

  Widget _website() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.url,
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'Organization website',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => {
            print(value),
            context
                .read<NonprofitsignupBloc>()
                .add(NonProfitWebsiteChangeOnForm(npWebsite: value))
          },
          validator: (value) => state.website.length > 5
              ? null
              : "Invalid website, please correct the web address",
        );
      },
    );
  }

  Widget _yearStarted() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'Year Started',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => {
            print(int.parse(value)),
            context.read<NonprofitsignupBloc>().add(
                NonProfitYearStartedChangeOnForm(
                    npYearStarted: (int.parse(value))))
          },
        );
      },
    );
  }

  Widget _addressStreet() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.streetAddress,
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'Street Address',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => {
            print(value),
            context
                .read<NonprofitsignupBloc>()
                .add(NonProfitAddressChangeOnForm(npAddress: value))
          },
          validator: (value) => state.address.length >= 7
              ? null
              : 'Please choose a valid address',
        );
      },
    );
  }

  Widget _description() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
          maxLines: 6,
          keyboardType: TextInputType.streetAddress,
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'Give A Description Of Your Organization',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => {
            print(value),
            context
                .read<NonprofitsignupBloc>()
                .add(NonProfitDescriptionChangeOnForm(npDescription: value))
          },
          validator: (value) => state.description.length >= 7
              ? null
              : 'Please choose a valid address',
        );
      },
    );
  }

  Widget _missionStatement() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
          maxLines: 6,
          keyboardType: TextInputType.streetAddress,
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: "Your organization's mission statement",
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => {
            print(value),
            context
                .read<NonprofitsignupBloc>()
                .add(NonProfitMissionStatementChangeOnForm(npMission: value))
          },
          validator: (value) => state.missionStatement.length >= 7
              ? null
              : "Please update your organization's mission statement",
        );
      },
    );
  }

  Widget _visionStatement() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
          maxLines: 6,
          keyboardType: TextInputType.streetAddress,
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'Organization Vision Statement',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => {
            print(value),
            context
                .read<NonprofitsignupBloc>()
                .add(NonProfitVisionStatementChangeOnForm(npVision: value))
          },
          validator: (value) => state.visionStatement.length >= 7
              ? null
              : "Please update your organization's vision statement",
        );
      },
    );
  }
  // Widget _country() {
  //   return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
  //     builder: (context, state) {
  //       return CountryCodePicker(
  //           searchStyle: TextStyle(),
  //           showCountryOnly: true,
  //           onChanged: (value) {
  //             // print(value.toCountryStringOnly());
  //             // context.read<UserProfileEditBloc>().add(UserProfileCountryChange(
  //             //     country: value.toCountryStringOnly()));
  //           });
  //     },
  //   );
  // }

  Widget _instagram() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: '@',
          style: const TextStyle(color: Colors.amber),
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              labelText: 'instagram',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) => {
            print(value),
            context
                .read<NonprofitsignupBloc>()
                .add(NonProfitInstagramChangeOnForm(npInstagram: value))
          }
          // context
          //     .read<UserProfileEditBloc>()
          //     .add(UserProfileZipChange(zip: value)),
          ,
        );
      },
    );
  }

  Widget _facebook() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return TextFormField(
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)),
                labelText: "Organization's Facebook",
                labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
            onChanged: (value) {
              print(value);
              context
                  .read<NonprofitsignupBloc>()
                  .add(NonProfitFacebookChangeOnForm(npFacebook: value));
            });
      },
    );
  }

  Widget _logo() {
    XFile picture;
    final ImagePicker _picker = ImagePicker();
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return Row(children: [
          MaterialButton(
            color: Colors.black,
            child: const Text(
              'Upload Logo',
              style: TextStyle(color: Colors.amber),
            ),
            onPressed: () async {
              final XFile? logo =
                  await _picker.pickImage(source: ImageSource.gallery);
              picture = logo!;
              context
                  .read<NonprofitsignupBloc>()
                  .add(NonProfitLogoChangeOnForm(npLogo: picture));
            },
          ),
          TextFormField(
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)),
                labelText: 'Paste logo image address',
                labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
            onChanged: (value) => {
              context
                  .read<NonprofitsignupBloc>()
                  .add(NonProfitLogoChangeOnForm(npLogo: value))
            },
          )
        ]);
      },
    );
  }

  Widget _mainImage() {
    XFile picture;
    final ImagePicker _picker = ImagePicker();
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return Row(children: [
          MaterialButton(
            color: Colors.black,
            child: const Text(
              'Upload Logo',
              style: TextStyle(color: Colors.amber),
            ),
            onPressed: () async {
              final XFile? logo =
                  await _picker.pickImage(source: ImageSource.gallery);
              picture = logo!;
              context
                  .read<NonprofitsignupBloc>()
                  .add(NonProfitLogoChangeOnForm(npLogo: picture));
            },
          ),
          TextFormField(
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber)),
                labelText: 'Paste logo image address',
                labelStyle: TextStyle(fontSize: 15, color: Colors.amber)),
            onChanged: (value) => {
              print(value),
              context
                  .read<NonprofitsignupBloc>()
                  .add(NonProfitLogoChangeOnForm(npLogo: value))
            },
          )
        ]);
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
  // }

  void _showSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  _registerNonProfit() {
    return BlocBuilder<NonprofitsignupBloc, NonprofitsignupState>(
      builder: (context, state) {
        return state.status is FormSubmitting
            ? const CircularProgressIndicator()
            : MaterialButton(
                color: Colors.amber,
                child: const Text(
                  'Register NonProfit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  print([state.instagram]);
                  if (_formKey.currentState!.validate()) {
                    context.read<NonprofitsignupBloc>().add(
                        NonProfitSignUpFormCompletion(
                            facebook: state.facebook,
                            instagram: state.instagram,
                            mission: state.missionStatement,
                            vision: state.visionStatement,
                            website: state.website,
                            yearStarteed: state.yearStarted!,
                            profile: profile,
                            name: state.name,
                            description: state.description));
                  } else {
                    context
                        .read<NonprofitsignupBloc>()
                        .add(NonProfitCreationError(errorMessage: "Exception"));
                  }
                },
              );
      },
    );
  }
}
