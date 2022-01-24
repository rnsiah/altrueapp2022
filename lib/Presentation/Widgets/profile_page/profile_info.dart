import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Presentation/Widgets/profile_page/rounded_image.dart';

class MyInfo extends StatelessWidget {
  final Profile profile;

  MyInfo({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedImage(
            imagePath: profile.profilePicture!.url,
            size: Size.fromWidth(120.0),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                profile.username!,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Text(
                ", 24",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "  34 kilometers",
                style: TextStyle(color: Colors.white, fontSize: 12),
              )
            ],
          ),
        ],
      ),
    );
  }
}
