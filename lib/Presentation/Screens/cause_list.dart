import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/category_bloc/bloc/category_bloc.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Presentation/Router/functionality_router.dart';

class CauseList extends StatefulWidget {
  final Profile profile;

  CauseList({required this.profile});
  @override
  State<CauseList> createState() => _CauseListState();
}

class _CauseListState extends State<CauseList> {
  String getfewWords(String words) {
    List<String> splitWords = words.split(" ");
    List<String> newWords = splitWords.sublist(0, 10);
    if (newWords.length >= 8) {
      return newWords.join(' ');
    }
    return words;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(
          image: AssetImage('images/Altrue Logo White.png'),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Container(
          child: SafeArea(
              child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18, bottom: 20),
              child: Text(
                'Altrue Causes',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            // DropdownButton(items: [
            //   DropdownMenuItem(
            //       child: Text(
            //     'T-Shirts',
            //     style: TextStyle(
            //         fontSize: 24,
            //         color: Colors.black,
            //         fontWeight: FontWeight.w600),
            //     textAlign: TextAlign.left,
            //   )),
            // ], onChanged: (value) {  },),
            Container(
              height: 600,
              padding: EdgeInsets.only(left: 32),
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categoryList.length,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () => Navigator.of(context).pushNamed(
                              '/causeView',
                              arguments: CategoryArguments(
                                  category: state.categoryList[index],
                                  profile: widget.profile),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 400,
                                width: MediaQuery.of(context).size.width * .8,
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 110),
                                        Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            elevation: 10,
                                            color: Colors.black,
                                            child: Padding(
                                              padding: EdgeInsets.all(32),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'A',
                                                    style: TextStyle(
                                                        shadows: [
                                                          Shadow(
                                                              offset: Offset(
                                                                  1.4, 1.4),
                                                              blurRadius: 10.0,
                                                              color:
                                                                  Colors.white)
                                                        ],
                                                        color: Colors.white,
                                                        fontSize: 60,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  SizedBox(height: 40),
                                                  Text(
                                                      state.categoryList[index]
                                                          .name!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 32,
                                                          color: Colors.white),
                                                      textAlign:
                                                          TextAlign.left),
                                                  Text(
                                                    'Altrue Cause',
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  SizedBox(height: 30),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Container(
                                                      width: 165,
                                                      child: Text(
                                                        state
                                                                .categoryList[
                                                                    index]
                                                                .nonprofitCount
                                                                .toString() +
                                                            ' organizations fighting to end this cause',
                                                        softWrap: true,
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color:
                                                                Colors.amber),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    state.categoryList[index]
                                                                .name !=
                                                            'All Causes'
                                                        ? getfewWords(state
                                                                .categoryList[
                                                                    index]
                                                                .information!) +
                                                            '...'
                                                        : '',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text('Learn More',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .amber)),
                                                      Icon(Icons.arrow_forward,
                                                          color: Colors.amber)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                    Positioned(
                                      top: -17,
                                      right: -30,
                                      width: 250,
                                      height: 250,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: NetworkImage(state
                                                  .categoryList[index].image!)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                },
              ),
            )
          ],
        ),
      ))),
    );
  }
}
