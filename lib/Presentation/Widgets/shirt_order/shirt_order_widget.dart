import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/cart_bloc/bloc/cart_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:mobile/Data_Layer/Models/shirt_color_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_size_model.dart';
import 'package:photo_view/photo_view.dart';

class ShirtOrderForm extends StatefulWidget {
  final Shirt shirt;
  final CartBloc cartBloc;
  final ShirtOrderBlocBloc shirtOrderBlocBloc;
  const ShirtOrderForm({
    required this.cartBloc,
    required this.shirtOrderBlocBloc,
    required this.shirt,
    Key? key,
  }) : super(key: key);

  @override
  _ShirtOrderFormState createState() => _ShirtOrderFormState();
}

class _ShirtOrderFormState extends State<ShirtOrderForm> {
  @override
  void initState() {
    super.initState();
  }

  List<String> shirtSizes(Shirt shirt) {
    List<String> titles = [];
    for (var project in shirt.shirtSizes!) {
      titles.add(project.size);
    }
    titles.add('Choose');
    return titles;
  }

  List<String> shirtColors(Shirt shirt) {
    List<String> colorList = [];
    for (var variation in shirt.variations!) {
      colorList.add(variation.color.color);
    }
    List<String> colo = List.from(colorList.reversed);
    return colo;
  }

  String _selectedSize = 'Choose';
  String _selectedColor = 'Black';

  @override
  Widget build(BuildContext context) {
    final ShirtOrderBlocBloc shirtBlocOrder =
        context.read<ShirtOrderBlocBloc>();
    return Container(
      height: 700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.cartBloc.state.cart.length.toString()),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocConsumer<ShirtOrderBlocBloc, ShirtOrderBlocState>(
                listener: (context, state) {
                  if (state is OrderSubmitted) {
                    _showSnackbar(context, 'This has been added to your cart');
                  }
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return BlocBuilder<ShirtOrderBlocBloc, ShirtOrderBlocState>(
                    builder: (context, state) {
                      if (state.status == ShirtColorStatus.Changing) {
                        return Container(
                          transform: Matrix4.translationValues(-22, 0, 0),
                          width: 250,
                          height: 250,
                          child: PhotoView(
                            backgroundDecoration:
                                BoxDecoration(color: Colors.transparent),
                            imageProvider: NetworkImage(state.shirtImageUrl!),
                          ),
                        );
                      }
                      return Container(
                        transform: Matrix4.translationValues(-22, 0, 0),
                        width: 250,
                        height: 250,
                        child: PhotoView(
                          backgroundDecoration:
                              BoxDecoration(color: Colors.transparent),
                          imageProvider:
                              NetworkImage(widget.shirt.variations![0].image),
                        ),
                      );
                    },
                  );
                },
              ),
              Container(
                transform: Matrix4.translationValues(-15, 20, 0),
                child: Column(
                  children: [
                    // ColorAndSize(shirt: widget.shirt),
                    SizedBox(
                      height: 25,
                    ),

                    DropdownButton<String>(
                        value: _selectedColor,
                        items: shirtColors(widget.shirt).map((e) {
                          return DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(),
                              ));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedColor = value!;
                          });
                          context.read<ShirtOrderBlocBloc>().add(
                              ShirtColorChange(
                                  shirt: widget.shirt,
                                  shirtColor: ShirtColor(
                                      color: value.toString(),
                                      id: 20,
                                      hex: value.toString())));
                          print(value.toString());
                        }),

                    Text(
                      'Choose Quantity',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        width: 120,
                        height: 70,
                        child: Center(
                            child: Row(
                          children: [
                            IconButton(
                                onPressed: () => context
                                    .read<ShirtOrderBlocBloc>()
                                    .add(ShirtQuantityDecrement()),
                                icon: Icon(Icons.remove)),
                            BlocBuilder<ShirtOrderBlocBloc,
                                ShirtOrderBlocState>(builder: (context, state) {
                              if (state.quantity <= 1) {
                                return Text('1');
                              }
                              return Text(state.quantity.toString());
                            }),
                            IconButton(
                                onPressed: () => context
                                    .read<ShirtOrderBlocBloc>()
                                    .add(ShirtQuantityIncrement()),
                                icon: Icon(Icons.add))
                          ],
                        ))),

                    SizedBox(
                      height: 25,
                    ),
                    DropdownButton<String>(
                        value: _selectedSize,
                        itemHeight: 50,
                        items: shirtSizes(widget.shirt).map((e) {
                          return DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          );
                        }).toList(),
                        onChanged: (value) {
                          print('Shirt Size has been changed to $value');
                          setState(() {
                            _selectedSize = value!;
                            shirtBlocOrder.add(ShirtSizeChange(
                                shirtSize: ShirtSize(id: 2, size: value)));
                          });
                        })

                    // ShirtSizePicker(shirt: widget.shirt)
                  ],
                ),
              )
            ],
          ),
          // Center(
          //   child: ShirtCounter(
          //     shirt: widget.shirt,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: MaterialButton(
              color: Colors.amber,
              onPressed: () {
                context.read<ShirtOrderBlocBloc>().add(ShirtOrderSubmitted(
                      color: shirtBlocOrder.state.color!,
                      shirtId: widget.shirt.id!,
                      quantity: shirtBlocOrder.state.quantity,
                      shirt: widget.shirt,
                      size: shirtBlocOrder.state.size!,
                    ));
                widget.cartBloc.add(CartBeingLoaded());
                Navigator.pop(context);
              },
              child: Text(
                'Add To Cart',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),

          BlocBuilder<ShirtOrderBlocBloc, ShirtOrderBlocState>(
            builder: (context, state) {
              return Text(
                (widget.shirt.price! * state.quantity).toString(),
                style: TextStyle(fontSize: 25),
              );
            },
          )
        ],
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          message,
          style: TextStyle(color: Colors.amber),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
