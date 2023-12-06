import 'package:dio/dio.dart';
import 'package:todo_app/post_model.dart';

class PostRepository {
  final Dio dio = Dio();
  final url = 'https://jsonplaceholder.typicode.com';

  Future<List<PostModel>> fetchAllPosts() async {
    final response = await dio.get('$url/posts');
    final list = response.data as List;
    var posts = list.map((json) => PostModel.fromJson(json)).toList();
    return posts;
  }

  Future<PostModel> createPost(PostModel post) async {
    final response = await dio.post('$url/posts', data: post.toJson());
    return PostModel.fromJson(response.data);
  }

  Future<PostModel> updatePost(PostModel post) async {
    final response = await dio.put('$url/posts/${post.id}', data: post.toJson());
    return PostModel.fromJson(response.data);
  }

  Future<void> deletePost(int postId) async {
    await dio.delete('$url/posts/$postId');
  }
}
