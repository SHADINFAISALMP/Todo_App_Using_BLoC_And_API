import 'package:bloc/bloc.dart';
import 'package:todo_bloc/data/todo_repo.dart';
import 'package:todo_bloc/model/model.dart';
import 'package:flutter/foundation.dart';
part 'todo_bloc_event.dart';
part 'todo_bloc_state.dart';

class TodoBlocBloc extends Bloc<TodoBlocEvent, TodoBlocState> {
  TodoBlocBloc() : super(TodoBlocInitial()) {
    on<Intialtodofetching>(_initialTodofetching);
    on<Addtodopressed>(_addTodoPressed);
    on<Deletetodopressed>(_deleteNotePressed);
    on<Edittodopressed>(_editNotePressed);
  }

  //fetching db data

  _initialTodofetching(
      Intialtodofetching event, Emitter<TodoBlocState> emit) async {
    emit(TodoLoading());
    try {
      final items = await Repository().getdata();
      final List<TodoModel> todos = [];
      for (int i = 0; i < items.length; i++) {
        todos.add(TodoModel(
            title: items[i]['title'],
            description: items[i]['description'],
            id: items[i]["_id"]));
      }
      emit(Todofetched(todos: todos));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  //on add button pressed

  _addTodoPressed(Addtodopressed event, Emitter<TodoBlocState> emit) async {
    emit(Todoadded());
    emit(TodoLoading());
    try {
      final result =
          await Repository().submitdata(event.title, event.description);
      if (result == "success") {
        emit(Addsuccess());
        add(Intialtodofetching());
      }
    } catch (e) {
      emit(TodoAddingError(e.toString()));
      add(Intialtodofetching());
    }
  }

  //delete button press

  _deleteNotePressed(
      Deletetodopressed event, Emitter<TodoBlocState> emit) async {
    emit(TodoLoading());
    try {
      final result = await Repository().deletedata(event.id);
      if (result == "success") {
        emit(TodoDeleted());
        add(Intialtodofetching());
      }
    } catch (e) {
      emit(DeletionError(e.toString()));
      add(Intialtodofetching());
    }
  }

  //edit button pressed

  _editNotePressed(Edittodopressed event, Emitter<TodoBlocState> emit) async {
    emit(Todoadded());
    emit(TodoLoading());
    try {
      final result = await Repository()
          .updatedata(event.id, event.title, event.description);
      if (result == "success") {
        add(Intialtodofetching());
      } else {
        emit(NotesUpdationError("error in updating"));
        add(Intialtodofetching());
      }
    } catch (e) {
      emit(NotesUpdationError(e.toString()));
    }
  }

  @override
  void onTransition(Transition<TodoBlocEvent, TodoBlocState> transition) {
    if (kDebugMode) {
      print(transition);
    }
    super.onTransition(transition);
  }
}
