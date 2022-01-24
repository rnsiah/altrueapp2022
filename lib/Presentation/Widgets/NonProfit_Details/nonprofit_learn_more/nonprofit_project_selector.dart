import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/nonprofit_project_model.dart';

class ProjectSelector extends StatefulWidget {
  final NonProfit? nonProfit;
  ProjectSelector({
    required this.nonProfit,
    Key? key,
  }) : super(key: key);

  @override
  _ProjectSelectorState createState() => _ProjectSelectorState();
}

class _ProjectSelectorState extends State<ProjectSelector> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
