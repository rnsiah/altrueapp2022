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
                itemExtent: 100,
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
                          title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 5),
                                  child: Text(
                                    'Altrue Organization',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  profile.nonProfitList![index].name,
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ]),
                          trailing: Column(children: [
                            Text(
                              'Amount Donated',
                              style: TextStyle(
                                  fontSize: 8,
                                  height: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                            profile.nonProfitList![index].balance != null
                                ? Text(profile.nonProfitList![index].balance
                                    .toString())
                                : MaterialButton(
                                    height: 25,
                                    color: Colors.amber,
                                    onPressed: () {},
                                    child: Text('Donate'))
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
