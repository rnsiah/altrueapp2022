import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:mobile/Data_Layer/Blocs/shirt_bloc/bloc/shirt_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/shirt_order_bloc/bloc/shirt_order_bloc_bloc.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_size_model.dart';
import 'package:mobile/Presentation/Widgets/shirt_order/shirt_couter.dart';
import 'package:mobile/Presentation/Widgets/shirt_order/shirt_size_picker.dart';
import 'package:photo_view/photo_view.dart';

import 'color_picker.dart';

class ShirtOrderForm extends StatefulWidget {
  final Shirt shirt;
  const ShirtOrderForm({
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

  String _selectedSize = 'Choose';

  @override
  Widget build(BuildContext context) {
    final shirtBlocOrder = context.read<ShirtOrderBlocBloc>();
    return BlocProvider.value(
      value: shirtBlocOrder,
      child: Container(
        color: Colors.transparent,
        height: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  transform: Matrix4.translationValues(-22, 0, 0),
                  width: 250,
                  height: 250,
                  child: BlocBuilder<ShirtOrderBlocBloc, ShirtOrderBlocState>(
                    builder: (context, state) {
                      return PhotoView(
                        backgroundDecoration:
                            BoxDecoration(color: Colors.transparent),
                        imageProvider: NetworkImage(widget.shirt.shirtImage!),
                      );
                    },
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(-15, 20, 0),
                  child: Column(
                    children: [
                      ColorAndSize(shirt: widget.shirt),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Choose Quantity',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      BlocBuilder<ShirtOrderBlocBloc, ShirtOrderBlocState>(
                        builder: (context, state) {
                          if (state is OrderInProgress) {
                            return Container(
                                width: 120,
                                height: 70,
                                child: Center(
                                    child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          shirtBlocOrder.add(
                                              ShirtQuantityChange(
                                                  quantity:
                                                      state.quantity! + 1));
                                        },
                                        icon: Icon(Icons.add)),
                                    Text(state.quantity.toString()),
                                    IconButton(
                                        onPressed: () {
                                          shirtBlocOrder.add(
                                              ShirtQuantityChange(
                                                  quantity:
                                                      state.quantity! - 1));
                                        },
                                        icon: Icon(Icons.remove))
                                  ],
                                )));
                          }
                          return CircularProgressIndicator();
                        },
                      ),
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
                              context.read<ShirtOrderBlocBloc>().add(
                                  ShirtSizeChange(
                                      shirtSize:
                                          ShirtSize(id: 2, size: value)));
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
                onPressed: () {},
                child: Text(
                  'Add To Cart',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
