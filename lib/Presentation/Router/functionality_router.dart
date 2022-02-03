import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Models/category_model.dart';
import 'package:mobile/Data_Layer/Models/company_model.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Presentation/Screens/atrocity_details.dart';
import 'package:mobile/Presentation/Screens/atrocity_list.dart';
import 'package:mobile/Presentation/Screens/cause_details.dart';
import 'package:mobile/Presentation/Screens/cause_list.dart';
import 'package:mobile/Presentation/Screens/company_dashboard.dart';
import 'package:mobile/Presentation/Screens/company_list.dart';
import 'package:mobile/Presentation/Screens/company_match_screen.dart';
import 'package:mobile/Presentation/Screens/company_signup.dart';
import 'package:mobile/Presentation/Screens/credit_card_page.dart';
import 'package:mobile/Presentation/Screens/find_friends_screen.dart';
import 'package:mobile/Presentation/Screens/non_profit_detail.dart';
import 'package:mobile/Presentation/Screens/nonprofit_list_screen.dart';
import 'package:mobile/Presentation/Screens/nonprofit_signup.dart';
import 'package:mobile/Presentation/Screens/profile_page.dart';
import 'package:mobile/Presentation/Screens/qr_screen.dart';
import 'package:mobile/Presentation/Screens/shirt_details.dart';
import 'package:mobile/Presentation/Screens/shirts_list.dart';
import 'package:mobile/Presentation/Screens/signup_screen.dart';
import 'package:mobile/Presentation/Screens/supporters.dart';
import 'package:mobile/Presentation/Screens/userProfile_fillScreen.dart';
import 'package:mobile/Presentation/Screens/user_nonprofitsList.dart';
import 'package:mobile/Presentation/Screens/user_profile_screen.dart';
import 'package:mobile/Presentation/Widgets/company/company_detail_page.dart';
import 'package:selection_menu/components_configurations.dart';

Widget makeRoute(
    {required BuildContext context,
    required String routeName,
    Object? arguments}) {
  final Widget child =
      _buildRoute(context: context, routeName: routeName, arguments: arguments);
  return child;
}

Widget _buildRoute(
    {required BuildContext context,
    required String routeName,
    Object? arguments}) {
  switch (routeName) {
    case '/userProfile':
      Profile profile = arguments as Profile;

      return ProfileScreen(
        profile: profile,
      );
    case '/signup':
      return SignUpScreen();
    case '/usernonprofits':
      Profile profile = arguments as Profile;
      return UserNonProfits(
        profile: profile,
      );
    case '/myQrCode':
      Profile profile = arguments as Profile;
      return MyQrScreen(
        profile: profile,
      );
    case '/supporters':
      Profile profile = arguments as Profile;
      return SupporterPage(profile: profile);
    case '/shirts':
      return ShirtList();
    case '/ShirtDetail':
      Shirt shirt = arguments as Shirt;
      return ShirtDetails(
        shirt: shirt,
      );
    case '/nonprofits':
      Profile profile = arguments as Profile;
      return NonProfitList(
        profile: profile,
      );
    case '/nonProfitView':
      final argument = arguments as NonProfitDetailArguments;
      return NonProfitDetails(
        nonProfit: argument.nonProfit,
        profile: argument.profile,
      );
    case '/atrocities':
      return AtrocityList();
    case '/atrocityView':
      Atrocity atrocity = arguments as Atrocity;
      return AtrocityDetails(atrocity: atrocity);
    case '/causes':
      return CauseList();
    case '/causeView':
      Category cause = arguments as Category;
      return CauseDetails(cause: cause);
    case '/companies':
      return CompanyList();
    case '/companyDetails':
      ForProfitCompany company = arguments as ForProfitCompany;
      return CompanYDetailPage(company: company);
    case '/editprofile':
      User user = arguments as User;
      return UserProfileComplete(user: user);
    case '/findfriends':
      User user = arguments as User;
      return FindFriends(
        user: user,
      );
    case '/profilepage':
      Profile profile = arguments as Profile;
      return ProfilePage(profile: profile);
    case '/nonprofitRegister':
      Profile profile = arguments as Profile;
      return NonProfitSignUp(profile: profile);
    case '/companyRegister':
      Profile profile = arguments as Profile;
      return CompanySignupPage(profile: profile);
    case '/companymatch':
      return CompanyMatchScreen();
    case '/creditCardDetails':
      return CreditCardPage();

    case '/companyDashboard':
      final argument = arguments as DashBoardScreenArguments;
      return MyDiaryScreen(
        animationController: argument.animationController,
        profile: argument.profile,
      );

    default:
      throw 'Route $routeName is not defined';
  }
}

class DashBoardScreenArguments {
  final Profile profile;
  final AnimationController animationController;

  DashBoardScreenArguments(
      {required this.animationController, required this.profile});
}

class NonProfitListArguments {
  final Profile profile;

  NonProfitListArguments({required this.profile});
}

class NonProfitDetailArguments {
  final Profile profile;
  final NonProfit nonProfit;

  NonProfitDetailArguments({required this.nonProfit, required this.profile});
}

class AtrocityListArguments {}

class AtrocityDetailArguments {}

class ShirtDetailArguments {}
