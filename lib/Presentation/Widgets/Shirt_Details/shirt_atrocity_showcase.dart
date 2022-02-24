import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/atrocity_repositories.dart';
import 'package:mobile/Presentation/Router/functionality_router.dart';

class ShirtAtrocityShowcase extends StatelessWidget {
  final Shirt shirt;
  final Profile profile;
  const ShirtAtrocityShowcase(
      {Key? key, required this.shirt, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AtrocityRepository atrocityRepository = AtrocityRepository();
    return ListView.builder(
      itemCount: shirt.atrocity!.length,
      itemBuilder: (context, int index) {
        return GestureDetector(
          onTap: () async {
            Atrocity atrocity = await atrocityRepository
                .getAtrocity(shirt.atrocity![index].id!);
            Navigator.of(context).pushNamed('/atrocityView',
                arguments: AtrocityDetailArguments(
                    atrocity: atrocity, profile: profile));
          },
          child: Stack(
            children: [Positioned(child: Text(shirt.atrocity![index].title))],
          ),
        );
      },
    );
  }
}
