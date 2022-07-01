import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:mobile/Data_Layer/Models/order_item_model.dart';
import 'package:mobile/Presentation/Widgets/edit_order_diallogue.dart';
import 'package:mobile/Presentation/Widgets/shirt_order/shirt_order_widget.dart';

class CartBottomScreen extends StatefulWidget {
  final List<OrderItem> cartList;
  final ScrollController controller;
  const CartBottomScreen(
      {Key? key, required this.cartList, required this.controller})
      : super(key: key);

  @override
  _CartBottomScreenState createState() => _CartBottomScreenState();
}

class _CartBottomScreenState extends State<CartBottomScreen> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 20, top: 15),
            child: Text(
              'Orders In Cart',
              style: TextStyle(
                  color: Colors.amber,
                  fontSize: 24,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 300,
            child: ListView.builder(
                controller: widget.controller,
                scrollDirection: Axis.vertical,
                itemExtent: 90,
                itemCount: widget.cartList.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 7.0, right: 8),
                      child: Card(
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Colors.black)),
                        child: ListTile(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value:
                                            context.read<ShirtOrderBlocBloc>(),
                                      ),
                                      BlocProvider.value(
                                        value: context.read<CartBloc>(),
                                      ),
                                    ],
                                    child: EditOrderDialogue(
                                        cartBloc: context.read<CartBloc>(),
                                        shirt: widget.cartList[index].shirt,
                                        shirtOrderBlocBloc:
                                            context.read<ShirtOrderBlocBloc>()),
                                  );
                                });
                          },
                          leading: Image(
                            image: NetworkImage(
                                widget.cartList[index].shirt.shirtImage!),
                          ),
                          title: Text(widget.cartList[index].shirt.name!),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('dbID: ' +
                                  widget.cartList[index].id.toString()),
                              Text('Qty: ' +
                                  widget.cartList[index].quantity.toString()),
                              Text('Size: ' + widget.cartList[index].size.size)
                            ],
                          ),
                        ),
                      ),
                    )),
          ),
          Container(
            height: 100,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
