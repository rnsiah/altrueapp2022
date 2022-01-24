import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';

class ColorAndSize extends StatelessWidget {
  const ColorAndSize({
    Key? key,
    required this.shirt,
  }) : super(key: key);

  final Shirt shirt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Color"),
            Row(
              children: <Widget>[
                ColorDot(
                  color: Color(0xFF356C95),
                  isSelected: true,
                ),
                ColorDot(color: Color(0xFFF8C078)),
                ColorDot(color: Color(0xFFA29B9B)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class ColorDot extends StatefulWidget {
  final Color color;
  bool isSelected;
  ColorDot({
    Key? key,
    required this.color,
    // by default isSelected is false
    this.isSelected = false,
  }) : super(key: key);

  @override
  _ColorDotState createState() => _ColorDotState();
}

class _ColorDotState extends State<ColorDot> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isSelected = true;
        });
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 10 / 4,
          right: 10 / 2,
        ),
        padding: EdgeInsets.all(2.5),
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.isSelected ? widget.color : Colors.transparent,
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
