import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/form_submission_status.dart';

import 'package:mobile/Data_Layer/Blocs/login_bloc/bloc/login_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/login_bloc/bloc/login_state.dart';
import 'package:mobile/Data_Layer/Blocs/session_cubit.dart';
import 'package:mobile/Data_Layer/Blocs/validationCubit.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';

class LoginPageUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/pplhelping.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: BlocProvider(
        create: (context) =>
            LoginBloc(
              sessionBLoc: context.read<SessionBLoc>(),
              userRepository: context.read<UserRepository>(),),
        child: Scaffold(
          backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Image(
                image: AssetImage('images/Altrue Logo White.png'),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_userLoginForm(), _showSignUpLink(context)],
            )),
      ),
    );
  }

  Widget _userLoginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formaStatus;
        if (formStatus is SubmissionFaiiled) {
          _showSnackbar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(23),
            child: Column(
              children: [
                _emailField(),
                _passwordField(),
                _loginButton(),
              ],
            )),
      ),
    );
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          style: TextStyle(color: Colors.amber),
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'email',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginEmailChange(value)),
          validator: (value) =>
              state.isValidemail ? null : 'Your email is not valid',
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          style: TextStyle(color: Colors.amber),
          obscureText: true,
          decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'password',
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginPassWordChange(value)),
          validator: (value) => state.password.length > 5
              ? null
              : "Your password is not long enough",
        );
      },
    );
  }

  Widget _showSignUpLink(BuildContext context) {
    return SafeArea(
      child: TextButton(
        child: Text("Dont't have an account? Sign Up Now",
        style: TextStyle(color:Colors.amber),
        ),
        onPressed: () => context.read<ValidationCubit>().showSignUp(),
      ),
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formaStatus is FormSubmitting
            ? CircularProgressIndicator()
            : MaterialButton(
              color: Colors.amber,
                child: Text('Login Now',),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted(
                        email: state.email, password: state.password));
                  } else {
                    context
                        .read<LoginBloc>()
                        .add(LoginFailure(error: 'Login Failure'));
                  }
                },
              );
      },
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
