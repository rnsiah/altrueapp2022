import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';

class MyQrScreen extends StatelessWidget {
  const MyQrScreen({Key? key, required this.profile}) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image(
            image: AssetImage('images/Altrue Logo White.png'),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image(
                      image: NetworkImage(profile.qrCode!, scale: .10),
                    ),
                    SizedBox(height: 43),
                    Text(
                      'Scan' +
                          profile.username! +
                          's profile to donate to support their favorite causes',
                      style: TextStyle(fontSize: 22, color: Colors.amber),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ))));
  }
}
