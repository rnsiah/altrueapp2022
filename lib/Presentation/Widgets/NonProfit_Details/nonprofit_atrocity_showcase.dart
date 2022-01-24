import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Repoositories/atrocity_repositories.dart';

class NonprofitAtrocityShowcase extends StatelessWidget {
  final NonProfit nonprofit;

  const NonprofitAtrocityShowcase({Key? key, required this.nonprofit})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    AtrocityRepository atrocityRepository = AtrocityRepository();
    return ListView.builder(
        itemCount: nonprofit.atrocity!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              Atrocity atrocity = await atrocityRepository
                  .getAtrocity(nonprofit.atrocity![index].id!);
              Navigator.of(context)
                  .pushNamed('/atrocityView', arguments: atrocity);
            },
            child: Column(
              children: [
                Container(
                  width: 300,
                  height: 135,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image(
                    image: NetworkImage(nonprofit.atrocity![index].imageUrl!,
                        scale: .7),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(nonprofit.atrocity![index].title),
                )
              ],
            ),
          );
        });
  }
}
