import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/donor_model.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/nonprofit_project_model.dart';

import 'package:mobile/Data_Layer/Models/user_model.dart';

class MealsListView extends StatefulWidget {
  const MealsListView({Key? key, this.profile, this.isProject, this.nonprofit})
      : super(key: key);

  final Profile? profile;
  final NonProfit? nonprofit;
  final bool? isProject;

  @override
  _MealsListViewState createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MealsListView>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isProject == true && widget.nonprofit!.projects!.length > 0 ||
            widget.isProject == false && widget.profile!.donor!.length > 0
        ? Container(
            height: 216,
            width: double.infinity,
            child: widget.isProject == false
                ? ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, right: 16, left: 16),
                    itemCount: widget.profile!.donor!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return MealsView(
                        isDonor: true,
                        donor: widget.profile!.donor![index],
                      );
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, right: 16, left: 16),
                    itemCount: widget.nonprofit!.projects!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return MealsView(
                        isDonor: false,
                        project: widget.nonprofit!.projects![index],
                      );
                    },
                  ),
          )
        : Container(
            height: 80,
            child: Center(
                child: widget.isProject == true
                    ? Text(widget.nonprofit!.name + ' has no current projects')
                    : Text(
                        widget.profile!.username! + '  has no recent donors',
                      )),
          );
  }
}

class MealsView extends StatelessWidget {
  const MealsView({Key? key, this.donor, this.isDonor, this.project})
      : super(key: key);
  final bool? isDonor;
  final Donor? donor;
  final NonProfitProject? project;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Stack(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 16),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.indigo.withOpacity(0.6),
                      offset: const Offset(1.1, 4.0),
                      blurRadius: 8.0),
                ],
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.white,
                    Colors.black,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(54.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 54, left: 16, right: 16, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    isDonor == false
                        ? Text(
                            project!.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                              color: Colors.amber,
                            ),
                          )
                        : Text(
                            donor != null ? donor!.firstName : '',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                              color: Colors.amber,
                            ),
                          ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              donor != null
                                  ? '\$' + donor!.amountDonated.toString()
                                  : 'Amount Raised: ' +
                                      project!.currentFunds.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 8,
                                letterSpacing: 0.2,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    isDonor == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                donor!.lastName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.2,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4, bottom: 3),
                                child: Text(
                                  'kcal',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    letterSpacing: 0.2,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(project!.fundraisingGoal.toString()),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        offset: Offset(8.0, 8.0),
                                        blurRadius: 8.0),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.indigo,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: Colors.white54.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Positioned(
          //   top: 0,
          //   left: 8,
          //   child: SizedBox(
          //       width: 80,
          //       height: 80,
          //       child: userdonation!.nonprofit != null
          //           ? Image.network(userdonation!.nonprofit!.logo)
          //           : Container(
          //               height: 20,
          //             )),
          // )
        ],
      ),
    );
  }
}
