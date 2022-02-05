import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/all_users_bloc/bloc/all_users_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/bloc/company_list_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/nonprofit_bloc/bloc/nonprofit_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/session_cubit.dart';
import 'package:mobile/Data_Layer/Blocs/shirt_bloc/bloc/shirt_bloc.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';

import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/atrocity_repositories.dart';
import 'package:mobile/Data_Layer/Repoositories/shirt_repository.dart';
import 'package:mobile/Presentation/Router/functionality_router.dart';
import 'package:mobile/Presentation/Screens/atrocity_details.dart';

import 'package:mobile/Presentation/Widgets/profile_drawer.dart';
import 'package:mobile/Presentation/Widgets/weekly_featured_shirts.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  final User user;
  final Profile profile;

  HomePage({Key? key, required this.user, required this.profile})
      : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  AtrocityRepository atrocityRepository = AtrocityRepository();
  ShirtRepository shirtRepository = ShirtRepository();

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  List<Atrocity> atrocityList = [];
  List<Shirt> featuredShirts = [];

  // Future<List<Atrocity>> getAtrocities() async {
  //   List<Atrocity> atr = [];
  //   List<Atrocity> allAtro = await atrocityRepository.getFeaturedAtrocities();
  //   for (Atrocity atro in allAtro) {
  //     atr.add(atro);
  //   }
  //   return atr;
  // }

  Future<List<Shirt>> getFeaturedShirts() async {
    List<Shirt> shir = [];
    List<Shirt> theshirts = await shirtRepository.featuredShirts();
    for (Shirt shirt in theshirts) {
      shir.add(shirt);
    }
    return shir;
  }

  AnimationController? animationController;

  // void setUP() async {
  //   await getAtrocities().then((value) async {
  //     atrocityList = value;
  //   });
  //   await getFeaturedShirts().then((shirtValue) async {
  //     featuredShirts = shirtValue;
  //   });
  // }

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    super.initState();
  }

  _shirtSelector(int index, List<Atrocity> atrocities) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page! - index;
          value = (1 - (value.abs() * 0.3) + 0.6).clamp(0, 1);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 350,
            width: Curves.easeInOut.transform(value) * 450,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => AtrocityDetails(atrocity: atrocities[index]))),
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0, 4),
                          blurRadius: 10)
                    ]),
                child: Center(
                  child: Hero(
                      tag: atrocities[index].imageUrl!,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: NetworkImage(atrocities[index].imageUrl!),
                          height: 220,
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
              ),
            ),
            Positioned(
                left: 30,
                bottom: 40,
                child: Text(
                  atrocities[index].title.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ProfileBloc profileBloc = context.read<ProfileBloc>();
    ShirtBloc shirtBloc = context.read<ShirtBloc>();
    AtrocityBlocBloc atrocityBloc = context.read<AtrocityBlocBloc>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>.value(value: profileBloc),
        BlocProvider<ShirtBloc>.value(value: shirtBloc),
        BlocProvider<AtrocityBlocBloc>.value(value: atrocityBloc),
      ],
      child: Scaffold(
        onDrawerChanged: (isOpened) {
          context
              .read<ProfileBloc>()
              .add(FetchProfile(profile: widget.profile));
        },
        backgroundColor: Colors.white,
        drawer: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return ProfileDrawer(
                profile: state.profile!,
                animationController: animationController);
          },
        ),
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
        body: ListView(
          children: [
            Text(widget.profile.user.toString()),
            Container(
              margin: EdgeInsets.all(7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  'Featured Atrocities'.text.black.size(18).bold.make(),
                  MaterialButton(
                      color: Colors.black,
                      child: Text(
                        'All Atrocities',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/atrocities');
                      }),
                ],
              ),
            ),
            BlocBuilder<AtrocityBlocBloc, AtrocityBlocState>(
              builder: (context, state) {
                if (state.featuredAtrocities.isNotEmpty) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    child: PageView.builder(
                        controller: _pageController,
                        itemCount: state.featuredAtrocities.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _shirtSelector(
                              index, state.featuredAtrocities);
                        }),
                  );
                }
                return Container(
                  height: 200,
                  width: double.infinity,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
            BlocBuilder<ShirtBloc, ShirtState>(
              builder: (context, state) {
                if (state.featuredShirts.isNotEmpty) {
                  return FeaturedShirts(
                      shirtlist: state.featuredShirts,
                      title: "Altrue's collection of the week",
                      imageHeight: 150,
                      imageWidth: 100);
                }
                return Container(
                  height: 150,
                  width: double.infinity,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
            BlocBuilder<ShirtBloc, ShirtState>(
              builder: (context, state) {
                if (state.status == ShirtStatus.successful) {
                  return MaterialButton(
                    color: Colors.green,
                    child: Text(
                      'Shirts',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/shirts');
                      // context.read<ShirtBloc>().add(FetchShirts());
                      context.read<CategoryBloc>().add(FetchCategory());
                    },
                  );
                }
                return MaterialButton(
                  color: Colors.red,
                  child: Text(
                    'Shirts',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/shirts');
                    // context.read<ShirtBloc>().add(FetchShirts());
                    // context.read<CategoryBloc>().add(FetchCategory());
                  },
                );
              },
            ),
            MaterialButton(
              color: Colors.black,
              child: Text(
                'Non Profits',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/nonprofits', arguments: widget.profile);
                // context.read<CategoryBloc>().add(FetchCategory());
                // context.read<NonprofitBloc>().add(FetchNonProfitList());
              },
            ),
            MaterialButton(
              child: Text(
                'Causes',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              color: Colors.black,
              onPressed: () {
                context.read<CategoryBloc>().add(FetchCategory());
                Navigator.of(context).pushNamed('/causes');
              },
            ),
            MaterialButton(
                child: Text('Companies',
                    style: TextStyle(color: Colors.white, fontSize: 24)),
                color: Colors.black,
                onPressed: () {
                  context
                      .read<CompanyListBloc>()
                      .add(FetchCompanyList(user: widget.user));
                  Navigator.of(context).pushNamed('/companies');
                }),
            MaterialButton(
              child: Text(
                'Find Friends',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              onPressed: () {
                context.read<AllUsersBloc>().add(FetchFindUserList());
                Navigator.of(context)
                    .pushNamed('/findfriends', arguments: widget.user);
              },
            ),
            MaterialButton(
                child: Text('company match'),
                onPressed: () => Navigator.of(context).pushNamed(
                    '/companyDashboard',
                    arguments: DashBoardScreenArguments(
                        animationController: animationController!,
                        profile: widget.profile))),
            MaterialButton(
                child: Text('CreditCard'),
                onPressed: () =>
                    Navigator.of(context).pushNamed('/creditCardDetails')),
            Text(widget.user.email!)
          ],
        ),
      ),
    );
  }
}
