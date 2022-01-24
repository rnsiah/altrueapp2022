import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';

class SupporterPage extends StatelessWidget {
  final Profile profile;

  const SupporterPage({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Image(
              image: AssetImage('images/Altrue Logo White.png'),
            )),
        body: ListView(scrollDirection: Axis.vertical, children: [
          Container(
              height: 800,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: profile.donor!.length,
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed('love'),
                      child: Card(
                          child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text(profile.donor![index].firstName +
                                " " +
                                profile.donor![index].lastName),
                            subtitle: Text('Donated On: '),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(profile.donor![index].amountDonated),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Email email = Email(
                                      subject:
                                          'Hey ${profile.donor![index].firstName}, thanks for donating',
                                      body: 'Hey' +
                                          profile.donor![index].firstName +
                                          'I want to thank you for donating to my efforts in helping the efforts towards ${profile.donor![index].altruCategory} on the Altrue platform!',
                                      recipients: [profile.donor![index].email],
                                      isHTML: false);
                                  FlutterEmailSender.send(email);
                                },
                                child: Text(
                                  'Say Thanks Now',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          )
                        ],
                        mainAxisSize: MainAxisSize.min,
                      )),
                    );
                  }))
        ]));
  }
}
