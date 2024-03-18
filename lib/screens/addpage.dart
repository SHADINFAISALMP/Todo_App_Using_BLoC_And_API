import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc_bloc.dart';
import 'package:todo_bloc/model/model.dart';

class Addpage extends StatefulWidget {
  final TodoModel? todo;
  const Addpage({super.key, this.todo});

  @override
  State<Addpage> createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descrptioncontroller = TextEditingController();
  late bool isedit;

  @override
  void initState() {
    super.initState();
    isedit = widget.todo == null ? false : true;
    descrptioncontroller.text =
        widget.todo != null ? widget.todo!.description : "";
    titlecontroller.text = widget.todo != null ? widget.todo!.title : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 164, 135),
        title: Text(
          !isedit ? 'add todo ' : 'edit todo',
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocListener<TodoBlocBloc, TodoBlocState>(
        listener: (context, state) {
          if (state is Todoadded) {
            Navigator.pop(context);
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: titlecontroller,
              decoration: const InputDecoration(hintText: "Title"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: descrptioncontroller,
              decoration: const InputDecoration(hintText: "Description"),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 8,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: !isedit
                    ? () => context.read<TodoBlocBloc>().add(Addtodopressed(
                        title: titlecontroller.text,
                        description: descrptioncontroller.text))
                    : () => context.read<TodoBlocBloc>().add(Edittodopressed(
                        id: widget.todo!.id,
                        title: titlecontroller.text,
                        description: descrptioncontroller.text)),
                child: Text(!isedit ? 'submit' : 'update'))
          ],
        ),
      ),
    );
  }
}
