import 'package:flutter/material.dart';

import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/shirt_repository.dart';
import 'package:mobile/Presentation/Router/functionality_router.dart';

// ignore: must_be_immutable
class AtrocityShirtShowcase extends StatelessWidget {
  final Atrocity atrocity;
  final Profile profile;
  AtrocityShirtShowcase({required this.profile, required this.atrocity});

  @override
  Widget build(BuildContext context) {
    ShirtRepository shirtRepository = ShirtRepository();
    return GridView.builder(
      itemCount: atrocity.shirtList!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 12,
        crossAxisSpacing: 27,
        childAspectRatio: .70,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            if (atrocity.shirtList != null) {
              Shirt shirt = await shirtRepository
                  .fetchShirt(atrocity.shirtList![index].id!);

              Navigator.of(context).pushNamed('/ShirtDetail',
                  arguments:
                      ShirtDetailArguments(profile: profile, shirt: shirt));
            }
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Image(
                    image: NetworkImage(atrocity.shirtList![index].shirtImage!,
                        scale: .7)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  atrocity.shirtList![index].name!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text(atrocity.shirtList![index].category!.name)
            ],
          ),
        );
      },
    );
  }
}
