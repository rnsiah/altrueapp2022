import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/all_users_bloc/bloc/all_users_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/bloc/company_list_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/nonprofit_bloc/bloc/nonprofit_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';

import 'package:mobile/Data_Layer/Blocs/shirt_bloc/bloc/shirt_bloc.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Models/order_item_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_color_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_size_model.dart';

import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/atrocity_repositories.dart';
import 'package:mobile/Data_Layer/Repoositories/shirt_repository.dart';
import 'package:mobile/Presentation/Router/functionality_router.dart';
import 'package:mobile/Presentation/Screens/atrocity_details.dart';
import 'package:mobile/Presentation/Widgets/cart_bottom_screen.dart';
import 'package:mobile/Presentation/Widgets/cart_icon.dart';

import 'package:mobile/Presentation/Widgets/profile_drawer.dart';
import 'package:mobile/Presentation/Widgets/weekly_featured_shirts.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  final User user;
  final ProfileBloc profileBloc;
  final Profile profile;
  final CartBloc cartBloc;

  HomePage(
      {Key? key,
      required this.user,
      required this.profile,
      required this.profileBloc,
      required this.cartBloc})
      : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late PageController _pageController;
  AtrocityRepository atrocityRepository = AtrocityRepository();
  ShirtRepository shirtRepository = ShirtRepository();

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
  // void showCart(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (_) {
  //         return DraggableScrollableSheet(builder: (_, controller) {});
  //       });
  // }

  Future<List<Shirt>> getFeaturedShirts() async {
    List<Shirt> shir = [];
    List<Shirt> theshirts = await shirtRepository.featuredShirts();
    for (Shirt shirt in theshirts) {
      shir.add(shirt);
    }
    return shir;
  }

  Future<void> updateProfileState(
      ProfileBloc profileBloc, Profile profile) async {
    profileBloc.add(FetchProfile(profile: profile));
  }

  Future<void> updateCart(CartBloc cartBloc) async {
    cartBloc.add(CartBeingLoaded());
  }

  @override
  void initState() {
    widget.cartBloc.add(CartBeingLoaded());
    updateProfileState(widget.profileBloc, widget.profile);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    updateCart(widget.cartBloc);

    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);

    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  AnimationController? _animationController;

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
                builder: (_) => AtrocityDetails(
                    profile: widget.profile, atrocity: atrocities[index]))),
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
                child: Container(
                  color: Colors.black.withOpacity(.25),
                  width: 240,
                  child: Text(
                    atrocities[index].title.toUpperCase(),
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: widget.profileBloc,
        ),
        BlocProvider.value(
          value: widget.cartBloc,
        ),
      ],
      child: Scaffold(
        onDrawerChanged: (isOpened) {},
        backgroundColor: Colors.white,
        drawer: ProfileDrawer(profile: widget.profile),
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          elevation: 0,
          title: Stack(children: [
            Image(
              image: AssetImage('images/Altrue Logo White.png'),
            ),
            Positioned(
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.orange,
                    )),
                right: -22,
                bottom: -12),
          ]),
          actions: <Widget>[
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return CartIcon(
                  notificationCount:
                      state.status == CartStatus.loaded ? state.cart.length : 0,
                  text: 'cart',
                  iconData: Icons.shopping_cart,
                  onTap: () async {
                    showModalBottomSheet(
                        isDismissible: true,
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25.0)),
                        ),
                        builder: (_) => DraggableScrollableSheet(
                              expand: false,
                              maxChildSize: .75,
                              minChildSize: .4,
                              initialChildSize: .55,
                              builder: (_, controller) => CartBottomScreen(
                                controller: controller,
                                cartList: state.cart,
                              ),
                            ));
                  },
                );
              },
            )
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
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      child: Text(
                        'All Atrocities',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () {
                        context.read<CategoryBloc>().add(FetchCategory());
                        Navigator.of(context).pushNamed('/atrocities',
                            arguments:
                                AtrocityListArguments(profile: widget.profile));
                      }),
                ],
              ),
            ),
            BlocBuilder<AtrocityBlocBloc, AtrocityBlocState>(
                builder: (context, state) {
              return Container(
                height: 200,
                width: double.infinity,
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: state.featuredAtrocities.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _shirtSelector(index, state.featuredAtrocities);
                    }),
              );
            }),
            BlocBuilder<ShirtBloc, ShirtState>(builder: (context, state) {
              return FeaturedShirts(
                  profile: widget.profile,
                  shirtlist: state.featuredShirts,
                  title: "Altrue's collection of the week",
                  imageHeight: 180,
                  imageWidth: 120);
            }),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BlocBuilder<NonprofitBloc, NonprofitState>(
                          builder: (context, state) {
                            return Expanded(
                              child: MaterialButton(
                                color: Colors.black,
                                child: Text(
                                  'Non Profits',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {
                                  context
                                      .read<CategoryBloc>()
                                      .add(FetchCategory());
                                  Navigator.of(context).pushNamed('/nonprofits',
                                      arguments: widget.profile);
                                  // context.read<CategoryBloc>().add(FetchCategory());
                                  // context.read<NonprofitBloc>().add(FetchNonProfitList());
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            child: Text(
                              'Causes',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            color: Colors.black,
                            onPressed: () {
                              context.read<CategoryBloc>().add(FetchCategory());
                              Navigator.of(context).pushNamed('/causes');
                            },
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Container(
                            child: BlocBuilder<ShirtBloc, ShirtState>(
                              builder: (context, state) {
                                if (state.status == ShirtStatus.successful) {
                                  return MaterialButton(
                                    color: Colors.green,
                                    child: Text(
                                      'Shirts',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      context
                                          .read<CategoryBloc>()
                                          .add(FetchCategory());
                                      Navigator.of(context).pushNamed('/shirts',
                                          arguments:
                                              widget.profileBloc.state.profile);
                                      // context.read<ShirtBloc>().add(FetchShirts());
                                    },
                                  );
                                }
                                return MaterialButton(
                                  color: Colors.red,
                                  child: Text(
                                    'Shirts',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/shirts');
                                    // context.read<ShirtBloc>().add(FetchShirts());
                                    // context.read<CategoryBloc>().add(FetchCategory());
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: MaterialButton(
                              child: Text('Companies',
                                  style: TextStyle(color: Colors.white)),
                              color: Colors.black,
                              onPressed: () {
                                context
                                    .read<CategoryBloc>()
                                    .add(FetchCategory());
                                context
                                    .read<CompanyListBloc>()
                                    .add(FetchCompanyList(user: widget.user));
                                Navigator.of(context).pushNamed('/companies');
                              }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: MaterialButton(
                child: Text(
                  'Find Friends',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
                onPressed: () {
                  context.read<AllUsersBloc>().add(FetchFindUserList());
                  Navigator.of(context)
                      .pushNamed('/findfriends', arguments: widget.profile);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: MaterialButton(
                  color: Colors.black,
                  child: Text('User DashBoard',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () => Navigator.of(context).pushNamed(
                      '/companyDashboard',
                      arguments:
                          DashBoardScreenArguments(profile: widget.profile))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: MaterialButton(
                  color: Colors.black,
                  child: Text(
                    'Payment Details',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/creditCardDetails')),
            ),
          ],
        ),
      ),
    );
  }
}
