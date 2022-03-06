part of 'add_np_project_bloc.dart';

enum AddNpProjectStatus { Initial, Submitted, Failed }

class AddNpProjectState extends Equatable {
  final String title;
  final String information;
  final int fundraisingGoal;
  final int? atrocity;
  final int? category;
  final FormSubmissionStatus status;

  const AddNpProjectState(
      {this.information = '',
      this.atrocity,
      this.category,
      this.fundraisingGoal = 0,
      this.title = '',
      this.status = const InitialFormStatus()});

  AddNpProjectState copyWith({
    String? title,
    String? information,
    int? fundraisingGoal,
    int? atrocity,
    int? category,
    FormSubmissionStatus? status,
  }) {
    return AddNpProjectState(
        title: title ?? this.title,
        information: information ?? this.information,
        fundraisingGoal: fundraisingGoal ?? this.fundraisingGoal,
        category: category ?? this.category,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [information, title, fundraisingGoal];
}

class AddNpProjectInitial extends AddNpProjectState {}
