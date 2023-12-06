import 'package:flutter/material.dart';
import 'package:todo_app/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final controller = HomeController();

  bool isChecked = false;

  _success() {
    return ListView.builder(
        itemCount: controller.todos.length,
        itemBuilder: (context, index) {
          var todo = controller.todos[index];
          
          return ListTile(
            leading: Checkbox(value: todo.completed!, onChanged: (bool? value) { 
              setState(() {
                todo.completed = value!;
              });
             },),
            title: Text(todo.title ?? ''),
          );
        },
      );
  }

  _error() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          controller.start();
        },
        child: const Text('Tentar Novamente'),
      ),
    );
  }

  _loading() {
    return const Center(
      child: CircularProgressIndicator()
    );
  }

  _start() {
    return Container();
  }

  manageState(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.success:
        return _success();
      case HomeState.error:
        return _error();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    super.initState();
    controller.start();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Todo List'),
        actions: [
          IconButton(onPressed: () => controller.start(), icon: const Icon(Icons.refresh_outlined))
        ],
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return manageState(controller.state.value);
        },
      ),
    );
  }
}