import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mobile/Data_Layer/Blocs/all_users_bloc/bloc/all_users_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/bloc/company_list_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/nonprofit_bloc/bloc/nonprofit_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/session_cubit.dart';
import 'package:mobile/Data_Layer/Blocs/session_event_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/session_state.dart';
import 'package:mobile/Data_Layer/Blocs/shirt_bloc/bloc/shirt_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/user_completed_orders_bloc/bloc/completed_userorders_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/user_profile_edit_bloc.dart/user_profile_edit_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/validationCubit.dart';
import 'package:mobile/Data_Layer/Repoositories/all_users_repository.dart';
import 'package:mobile/Data_Layer/Repoositories/atrocity_repositories.dart';
import 'package:mobile/Data_Layer/Repoositories/category_repository.dart';
import 'package:mobile/Data_Layer/Repoositories/company_repository.dart';
import 'package:mobile/Data_Layer/Repoositories/nonProfit_repository.dart';
import 'package:mobile/Data_Layer/Repoositories/order_repository.dart';
import 'package:mobile/Data_Layer/Repoositories/shirt_repository.dart';
import 'package:mobile/Presentation/Router/app_router.dart';
import 'package:mobile/Presentation/Router/functionality_router.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:mobile/Presentation/Screens/home_screen.dart';

import 'Data_Layer/Repoositories/user_repository.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  // ignore: override_on_non_overriding_member
  void onNewEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
  }
}

void main() async {
  Stripe.publishableKey = 'pk_test_osCkw6g4MDSTjwXhs0RzOwL0';
  SimpleBlocDelegate();
  runApp(RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider<SessionBLoc>(
        create: (context) {
          final userRepository = context.read<UserRepository>();
          return SessionBLoc(userRepository: userRepository)..add(Apploaded());
        },
        child: MultiRepositoryProvider(providers: [
          RepositoryProvider(
            create: (context) => ShirtRepository(),
          ),
          RepositoryProvider(
            create: (context) => NonProfitRespository(),
          ),
          RepositoryProvider(
            create: (context) => AtrocityRepository(),
          ),
          RepositoryProvider(
            create: (context) => OrderRepository(),
          ),
          RepositoryProvider(create: (context) => CategoryRepository()),
          RepositoryProvider(create: (context) => CompanyRepository()),
          RepositoryProvider(create: (context) => AllUsersRepository())
        ], child: MyApp()),
      )));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final OrderRepository orders = OrderRepository();

  final AtrocityRepository atrocity = AtrocityRepository();

  final ShirtRepository shirt = ShirtRepository();

  final NonProfitRespository nonprofit = NonProfitRespository();

  final CategoryRepository categoryRepository = CategoryRepository();

  final CompanyRepository companyRepository = CompanyRepository();

  final AllUsersRepository allUsersRepository = AllUsersRepository();

  Future<void> getPath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print('path:' + documentsDirectory.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<SessionBLoc>(),
          ),
          BlocProvider<CompletedUserordersBloc>(
              create: (context) => CompletedUserordersBloc(
                  orderRepository: orders,
                  userRepository: context.read<UserRepository>())),
          BlocProvider<AtrocityBlocBloc>(
            create: (context) => AtrocityBlocBloc(atrocityRepository: atrocity),
          ),
          BlocProvider<ShirtOrderBlocBloc>(
            create: (context) => ShirtOrderBlocBloc(),
          ),
          BlocProvider(
            create: (context) =>
                ShirtBloc(shirtRepository: context.read<ShirtRepository>()),
          ),
          BlocProvider<NonprofitBloc>(
            create: (context) => NonprofitBloc(
                nonProfitRespository: context.read<NonProfitRespository>()),
          ),
          BlocProvider<CategoryBloc>(
            create: (context) =>
                CategoryBloc(categoryRepository: categoryRepository),
          ),
          BlocProvider<UserProfileEditBloc>(
            create: (context) => UserProfileEditBloc(
                userRepository: context.read<UserRepository>(),
                sessionBLoc: context.read<SessionBLoc>()),
          ),
          BlocProvider<ProfileBloc>(
              create: (context) => ProfileBloc(
                    userRepository: context.read<UserRepository>(),
                  )),
          BlocProvider<CompanyListBloc>(create: (context) => CompanyListBloc()),
          BlocProvider<AllUsersBloc>(
              create: (context) => AllUsersBloc(
                  allUsersRepository: allUsersRepository,
                  userRepository: context.read<UserRepository>())),
          BlocProvider<ShirtOrderBlocBloc>(
            create: (context) => ShirtOrderBlocBloc(),
          ),
          BlocProvider(create: (context) => CartBloc()),
        ],
        child: MaterialApp(home:
            BlocBuilder<SessionBLoc, SessionState>(builder: (context, state) {
          if (state is AuthenticatedWithProfile) {
            return HomePage(
                cartBloc: context.read<CartBloc>(),
                user: state.user,
                profile: state.profile,
                profileBloc: context.read<ProfileBloc>());
          }
          return BlocProvider(
            create: (context) => ValidationCubit(
                sessionBloc: context.read<SessionBLoc>(),
                userProfileEditBloc: context.read<UserProfileEditBloc>(),
                userRepository: context.read<UserRepository>()),
            child: Builder(builder: (context) {
              return AuthNavigator();
            }),
          );
        }), onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => makeRoute(
                context: context,
                routeName: settings.name!,
                arguments: settings.arguments),
          );
        }));
  }
}
