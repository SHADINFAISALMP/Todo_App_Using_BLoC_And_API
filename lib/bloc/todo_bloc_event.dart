part of 'todo_bloc_bloc.dart';

@immutable
sealed class TodoBlocEvent {}

final class Addtodopressed extends TodoBlocEvent {
  final String title;
  final String description;

  Addtodopressed({required this.title, required this.description});
}

final class Edittodopressed extends TodoBlocEvent {
  final String id;
  final String title;
  final String description;

  Edittodopressed(
      {required this.id, required this.title, required this.description});
}

final class Deletetodopressed extends TodoBlocEvent {
  final String id;

  Deletetodopressed({required this.id});
}

final class Intialtodofetching extends TodoBlocEvent{}