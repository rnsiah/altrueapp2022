import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/company_coupon_model.dart';

class CompanyCouponCard extends StatelessWidget {
  final CompanyCoupon coupon;
  const CompanyCouponCard({Key? key, required this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image(
          image: NetworkImage(coupon.couponImage!),
        ),
        title: Text(
          coupon.name,
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          coupon.description!,
          style: TextStyle(fontSize: 8),
        ),
        trailing: Text(coupon.couponCode!, style: TextStyle(fontSize: 8)),
      ),
    );
  }
}
