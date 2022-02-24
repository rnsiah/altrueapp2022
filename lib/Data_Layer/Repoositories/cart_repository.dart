import 'package:mobile/Data_Layer/Models/order_item_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_color_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_size_model.dart';
import 'package:mobile/Data_Layer/Repoositories/shirt_repository.dart';

class CartRepository {
  ShirtRepository shirtRepository = ShirtRepository();

  Future<List<OrderItem>> ordersIntoCart(
      List<DatabaseOrderItem> theCart) async {
    List<OrderItem> cart = [];

    for (var item in theCart) {
      Shirt love = await shirtRepository.fetchShirt(item.shirtId);
      OrderItem orderItem = OrderItem(
          id: item.id,
          quantity: item.quantity,
          shirt: love,
          color: ShirtColor(color: item.color, id: 0, hex: ''),
          size: ShirtSize(size: item.size, id: 0));
      cart.add(orderItem);
    }
    return cart;
  }
}