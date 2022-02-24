import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/category_bloc/bloc/category_bloc.dart';

class CauseList extends StatefulWidget {
  @override
  State<CauseList> createState() => _CauseListState();
}

class _CauseListState extends State<CauseList> {
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
              padding: EdgeInsets.all(32),
              child: Text(
                'Altrue Causes',
                style: TextStyle(
                    fontSize: 44,
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
              height: 500,
              padding: EdgeInsets.only(left: 32),
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categoryList.length,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () => Navigator.of(context).pushNamed(
                                  '/causeView',
                                  arguments: state.categoryList[index]),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 100),
                                      Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 0,
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: EdgeInsets.all(32),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 100),
                                                Text(
                                                    state.categoryList[index]
                                                        .name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 32,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.left),
                                                Text(
                                                  'Altrue Cause',
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                  textAlign: TextAlign.left,
                                                ),
                                                SizedBox(height: 30),
                                                Row(
                                                  children: [
                                                    Text('Learn More',
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.amber)),
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
                                    width: 250,
                                    height: 250,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(state
                                                .categoryList[index].image)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                  );
                },
              ),
            )
          ],
        ),
      ))),
    );
  }
}
