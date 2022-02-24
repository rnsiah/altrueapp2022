import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/bloc/company_list_bloc.dart';
import 'package:mobile/Data_Layer/Repoositories/category_repository.dart';
import 'package:mobile/Data_Layer/Repoositories/company_repository.dart';

class CompanyList extends StatefulWidget {
  const CompanyList({Key? key}) : super(key: key);

  @override
  _CompanyListState createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList> {
  @override
  void initState() {
    super.initState();
  }

  // _featuredCompaniesSelector(int index) {
  //   return BlocBuilder<CompanyListBloc, CompanyListState>(
  //     builder: (context, state) {
  //       if (state is ) {
  //         return AnimatedBuilder(
  //           animation: _pageController,
  //           builder: (BuildContext context, Widget? widget) {
  //             double value = 2;
  //             if (_pageController.position.haveDimensions) {
  //               value = _pageController.page! - index;
  //               value = (1 - (value.abs() * 0.3) + 0.6).clamp(0, 1);
  //             }
  //             return Center(
  //               child: SizedBox(
  //                 height: Curves.easeInOut.transform(value) * 350,
  //                 width: Curves.easeInOut.transform(value) * 400,
  //                 child: widget,
  //               ),
  //             );
  //           },
  //           child: GestureDetector(
  //             onTap: () => Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (_) =>
  //                         CompanyDetails(company: state.companyList[index]))),
  //             child: Stack(
  //               children: [
  //                 Center(
  //                   child: Container(
  //                     margin:
  //                         EdgeInsets.symmetric(horizontal: 10, vertical: 20),
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(10),
  //                         boxShadow: [
  //                           BoxShadow(
  //                               color: Colors.black54,
  //                               offset: Offset(0, 4),
  //                               blurRadius: 10)
  //                         ]),
  //                     child: Center(
  //                       child: Hero(
  //                           tag: state.companyList[index].logo,
  //                           child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(10),
  //                             child: Image(
  //                               image:
  //                                   NetworkImage(state.companyList[index].logo),
  //                               height: 220,
  //                               fit: BoxFit.fill,
  //                             ),
  //                           )),
  //                     ),
  //                   ),
  //                 ),
  //                 Positioned(
  //                     left: 30,
  //                     bottom: 40,
  //                     child: Text(
  //                       state.companyList[index].name.toUpperCase(),
  //                       overflow: TextOverflow.ellipsis,
  //                       style: TextStyle(
  //                           fontSize: 16,
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.bold),
  //                     ))
  //               ],
  //             ),
  //           ),
  //         );
  //       }
  //       return CircularProgressIndicator();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image(
          image: AssetImage('images/Altrue Logo White.png'),
        ),
      ),
      body: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => CategoryRepository()),
          RepositoryProvider(create: (_) => CompanyRepository())
        ],
        child: Column(
          children: [
            // Container(
            //   width: double.infinity,
            //   height: 200,
            //   child: PageView.builder(
            //       controller: _pageController,
            //       itemBuilder: (BuildContext context, int index) {
            //         return _featuredCompaniesSelector(index);
            //       }),
            // ),
            BlocProvider(
              create: (context) => context.read<CompanyListBloc>(),
              child: BlocBuilder<CompanyListBloc, CompanyListState>(
                builder: (context, state) {
                  return Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: GridView.builder(
                            itemCount: state.companies.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 27,
                                    mainAxisSpacing: 13,
                                    childAspectRatio: .75,
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    print(state.companies[index].name);
                                    Navigator.of(context).pushNamed(
                                        '/companyDetails',
                                        arguments: state.companies[index]);
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
                                          state.companies[index].logo!,
                                          scale: .7,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Text(
                                          state.companies[index].name,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
