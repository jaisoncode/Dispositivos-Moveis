import 'package:dio/dio.dart';
import 'package:todo_app/todo_model.dart';

class TodoRepository {
  final dio = Dio();
  final url = 'https://jsonplaceholder.typicode.com/todos';
 
  Future<List<TodoModel>> fetchAll() async {
    final response = await dio.get(url);
    final list = response.data as List;
    var todos = list.map((json) => TodoModel.fromJson(json)).toList(); 
    return todos;   
  }
}