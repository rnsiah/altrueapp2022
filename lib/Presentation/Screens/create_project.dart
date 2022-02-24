import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Presentation/Widgets/company_dashboard/title_viiew.dart';

class CreateProject extends StatefulWidget {
  final NonProfit nonProfit;
  final _formKey = GlobalKey<FormState>();

  CreateProject({required this.nonProfit});

  @override
  _CreateProjectState createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Image(
            image: AssetImage('images/Altrue Logo White.png'),
          ),
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.only(right: 7),
              onPressed: () => print('Search'),
              icon: Icon(Icons.search),
              iconSize: 30,
              color: Colors.black,
            ),
          ],
        ),
        body: ListView(children: [
          Container(
            child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'titleTxt',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            letterSpacing: 0.5,
                            color: Colors.amber),
                      ),
                    ),
                  ],
                )),
          ),
          TitleView(
            titleTxt: 'Add A Project',
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white24,
              child: npProjectForm(),
            ),
          ),
        ]));
  }

  Widget npProjectForm() {
    return Form(
        key: widget._formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              _title('Project Title', 1),
              _title('Project Decription', 4),
              _title('Fundraising Goal', 1),
              _title('label', 1),
              Container(
                child: Text('love'),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(90),
                ),
              )
            ],
          ),
        ));
  }

  Widget _title(String label, int lines) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          maxLines: lines,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              focusColor: Colors.amberAccent,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(90.0),
              ),
              filled: true,
              fillColor: Colors.black45.withOpacity(.3),
              labelText: label,
              labelStyle: TextStyle(fontSize: 15, color: Colors.white)),
          onChanged: (value) {},
          validator: (value) {}),
    );
  }

  Widget _information() {
    return TextFormField(
      maxLines: 6,
      decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 15)),
      minLines: 2,
      onChanged: (value) {},
    );
  }

  Widget _dropDown() {
    return Container(
      height: 200,
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 30.0, right: 30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(
                3.0,
                3.0,
              ), //Offset
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
        ), //BoxDecoration

        /** CheckboxListTile Widget **/
        child: CheckboxListTile(
            title: const Text('GeeksforGeeks'),
            subtitle: const Text(
              'A computer science portal for geeks. Here you will find articles ',
              style: TextStyle(fontSize: 9),
            ),
            secondary: CircleAvatar(
              backgroundImage: NetworkImage(''),
              radius: 20,
            ),
            autofocus: false,
            isThreeLine: true,
            activeColor: Colors.green,
            checkColor: Colors.white,
            selected: false,
            value: true,
            onChanged: (value) {}),
      ),
    );
  }
}
