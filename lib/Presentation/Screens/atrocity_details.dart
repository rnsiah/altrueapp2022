import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Presentation/Widgets/Atrocity_Details/atroc_donate.dart';
import 'package:mobile/Presentation/Widgets/Atrocity_Details/atrocity_details_tabs.dart';
import 'package:mobile/Presentation/Widgets/Circular_Clipper.dart';
import 'package:mobile/Presentation/Widgets/atrocity_learn_more/atrocity_learn_more_tabs.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class AtrocityDetails extends StatefulWidget {
  final Atrocity atrocity;
  final Profile profile;

  const AtrocityDetails(
      {Key? key, required this.atrocity, required this.profile})
      : super();
  @override
  _AtrocityDetailsState createState() => _AtrocityDetailsState();
}

class _AtrocityDetailsState extends State<AtrocityDetails> {
  _launchURL(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
        ),
        builder: (builder) {
          return new Container(
            height: 500.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
                child: new Center(
              child: new Text("This is a modal sheet"),
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                elevation: 12,
                child: Text(
                  'Donate Now',
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                color: Colors.black,
                onPressed: () {
                  showModalBottomSheet(
                      isDismissible: true,
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(50.0)),
                      ),
                      builder: (context) => DraggableScrollableSheet(
                          minChildSize: 0.3,
                          maxChildSize: 0.75,
                          expand: false,
                          builder: (_, controller) => AtrocityDonateModal(
                              atrocity: widget.atrocity,
                              profile: widget.profile)));
                },
              ),
              MaterialButton(
                elevation: 12,
                child: Text('Learn More',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          AtrocityLearnMoreTabs(atrocity: widget.atrocity));
                },
                color: Colors.amber,
              )
            ],
          ),
        )
      ],
      backgroundColor: Colors.black26,
      // body: SlidingUpPanel(
      //   parallaxEnabled: true,
      //   panel: Center(
      //     child: Text('Lern'),
      //   ),
      body: BlocProvider<ProfileBloc>(
        create: (context) => context.read<ProfileBloc>(),
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  transform: Matrix4.translationValues(0.0, -50, 0.0),
                  child: Hero(
                    tag: widget.atrocity.imageUrl!,
                    child: ClipShadowPath(
                      clipper: CircularClipper(),
                      shadow: Shadow(blurRadius: 20.0),
                      child: Image(
                        height: 400.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.atrocity.imageUrl!),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.only(left: 30),
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30,
                      color: Colors.amber,
                    ),
                    Image(
                      image: AssetImage('images/Altrue Logo White.png'),
                      fit: BoxFit.scaleDown,
                      height: 60,
                      width: 150,
                    ),
                    IconButton(
                      padding: EdgeInsets.only(left: 20),
                      onPressed: () {
                        print(widget.atrocity.slug);
                      },
                      icon: Icon(Icons.favorite),
                      iconSize: 30,
                      color: Colors.amber,
                    ),
                  ],
                ),
                Positioned.fill(
                  bottom: 30.0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RawMaterialButton(
                      elevation: 12.0,
                      padding: EdgeInsets.all(10),
                      onPressed: () => _launchURL(widget.atrocity.videoURL),
                      shape: CircleBorder(),
                      fillColor: Colors.white,
                      child: Icon(Icons.play_arrow,
                          size: 60.0, color: Colors.black),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 5,
                    right: 150,
                    child: Text('Watch Video',
                        style: TextStyle(color: Colors.white))),
                Positioned(
                  bottom: 0,
                  right: 25,
                  child: Column(children: [
                    Text(
                      '5',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Colors.white),
                    ),
                    Text('Donations', style: TextStyle(color: Colors.white))
                  ]),
                ),
                Positioned(
                    bottom: 0,
                    left: 20,
                    child: Column(children: [
                      Text("\$" + widget.atrocity.balance.toString(),
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(
                        'Altrue Funds Raised:',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ])),
                Text(widget.atrocity.balance.toString(),
                    style: TextStyle(color: Colors.white)),
                Positioned(
                  bottom: 90.0,
                  left: 20.0,
                  child: Column(children: [
                    IconButton(
                      onPressed: () => Share.share(widget.atrocity.title),
                      icon: Icon(Icons.share),
                      iconSize: 40.0,
                      color: Colors.amber,
                    ),
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      color: Colors.black,
                      child: Text('Share ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.amber)),
                    ),
                  ]),
                ),
                Positioned(
                  bottom: 90.0,
                  right: 25.0,
                  child: Column(children: [
                    IconButton(
                      onPressed: () {
                        print(widget.atrocity.slug);
                        context
                            .read<ProfileBloc>()
                            .add(AddAtrocity(atrocity: widget.atrocity));
                      },
                      icon: Icon(Icons.add),
                      iconSize: 40.0,
                      color: Colors.amber,
                    ),
                    Container(
                      color: Colors.black,
                      width: 50,
                      child: Text('Follow ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.amber)),
                    ),
                  ]),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Text(
                            widget.atrocity.title.toUpperCase(),
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                              width: 90,
                              height: 60,
                              child: Image(
                                fit: BoxFit.contain,
                                image:
                                    NetworkImage(widget.atrocity.country!.flag),
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'REGION:',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(widget.atrocity.region!.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 6),
                  SizedBox(height: 8),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        "What's Going On:",
                        style: TextStyle(fontSize: 18, color: Colors.amber),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: SingleChildScrollView(
                      child: Text(
                        widget.atrocity.info!,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AtrocityDetailTabs(
                atrocity: widget.atrocity, profile: widget.profile)
          ],
        ),
      ),
    );
  }

  // Widget _panel(ScrollController sc) {
  //   return MediaQuery.removePadding(
  //       context: context,
  //       removeTop: true,
  //       child: ListView(controller: sc, children: [
  //         Text('Support Today'),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         AtrocityDetails(atrocity: widget.atrocity)
  //       ]));
  // }
}
