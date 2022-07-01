import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/altrue_action_model.dart';

class AltrueActionCard extends StatefulWidget {
  final AltrueAction? action;

  final int? levelNumber;
  AltrueActionCard({this.action, this.levelNumber});

  @override
  State<AltrueActionCard> createState() => _AltrueActionCardState();
}

class _AltrueActionCardState extends State<AltrueActionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (_) {
              return Dialog(
                backgroundColor: Colors.grey,
                insetPadding:
                    EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 12,
                child: Container(
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 70,
                          width: 140,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'images/Altrue Logo White.png'))),
                        ),
                        Text(
                          widget.action!.name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Reward: ' +
                              widget.action!.pointsAwarded!.toString() +
                              ' points',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.action!.info!,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          'Complete to unlock level ${widget.levelNumber} rewards and bonuses',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: Container(
        width: 300,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.9),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topRight: Radius.circular(68.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 14, left: 16, right: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8, top: 7),
                            child: Text(
                              'Altrue Action',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: -0.1,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.action!.name!,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.amber,
                        ),
                      )
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //       left: 24, right: 24, top: 8, bottom: 8),
                //   child: Container(
                //     height: 2,
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.all(Radius.circular(4.0)),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14, right: 6, top: 14, bottom: 7),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                'Reward',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              widget.action!.pointsAwarded.toString() +
                                  ' points',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Required',
                                style:
                                    TextStyle(fontSize: 8, color: Colors.white),
                              ),
                            ),
                            Container(
                              height: 39,
                              width: 39,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 1.5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    widget.levelNumber.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      letterSpacing: -0.2,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  Text(
                                    'Lvl',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 8,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
