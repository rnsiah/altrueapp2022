import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/form_submission_status.dart';
import 'package:mobile/Data_Layer/Blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/sign_up_bloc/sign_up_event.dart';
import 'package:mobile/Data_Layer/Blocs/sign_up_bloc/sign_up_state.dart';
import 'package:mobile/Data_Layer/Blocs/validationCubit.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';
import 'package:video_player/video_player.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  VideoPlayerController? _controller;
  bool _visible = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _controller =
        VideoPlayerController.asset("videos/Ending poverty and hunger.mp4");
    _controller!.initialize().then((value) {
      Timer(Duration(milliseconds: 900), () {
        setState(() {
          _controller!.play();
          _visible = true;
        });
      });
    });

    // Future.delayed(Duration(seconds: 4),(){
    //   Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
    // })
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller!.dispose();
      _controller = null;
    }
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0,
      duration: Duration(milliseconds: 1000),
      child: VideoPlayer(_controller!),
    );
  }

  _getBackgroundColor() {
    return Container(color: Colors.transparent.withAlpha(120));
  }

  _getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(
        children: [_getVideoBackground()],
      ),
    ));
  }

  Container getSignUp(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: BlocProvider(
            create: (context) => SignUpBloc(
                userRepository: RepositoryProvider.of<UserRepository>(context),
                validationCubit: context.read<ValidationCubit>()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_signUpForm(), _showLoginLink(context)],
            )));
  }

  Widget _signUpForm() {
    return Form(
      key: _formKey,
      child: Padding(
          padding: EdgeInsets.all(23),
          child: Column(
            children: [
              Column(
                children: [
                  _emailField(),
                  _passWordField(),
                  _passWordField2(),
                  SizedBox(height: 65),
                  _signUpButtons()
                ],
              ),
            ],
          )),
    );
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          style: TextStyle(
              color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'email',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          validator: (value) =>
              state.isValidemail ? null : 'This is not a valid email',
          onChanged: (value) =>
              context.read<SignUpBloc>().add(SignUpEmailChanged(email: value)),
        );
      },
    );
  }

  Widget _passWordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          style: TextStyle(color: Colors.amber, fontSize: 16),
          obscureText: true,
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'password',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          validator: (value) =>
              state.isValidpassword ? null : "This is not a valid password",
          onChanged: (value) => context
              .read<SignUpBloc>()
              .add(SignUpPassword1Changed(password1: value)),
        );
      },
    );
  }

  Widget _passWordField2() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          style: TextStyle(
              color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),
          obscureText: true,
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'password',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          validator: (value) =>
              state.isValidpassword ? null : 'This is not abalid password',
          onChanged: (value) => context
              .read<SignUpBloc>()
              .add(SignUpPassword2Changed(password2: value)),
        );
      },
    );
  }

  Widget _showLoginLink(BuildContext context) {
    return SafeArea(
      child: TextButton(
        child: Text(
          "Already have an account? Log in Now",
          style: TextStyle(color: Colors.amber),
        ),
        onPressed: () => context.read<ValidationCubit>().showLogin(),
      ),
    );
  }

  Widget _signUpButtons() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return state.formaStatus is FormSubmitting
            ? CircularProgressIndicator()
            : Column(
                children: [
                  MaterialButton(
                      color: Colors.transparent,
                      elevation: 0,
                      minWidth: 350,
                      height: 60,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.amber)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SignUpBloc>().add(
                              SignUpSubmittedWithoutConfirmaation(
                                  email: state.email,
                                  password1: state.password1,
                                  password2: state.password2));
                        }
                      },
                      child: Text(
                        'Sign Up - 1 Factor ',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'SFUIDisplay',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                  SizedBox(height: 10),
                  MaterialButton(
                      color: Colors.amber,
                      elevation: 0,
                      minWidth: 350,
                      height: 60,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SignUpBloc>().add(
                              SignUpSubmittedWithConfirmation(
                                  email: state.email,
                                  password1: state.password1,
                                  password2: state.password2));
                        }
                      },
                      child: Row(children: [
                        Text(
                          'Sign Up - 2 Factor ',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'SFUIDisplay',
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ])),
                ],
              );
      },
    );
  }
}
