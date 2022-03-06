part of 'add_np_project_bloc.dart';

abstract class AddNpProjectEvent extends Equatable {
  const AddNpProjectEvent();

  @override
  List<Object> get props => [];
}

class NpProjectTitleEdited extends AddNpProjectEvent {
  final String title;

  NpProjectTitleEdited({required this.title});
}

class NpProjectCategoryEdited extends AddNpProjectEvent {
  final int category;
  NpProjectCategoryEdited({required this.category});
}

class NpProjectAtrocityEdited extends AddNpProjectEvent {
  final int atrocity;
  NpProjectAtrocityEdited({required this.atrocity});
}

class NpProjectFundraisingGoalEdited extends AddNpProjectEvent {
  final int fundraisingGoal;
  NpProjectFundraisingGoalEdited({required this.fundraisingGoal});
}

class NpProjectInformationEdited extends AddNpProjectEvent {
  final String information;
  NpProjectInformationEdited({required this.information});
}

class NpProjectSubmitted extends AddNpProjectEvent {
  final NonProfitProjectCreation project;
  final NonProfit nonProfit;

  NpProjectSubmitted({required this.project, required this.nonProfit});
}
