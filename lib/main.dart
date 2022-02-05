import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/all_users_bloc/bloc/all_users_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/bloc/company_list_bloc.dart';
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

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:mobile/Presentation/Screens/home_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'Data_Layer/Repoositories/user_repository.dart';
import 'Presentation/Screens/userProfile_fillScreen.dart';

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

void main() {
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

class MyApp extends StatelessWidget {
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
                sessionBLoc: context.read<SessionBLoc>())),
        BlocProvider<CompanyListBloc>(
            create: (context) => CompanyListBloc(
                companyRepository: context.read<CompanyRepository>())),
        BlocProvider<AllUsersBloc>(
            create: (context) => AllUsersBloc(
                allUsersRepository: allUsersRepository,
                userRepository: context.read<UserRepository>()))
      ],
      child: MaterialApp(
          home: BlocConsumer<SessionBLoc, SessionState>(
            listenWhen: (previous, current) {
              if (previous == current) {}
              return true;
            },
            listener: (context, state) {
              if (state is AuthenticatedWithProfile) {
                getPath();
                // context.read<ShirtBloc>().add(fetchfeaturedShirtsOnLogin());
                context.read<AtrocityBlocBloc>().fetchAtrocitiesonStart();
                context.read<NonprofitBloc>().fetchNonProfitsOnLogin();
                context.read<CategoryBloc>().add(FetchCategory());
                Navigator.of(context).pushNamed('/home',
                    arguments: HomeArguments(
                        profile: state.profile, user: state.user));
              }
            },
            buildWhen: (previous, current) {
              if (previous == current) {
                print('The state was $previous and now the state is $current');
                return false;
              }
              print('the state was $previous and now the state is $current');
              return true;
            },
            builder: (context, state) {
              if (state is AuthenticatedWithProfile &&
                  state.user.hasProfile == 1) {
                // context.read<ShirtBloc>().fetchfeaturedShirtsOnLogin();
                // context.read<AtrocityBlocBloc>().fetchAtrocitiesonStart();
                // context.read<NonprofitBloc>().fetchNonProfitsOnLogin();
                // context.read<CategoryBloc>().add(FetchCategory());
              } else if (state is Authenticated) {
                return UserProfileComplete(
                  user: state.user,
                );
              }
              return BlocProvider(
                create: (context) => ValidationCubit(
                    userProfileEditBloc: context.read<UserProfileEditBloc>(),
                    userRepository: context.read<UserRepository>(),
                    sessionBloc: context.read<SessionBLoc>()),
                child: AuthNavigator(),
              );
            },
          ),
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              builder: (BuildContext context) => makeRoute(
                  context: context,
                  routeName: settings.name!,
                  arguments: settings.arguments),
            );
          }),
    );
  }
}
