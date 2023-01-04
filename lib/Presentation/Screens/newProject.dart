import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/addNP_project_bloc/bloc/add_np_project_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/form_submission_status.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/nonprofit_project_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Presentation/Widgets/company_dashboard/title_viiew.dart';

class NewProject extends StatefulWidget {
  final NonProfit nonprofit;
  final Profile profile;

  NewProject({Key? key, required this.nonprofit, required this.profile})
      : super(key: key);

  @override
  State<NewProject> createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
  final GlobalKey _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
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
              color: Colors.amber,
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => AddNpProjectBloc(),
          child: Column(children: [
            Container(
              child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: <Widget>[],
                  )),
            ),
            TitleView(
              titleTxt: 'Add A Project',
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white24,
                child: npProjectForm(widget.nonprofit, widget.profile),
              ),
            ),
          ]),
        ));
  }

  Widget npProjectForm(NonProfit nonProfit, Profile profile) {
    return Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              _title('Project Title', 1),
              _projectDescription('Project Description', 6),
              _fundraisingGoal('Fundraising Goal', 1),
              _registerNonProfit()
            ],
          ),
        ));
  }

  Widget _title(
    String label,
    int lines,
  ) {
    return BlocBuilder<AddNpProjectBloc, AddNpProjectState>(
      builder: (context, state) {
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
            onChanged: (value) => {
              context
                  .read<AddNpProjectBloc>()
                  .add(NpProjectTitleEdited(title: value))
            },
          ),
        );
      },
    );
  }

  Widget _projectDescription(
    String label,
    int lines,
  ) {
    return BlocBuilder<AddNpProjectBloc, AddNpProjectState>(
      builder: (context, state) {
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
            onChanged: (value) => {
              print(value),
              context
                  .read<AddNpProjectBloc>()
                  .add(NpProjectInformationEdited(information: value))
            },
          ),
        );
      },
    );
  }

  Widget _fundraisingGoal(
    String label,
    int lines,
  ) {
    return BlocBuilder<AddNpProjectBloc, AddNpProjectState>(
      builder: (context, state) {
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
              onChanged: (value) => {
                    context.read<AddNpProjectBloc>().add(
                        NpProjectFundraisingGoalEdited(
                            fundraisingGoal: int.parse(value)))
                  }),
        );
      },
    );
  }

  _registerNonProfit() {
    return BlocBuilder<AddNpProjectBloc, AddNpProjectState>(
      builder: (context, state) {
        if (state.status is FormSubmitting) {
          return CircularProgressIndicator();
        }
        return MaterialButton(
          color: Colors.amber,
          child: const Text(
            'Create Project',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            NonProfitProjectCreation project = NonProfitProjectCreation(
                title: state.title,
                atrocity: state.atrocity,
                category: state.category,
                information: state.information,
                fundraisingGoal: state.fundraisingGoal,
                nonprofit: widget.nonprofit.id);
            context.read<AddNpProjectBloc>().add(NpProjectSubmitted(
                project: project, nonProfit: widget.nonprofit));
          },
        );
      },
    );
  }
}
