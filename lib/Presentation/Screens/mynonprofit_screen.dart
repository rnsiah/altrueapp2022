import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/company_model.dart';
import 'package:mobile/Data_Layer/Models/company_nonprofit_matching_model.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/nonProfit_repository.dart';
import 'package:mobile/Presentation/Router/functionality_router.dart';
import 'package:mobile/Presentation/Screens/shirts_list.dart';
import 'package:mobile/Presentation/Widgets/company_dashboard/meals_list.dart';
import 'package:mobile/Presentation/Widgets/company_dashboard/mediteranein_diet.dart';
import 'package:mobile/Presentation/Widgets/company_dashboard/title_viiew.dart';

class MyNonProfitHome extends StatefulWidget {
  final Profile profile;
  final NonProfit nonprofit;
  final NonProfitRespository nonProfitRepository = NonProfitRespository();
  MyNonProfitHome({Key? key, required this.profile, required this.nonprofit})
      : super(key: key);

  @override
  _MyNonProfitHomeState createState() => _MyNonProfitHomeState();
}

class _MyNonProfitHomeState extends State<MyNonProfitHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage('images/Altrue Logo White.png'),
            ),
          ],
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TitleView(
              nonProfit: widget.profile.np,
              titleTxt: widget.profile.np!.name,
            ),
          ),
          MediterranesnDietView(
            isCompanyInfo: false,
            profile: widget.profile,
            isProfileInfo: false,
            nonprofit: widget.nonprofit,
          ),
          TitleView(
            titleTxt: 'Our Projects',
            subTxt: 'Add Project',
            ontap: () async {
              NonProfit np = await widget.nonProfitRepository
                  .fetchNonProfit(widget.profile.np!.id);

              Navigator.of(context).pushNamed('/createProject',
                  arguments: CreateProjectArguments(
                      nonprofit: np, profile: widget.profile));
            },
          ),
          MealsListView(
            profile: widget.profile,
            isProject: true,
            nonprofit: widget.nonprofit,
          ),
          TitleView(
            titleTxt: 'Companies Matching',
          ),
          widget.nonprofit.matchingPartnerships!.length > 0
              ? Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            widget.nonprofit.matchingPartnerships!.length,
                        itemBuilder: (context, index) {
                          return CompanyMatchCard(
                              company: widget
                                  .nonprofit.matchingPartnerships![index]);
                        }),
                  ),
                )
              : Container(
                  height: 80,
                  child: Center(
                    child:
                        Text('No Companies Supporting Your Orgnanization yet'),
                  ),
                )
        ],
      ),
    );
  }
}

class CompanyMatchCard extends StatelessWidget {
  const CompanyMatchCard({
    Key? key,
    required this.company,
  }) : super(key: key);

  final CompanyNonProfitMatchRelationship company;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(color: Colors.black54, offset: Offset(0, 4), blurRadius: 10)
      ]),
      child: GestureDetector(
        onTap: () => {},
        child: Container(
          height: 130,
          color: Colors.white,
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 180,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          opacity: .45,
                          image: NetworkImage(company.company!.logo))),
                ),
              ),
              Positioned(
                right: 8,
                top: 12,
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        'Amount Raised',
                        style: TextStyle(
                            backgroundColor: Colors.black.withOpacity(.70),
                            color: Colors.amber,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            '\$ ' +
                                company.totalRaised.toInt().toString() +
                                ' /  \$' +
                                company.fundingLimit.toInt().toString(),
                            softWrap: true,
                            style: TextStyle(
                                backgroundColor: Colors.black.withOpacity(.70),
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  left: 8,
                  bottom: 12,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          company.company!.name,
                          softWrap: true,
                          style: TextStyle(
                              backgroundColor: Colors.black.withOpacity(.70),
                              color: Colors.amber,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 6),
                        Container(
                            width: 150,
                            child: Text(
                                'Matching ' +
                                    company.matchLevel.toString() +
                                    '% of users donations',
                                style: TextStyle(
                                  backgroundColor:
                                      Colors.black.withOpacity(.70),
                                  color: Colors.white,
                                )))
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}
