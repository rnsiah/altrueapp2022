part of 'create_project_bloc.dart';

abstract class CreateProjectEvent extends Equatable {
  const CreateProjectEvent();

  @override
  List<Object> get props => [];
}

class SubmitProject extends CreateProjectEvent {
  final NonProfitProject project;
  SubmitProject({required this.project});
}

class ChangeTitle extends CreateProjectEvent {
  final String title;
  ChangeTitle({required this.title});
}

class ChangeDescription extends CreateProjectEvent {
  final String desciption;
  ChangeDescription({required this.desciption});
}

class ChangeGoal extends CreateProjectEvent {
  final int goal;
  ChangeGoal({required this.goal});
}
