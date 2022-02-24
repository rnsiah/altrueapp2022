part of 'create_project_bloc.dart';

class CreateProjectState extends Equatable {
  final String title;
  final String description;
  final int goal;
  CreateProjectState({this.title = '', this.description = '', this.goal = 0});
  CreateProjectState copyWith({
    String? title,
    String? description,
    int? goal,
  }) {
    return CreateProjectState(
        title: title ?? this.title,
        description: description ?? this.description,
        goal: goal ?? this.goal);
  }

  @override
  List<Object> get props => [title, description, goal];
}

class CreateProjectInitial extends CreateProjectState {}
