import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:mobile/Presentation/Widgets/shirt_order/shirt_order_widget.dart';

import 'package:mobile/Data_Layer/Blocs/profile_bloc/bloc/profile_bloc.dart';

import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Repoositories/shirt_repository.dart';

import 'package:mobile/Presentation/Widgets/Circular_Clipper.dart';
import 'package:mobile/Presentation/Widgets/Shirt_Details/shirt_details_tab.dart';

// ignore: must_be_immutable
class ShirtDetails extends StatefulWidget {
  late Shirt shirt;
  ShirtDetails({required this.shirt});

  @override
  _ShirtDetailsState createState() => _ShirtDetailsState();
}

ShirtRepository shirtRepository = ShirtRepository();

class _ShirtDetailsState extends State<ShirtDetails>
    with TickerProviderStateMixin {
  _getShirtDetails() async {
    Shirt theshirt = await shirtRepository.fetchShirt(widget.shirt.id!);
    return theshirt;
  }

  void initState() {
    _getShirtDetails().then((value) {
      widget.shirt = value;
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<ShirtOrderBlocBloc>(),
      child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              context.read<ShirtOrderBlocBloc>();
              showModalBottomSheet(
                  backgroundColor: Colors.white.withOpacity(.9),
                  context: context,
                  builder: (_) => ShirtOrderForm(
                        shirt: widget.shirt,
                      ));
            },
            backgroundColor: Colors.amber,
            label: Text(
              'Get Now',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(Icons.shopping_cart_rounded),
          ),
          body: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => context.read<ProfileBloc>()),
              ],
              child: ListView(children: <Widget>[
                Stack(children: <Widget>[
                  Container(
                    transform: Matrix4.translationValues(0.0, -50, 0.0),
                    child: Hero(
                      tag: widget.shirt.originalImage!,
                      child: ClipShadowPath(
                        clipper: CircularClipper(),
                        shadow: Shadow(blurRadius: 20.0),
                        child: Image(
                          height: 340.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.shirt.originalImage!),
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
                        padding: EdgeInsets.only(left: 2),
                        onPressed: () {
                          context
                              .read<ProfileBloc>()
                              .add(AddShirt(addedShirt: widget.shirt));
                        },
                        icon: Icon(Icons.favorite),
                        iconSize: 30,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: [
                        Container(
                            transform: Matrix4.translationValues(-30, -140, 0),
                            width: 300,
                            height: 300,
                            child: Image(
                              fit: BoxFit.contain,
                              image: NetworkImage(widget.shirt.shirtImage!),
                            )),
                        Container(
                          transform: Matrix4.translationValues(-40, -140, 0),
                          child: Column(children: [
                            Text('\$' + widget.shirt.price.toString(),
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold)),
                            Text('Price',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold)),
                          ]),
                        )
                      ]),
                      Container(
                        transform: Matrix4.translationValues(10, -150, 0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.shirt.name!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 35)),
                              Text('REGION:' + widget.shirt.country!.name,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black54)),
                              SizedBox(height: 6),
                            ]),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Container(
                            transform: Matrix4.translationValues(0, -125, 0),
                            child: Column(children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(-128, 0, 0),
                                child: Text('Shirt Info:',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(height: 6),
                              Text(
                                widget.shirt.altrueInfo ??
                                    widget.shirt.altrueInfo!,
                                style: TextStyle(fontSize: 14),
                              ),
                            ])),
                      ),
                      // Text(
                      //   shirt.atrocity[0].title,
                      //   style: TextStyle(
                      //       fontSize: 21,
                      //       fontWeight: FontWeight.w600
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
                      SizedBox(height: 8),
                      SizedBox(height: 10),
                    ]),
                ShirtDetailTabs(shirt: widget.shirt)
              ]))),
    );
  }
}
