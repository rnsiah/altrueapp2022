import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';

class MyCompanyHome extends StatefulWidget {
  final Profile profile;

  const MyCompanyHome({required this.profile});

  @override
  _MyCompanyHomeState createState() => _MyCompanyHomeState();
}

class _MyCompanyHomeState extends State<MyCompanyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.black,
    ));
  }
}
