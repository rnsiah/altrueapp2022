import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/nonprofit_bloc/bloc/nonprofit_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/category_repository.dart';
import 'package:mobile/Data_Layer/Repoositories/nonProfit_repository.dart';
import 'package:mobile/Presentation/Router/functionality_router.dart';
import 'package:mobile/Presentation/Widgets/category_selector.dart';

class NonProfitList extends StatefulWidget {
  final Profile profile;

  NonProfitList({required this.profile});

  @override
  State<NonProfitList> createState() => _NonProfitListState();
}

class _NonProfitListState extends State<NonProfitList> {
  ProfileBloc? profileBloc;

  @override
  void initState() {
    profileBloc = context.read<ProfileBloc>();

    super.initState();
  }

  @override
  void dispose() {
    profileBloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Image(
          image: AssetImage('images/Altrue Logo White.png'),
        ),
      ),
      body: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<NonProfitRespository>(
              create: (_) => NonProfitRespository(),
            ),
            RepositoryProvider(create: (_) => CategoryRepository()),
          ],
          child: Column(
            children: [
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return CategorySelector(
                    isNonProfit: true,
                    isAtrocity: false,
                    isCompany: false,
                    isShirt: false,
                    categoryList: state.categoryList,
                  );
                },
              ),
              BlocBuilder<NonprofitBloc, NonprofitState>(
                builder: (context, state) {
                  return Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: GridView.builder(
                            itemCount: state.nonprofitList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 27,
                                    mainAxisSpacing: 18,
                                    childAspectRatio: .75,
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    context.read<NonprofitBloc>().add(
                                        FetchNonProfitItem(
                                            nonProfit:
                                                state.nonprofitList[index]));
                                    Navigator.of(context).pushNamed(
                                        '/nonProfitView',
                                        arguments: NonProfitDetailArguments(
                                            nonProfit:
                                                state.nonprofitList[index],
                                            profile: widget.profile));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Image.network(
                                          state.nonprofitList[index].logo,
                                          scale: .7,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Text(
                                          state.nonprofitList[index].name,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))),
                  );
                },
              )
            ],
          )),
    );
  }
}
