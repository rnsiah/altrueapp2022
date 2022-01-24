import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/company_model.dart';

class CompanyAtrocityMatches extends StatelessWidget {
  final ForProfitCompany company;
  const CompanyAtrocityMatches({Key? key, required this.company})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (company.atrocityMatchRelationships == null) {
      Padding(
          padding: const EdgeInsets.only(left: 9),
          child: Container(
            width: MediaQuery.of(context).size.width * .93,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topRight: Radius.circular(68.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            child: Text(company.name +
                " isn't donating to any atrocities at the moment"),
          ));
    }
    return Padding(
        padding: const EdgeInsets.only(left: 9),
        child: Container(
          width: MediaQuery.of(context).size.width * .93,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(68.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: ListView.builder(
              itemCount: company.atrocityMatchRelationships!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      company.atrocityMatchRelationships![index].atrocity.title,
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: Column(
                      children: [
                        Text('Total Raised'),
                        Text("\$" +
                            company
                                .atrocityMatchRelationships![index].totalRaised
                                .toString())
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
