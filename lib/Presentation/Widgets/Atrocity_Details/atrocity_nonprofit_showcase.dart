import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Repoositories/nonProfit_repository.dart';

class AtrocityNonProfitShowcase extends StatelessWidget {
  final Atrocity atrocity;

  const AtrocityNonProfitShowcase({Key? key, required this.atrocity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NonProfitRespository nonProfitRespository = NonProfitRespository();
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Organizations Supporting This Atrocity',
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
      Expanded(
        child: GridView.builder(
          itemCount: atrocity.nonprofitList!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 12,
              crossAxisSpacing: 27,
              childAspectRatio: .70,
              crossAxisCount: 3),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () async {
              NonProfit nonprofit = await nonProfitRespository
                  .fetchNonProfit(atrocity.nonprofitList![index].id);
              Navigator.of(context)
                  .pushNamed('/nonProfitView', arguments: nonprofit);
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: Image(
                    image: NetworkImage(atrocity.nonprofitList![index].logo,
                        scale: 0.7),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Center(
                    child: Text(
                      atrocity.nonprofitList![index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
