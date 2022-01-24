import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';

class UserNonProfits extends StatelessWidget {
  final Profile profile;
  const UserNonProfits({required this.profile}) : super();

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
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    profile.username!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 9,
                ),
                Text(
                  'balance:${profile.balance}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            height: 800,
            width: double.infinity,
            child: ListView.builder(
                itemCount: profile.nonProfitList!.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                      onLongPress: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 350,
                                child: Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    children: [
                                      Text('Make A Donation To: '),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        profile.nonProfitList![index].name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text('Enter Donation Amount'),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        height: 40,
                                        child: TextField(),
                                        width: 70,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text('Raised By Altrue',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                      SizedBox(
                                        height: 14,
                                      ),
                                      Text(
                                        profile.nonProfitList![index].balance
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Card(
                        child: ListTile(
                          leading: Image(
                            image: NetworkImage(
                                profile.nonProfitList![index].logo),
                          ),
                          title: Column(children: [
                            Text(
                              'Altrue Organization',
                              style: TextStyle(fontSize: 7),
                            ),
                            Text(
                              profile.nonProfitList![index].name,
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ]),
                          trailing: Column(children: [
                            Text('Amount Donated'),
                            Text(profile.nonProfitList![index].balance
                                .toString())
                          ]),
                        ),
                      ));
                }),
          )
        ],
      ),
    );
  }
}
