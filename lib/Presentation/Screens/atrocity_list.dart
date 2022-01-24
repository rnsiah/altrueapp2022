import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/atrocity_bloc/bloc/atrocity_bloc_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Repoositories/atrocity_repositories.dart';
import 'package:mobile/Presentation/Widgets/category_selector.dart';

class AtrocityList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Image(
              image: AssetImage('images/Altrue Logo White.png'),
            ),
            backgroundColor: Colors.black),
        body: RepositoryProvider(
          create: (_) => AtrocityRepository(),
          child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => context.read<AtrocityBlocBloc>(),
                ),
                BlocProvider(create: (_) => context.read<CategoryBloc>())
              ],
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Global Causes',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      return CategorySelector(
                        isNonProfit: false,
                        isAtrocity: true,
                        isCompany: false,
                        isShirt: false,
                        categoryList: state.categoryList,
                      );
                    },
                  ),
                  BlocBuilder<AtrocityBlocBloc, AtrocityBlocState>(
                    builder: (context, state) {
                      return Container(
                          height: 800,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: state.atrocities.length,
                            itemBuilder: (context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  context.read<AtrocityBlocBloc>().add(
                                      AtrocityItemFteched(
                                          atrocity: state.atrocities[index]));
                                  Navigator.of(context).pushNamed(
                                      '/atrocityView',
                                      arguments: state.atrocities[index]);
                                },
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    height: 190,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: Offset(0, 3))
                                      ],
                                      image: DecorationImage(
                                          image: NetworkImage(state
                                              .atrocities[index].imageUrl!),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        state.atrocities[index].title,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                            backgroundColor: Colors.white),
                                      ),
                                    )),
                              );
                            },
                          ));
                    },
                  )
                ],
              )),
        ));
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class ShirtSelector extends StatefulWidget {
  final int index;

  const ShirtSelector({Key? key, required this.index}) : super(key: key);
  @override
  _ShirtSelectorState createState() => _ShirtSelectorState();
}

class _ShirtSelectorState extends State<ShirtSelector> {
  PageController pageController = PageController();
  late AtrocityBlocBloc atrocityBloc;

  late Atrocity atrocity;

  @override
  void initState() {
    pageController = PageController(initialPage: 1, viewportFraction: 0.8);
    atrocityBloc = context.read<AtrocityBlocBloc>();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    var index;
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, Widget? widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page! - index;
          value = (1 - (value.abs() * 0.3) + 0.6).clamp(0.0, 1.0);
        }
        return Center(
            child: SizedBox(
          height: Curves.easeInOut.transform(value) * 270.0,
          width: Curves.easeInOut.transform(value) * 400,
          child: widget,
        ));
      },
      child: BlocBuilder<AtrocityBlocBloc, AtrocityBlocState>(
        builder: (context, state) {
          return AtrocityCard(
            atrocity: atrocity,
          );
        },
      ),
    );
  }
}

class AtrocityCard extends StatelessWidget {
  final Atrocity atrocity;

  const AtrocityCard({Key? key, required this.atrocity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Center(
            child: Container(
              child: Center(
                child: Hero(
                  tag: atrocity.imageUrl!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: NetworkImage(atrocity.imageUrl!),
                      height: 220.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: 30,
              bottom: 40,
              child: Text(
                atrocity.title.toUpperCase(),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ))
        ],
      ),
    );
  }
}
