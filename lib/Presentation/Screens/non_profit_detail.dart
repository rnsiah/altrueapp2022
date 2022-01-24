import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Presentation/Widgets/Circular_Clipper.dart';
import 'package:mobile/Presentation/Widgets/NonProfit_Details/nonprofit_learn_more/nonprofit_learn_more.dart';
import 'package:mobile/Presentation/Widgets/NonProfit_Details/nonprofit_learn_more/nonprofit_learn_more_tabs.dart';
import 'package:mobile/Presentation/Widgets/NonProfit_Details/nonprofitdetail_tabs.dart';
import 'package:share_plus/share_plus.dart';

class NonProfitDetails extends StatelessWidget {
  final NonProfit nonProfit;
  final Profile profile;

  const NonProfitDetails(
      {Key? key, required this.nonProfit, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterButtons: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
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
                      context: context,
                      builder: (context) => NpDonate(
                            nonProfit: nonProfit,
                            profile: profile,
                          ));
                },
              ),
              MaterialButton(
                child: Text('Learn More',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => NPLearnMore(nonprofit: nonProfit));
                },
                color: Colors.amber,
              )
            ],
          ),
        )
      ],
      body: BlocProvider<ProfileBloc>(
        create: (context) => context.read<ProfileBloc>(),
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  transform: Matrix4.translationValues(0.0, -50, 0.0),
                  child: Hero(
                    tag: nonProfit.logo,
                    child: ClipShadowPath(
                      clipper: CircularClipper(),
                      shadow: Shadow(blurRadius: 20.0),
                      child: Image(
                        height: 400.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: NetworkImage(nonProfit.mainImage!),
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
                      color: Colors.white,
                    ),
                    Image(
                      image: AssetImage('images/Altrue Logo White.png'),
                      fit: BoxFit.scaleDown,
                      height: 60,
                      width: 150,
                    ),
                    IconButton(
                      padding: EdgeInsets.only(left: 0),
                      onPressed: () {
                        context
                            .read<ProfileBloc>()
                            .add(AddNonProfit(nonProfit: nonProfit));
                        print(nonProfit.name);
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
                      onPressed: () {},
                      shape: CircleBorder(),
                      fillColor: Colors.black,
                      child: Icon(
                        Icons.play_arrow,
                        size: 60.0,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
                Positioned(bottom: 5, right: 150, child: Text('Watch Video')),
                Positioned(
                  bottom: 115.0,
                  left: 22.0,
                  child: Column(children: [
                    RawMaterialButton(
                      elevation: 20,
                      padding: EdgeInsets.all(10),
                      fillColor: Colors.transparent,
                      shape: CircleBorder(),
                      onPressed: () {
                        Share.share(nonProfit.atrocity!.length == 0
                            ? 'Hey Everybody! Go check out ${nonProfit.name}, and all the good work they are currently doing '
                            : 'Hey Everybody! Go check out ${nonProfit.name}, and all the good work they are currently doing to help ');
                      },
                      child: Icon(
                        Icons.share,
                        size: 34,
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(
                      height: 6,
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
                  bottom: .0,
                  left: 20.0,
                  child: Column(children: [
                    Text('\$ ${nonProfit.balance}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 19)),
                    Text('Raised Already')
                  ]),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Text(
                          nonProfit.name.toUpperCase(),
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          child: Image(
                            image: NetworkImage(nonProfit.logo),
                            width: 150,
                            height: 75,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                            'Year Started:' + nonProfit.yearStarted.toString()),
                      ],
                    )
                  ]),

                  Container(),

                  Container(
                    height: 250,
                    width: double.infinity,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Text(
                          'Mission Statement',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.amber,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            nonProfit.missionStatement!,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Vision Statement',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            nonProfit.visionStatement!,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    )),
                  ),
                  SizedBox(height: 35),
                  Center(
                      child: Text('Support The Altrue Way',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.amber))),
                  SizedBox(
                    height: 14,
                  ),
                  NonProfitDetailTabs(nonProfit: nonProfit)
                  // NonProfitDetails(nonProfit: nonProfit)
                  //  Expanded(
                  //    child: ListView.builder(itemCount: widget.atrocities.category.length,
                  //      itemBuilder: (context, index)=>CategoryCard(
                  //        category:widget.atrocities.category[index],
                  //        press: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Cause_Details(category:widget.atrocities.category[index]))),
                  //      ),
                  // ),
                  //  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
