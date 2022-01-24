import 'package:flutter/material.dart';

class ShirtCounter extends StatefulWidget {
  @override
  _ShirtCounterState createState() => _ShirtCounterState();
}

class _ShirtCounterState extends State<ShirtCounter> {
  int numOfItems = 3;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 40,
          height: 32,
          child: OutlinedButton(
            style: ButtonStyle(),
            onPressed: () {
              if (numOfItems > 1) {
                setState(() {
                  numOfItems--;
                });
              }
            },
            child: Icon(Icons.remove),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(
          width: 40,
          height: 32,
          child: OutlinedButton(
            style: ButtonStyle(),
            onPressed: () {
              setState(() {
                numOfItems++;
              });
            },
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
