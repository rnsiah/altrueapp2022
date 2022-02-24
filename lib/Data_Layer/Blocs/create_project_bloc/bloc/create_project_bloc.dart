import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/nonprofit_project_model.dart';
import 'package:mobile/Data_Layer/Repoositories/nonprofit_proj_repository.dart';

part 'create_project_event.dart';
part 'create_project_state.dart';

class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
  final NonProfitProjectRepoisitory nonProfitProjectRepoisitory =
      NonProfitProjectRepoisitory();
  CreateProjectBloc() : super(CreateProjectInitial()) {
    on<ChangeDescription>(_onchangeDesciption);
    on<ChangeTitle>(_onTitleChange);
    on<ChangeGoal>(_onGoalChange);
    on<SubmitProject>(_projectSubmitted);
  }
  void _onchangeDesciption(
      ChangeDescription event, Emitter<CreateProjectState> state) async {
    final state = this.state;
    final String descip = event.desciption;
    CreateProjectState newState = state.copyWith(title: event.desciption);
    emit(newState);
  }

  void _onTitleChange(
      ChangeTitle event, Emitter<CreateProjectState> state) async {
    final state = this.state;
    emit(state.copyWith(title: event.title));
  }

  void _onGoalChange(
      ChangeGoal event, Emitter<CreateProjectState> state) async {
    final state = this.state;
    emit(state.copyWith(goal: event.goal));
  }

  void _projectSubmitted(
      SubmitProject event, Emitter<CreateProjectState> state) async {
    final state = this.state;
    try {
      NonProfitProject project = NonProfitProject(0, event.project.information,
          event.project.fundraisingGoal, event.project.title);
      var love = nonProfitProjectRepoisitory.submit(project);
    } catch (e) {
      print(e.toString());
    }
  }
}
