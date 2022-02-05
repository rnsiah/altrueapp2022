import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:mobile/Data_Layer/Models/shirt_color_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';

class ColorAndSize extends StatefulWidget {
  ColorAndSize({
    Key? key,
    required this.shirt,
  }) : super(key: key);

  final Shirt shirt;

  @override
  State<ColorAndSize> createState() => _ColorAndSizeState();
}

class _ColorAndSizeState extends State<ColorAndSize> {
  List<Widget> _buildColorPicker() {
    return widget.shirt.variations!.map((color) {
      return ColorDot(
        color: Color(int.parse(color.color.hex)),
        sendToBloc: () {
          print('sent to shirtBloc');
          context.read<ShirtOrderBlocBloc>().add(ShirtColorChange(
              shirtColor: ShirtColor(
                  color: color.color.toString(),
                  id: widget.shirt.variations!.length,
                  hex: color.color.hex)));
        },
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ShirtOrderBlocBloc shirtOrderBlocBloc = context.read<ShirtOrderBlocBloc>();
    return BlocProvider.value(
      value: shirtOrderBlocBloc,
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Choose Color",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),

              Row(
                children: _buildColorPicker(),
              ),

              // Container(
              //   child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: widget.shirt.availableColors!.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return ColorDot(
              //             color: Color(int.parse(
              //                 widget.shirt.availableColors![index].hex)));
              //       }),
              // )
            ],
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatefulWidget {
  final Color color;
  Function? sendToBloc;
  bool isSelected;
  ColorDot({
    Key? key,
    required this.color,
    this.sendToBloc,

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
        widget.sendToBloc!();
        setState(() {
          if (widget.isSelected == true) {
            widget.isSelected = false;
          } else if (widget.isSelected == false) {
            widget.isSelected = true;
          }
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
            color: widget.isSelected ? Colors.black : Colors.transparent,
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
