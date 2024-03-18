import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc_bloc.dart';

import 'package:todo_bloc/screens/addpage.dart';

class Todolistpage extends StatefulWidget {
  const Todolistpage({super.key});

  @override
  State<Todolistpage> createState() => _TodolistpageState();
}

class _TodolistpageState extends State<Todolistpage> {
  @override
  void initState() {
    super.initState();
    context.read<TodoBlocBloc>().add(Intialtodofetching());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 164, 135),
        title: const Text(
          "Todo App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<TodoBlocBloc, TodoBlocState>(
        listener: (context, state) {
          if (state is TodoDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Deleted Succesfully",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Color.fromARGB(255, 8, 164, 135),
            ));
          }
          if (state is Addsuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Added Succesfully",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Color.fromARGB(255, 8, 164, 135),
            ));
          }
        },
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is Todofetched) {
            if (state.todos.isEmpty) {
              return const Center(
                child: Text("No Records Here"),
              );
            }
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final item = state.todos[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 8, 164, 135),
                        child: Text(
                          "${index + 1}",
                        )),
                    title: Text(item.title),
                    subtitle: Text(item.description),
                    trailing: PopupMenuButton(onSelected: (value) {
                      if (value == 'edit') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Addpage(
                                  todo: item,
                                )));
                      } else if (value == 'delete') {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: const Color.fromARGB(255, 8, 164, 135),
                            title: const Text(
                              "Are You Sure?",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            content: const Text(
                              'This action will delete the item permanently.',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<TodoBlocBloc>()
                                      .add(Deletetodopressed(id: item.id));
                                  Navigator.pop(context);
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          ),
                        );
                      }
                    }, itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text("Edit"),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text("delete"),
                        ),
                      ];
                    }),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigatetoaddtopage,
        label: const Text(
          "Add",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 8, 164, 135),
      ),
    );
  }

  Future<void> navigatetoaddtopage() async {
    final route = MaterialPageRoute(
      builder: (context) => const Addpage(),
    );
    await Navigator.push(context, route);
  }
}
