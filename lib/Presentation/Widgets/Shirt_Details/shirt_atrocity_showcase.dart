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
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: .80, crossAxisSpacing: 12, crossAxisCount: 2),
      itemCount: shirt.atrocity!.length,
      itemBuilder: (context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () async {
              Atrocity atrocity = await atrocityRepository
                  .getAtrocity(shirt.atrocity![index].id!);
              Navigator.of(context).pushNamed('/atrocityView',
                  arguments: AtrocityDetailArguments(
                      atrocity: atrocity, profile: profile));
            },
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(shirt.atrocity![index].imageUrl!))),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Positioned(
                        child: Text(
                      shirt.atrocity![index].title,
                      style: TextStyle(
                          backgroundColor: Colors.black38,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
