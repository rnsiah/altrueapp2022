import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';

class AtrocityStatistics extends StatefulWidget {
  final Atrocity atrocity;

  const AtrocityStatistics({Key? key, required this.atrocity})
      : super(key: key);

  @override
  _AtrocityStatisticsState createState() => _AtrocityStatisticsState();
}

class _AtrocityStatisticsState extends State<AtrocityStatistics> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Atrocity Altrue Stats'),
    );
  }
}
