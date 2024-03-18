part of 'todo_bloc_bloc.dart';

@immutable
sealed class TodoBlocState {}

final class TodoBlocInitial extends TodoBlocState {}

final class TodoLoading extends TodoBlocState {}

final class Todofetched extends TodoBlocState {
  final List<TodoModel> todos;
  Todofetched({required this.todos});
}

final class Todoadded extends TodoBlocState {}

final class TodoAddingError extends TodoBlocState {
  final String error;

  TodoAddingError(this.error);
}

final class TodoDeleted extends TodoBlocState{}

final class DeletionError extends TodoBlocState {
  final String error;

  DeletionError(this.error);

}

final class NotesUpdationError extends TodoBlocState{
    final String error;

  NotesUpdationError(this.error);
}
final class Addsuccess extends TodoBlocState{

}