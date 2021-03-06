import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/Data_Layer/Blocs/validationCubit.dart';

import 'package:mobile/Presentation/Forms/user_login_form.dart';
import 'package:mobile/Presentation/Router/functionality_router.dart';
import 'package:mobile/Presentation/Screens/confirmation_screen.dart';
import 'package:mobile/Presentation/Screens/signup_screen.dart';
import 'package:mobile/Presentation/Widgets/Intro_Slider/intro_slider.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationCubit, ValidationState>(
      builder: (context, state) {
        return Navigator(
            pages: [
              if (state == ValidationState.intro)
                MaterialPage(child: IntroductionSlider()),
              if (state == ValidationState.login)
                MaterialPage(child: LoginPageUp()),
              if (state == ValidationState.signUpWithOutConfirmation)
                MaterialPage(child: SignUpScreen()),
              if (state == ValidationState.signup ||
                  state == ValidationState.confirmSignUp) ...[
                MaterialPage(child: SignUpScreen()),
                if (state == ValidationState.confirmSignUp)
                  MaterialPage(child: ConfirmationScreen()),
              ]
            ],
            onPopPage: (route, result) => route.didPop(result),
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (BuildContext context) => makeRoute(
                    context: context,
                    routeName: settings.name!,
                    arguments: settings.arguments),
              );
            });
      },
    );
  }
}

class FunctionalityRouter extends StatelessWidget {
  const FunctionalityRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [],
    );
  }
}
