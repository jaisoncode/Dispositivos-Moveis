import 'package:flutter/material.dart';
import 'package:todo_app/post_model.dart';
import 'package:todo_app/post_repository.dart';
import 'package:todo_app/todo_model.dart';
import 'package:todo_app/todo_repository.dart';

enum HomeState { start, loading, success, error }

class HomeController {
  List<TodoModel> todos = [];
  List<PostModel> posts = [];
  final repository = TodoRepository();
  final postRepository = PostRepository();
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future<void> start() async {
    state.value = HomeState.loading;
    try {
      todos = await repository.fetchAll();
      posts = await postRepository.fetchAllPosts();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }

  Future<void> createPost(PostModel post) async {
    try {
      final newPost = await postRepository.createPost(post);
      posts.add(newPost);
    } catch (e) {
      print('Erro ao criar post: $e');
    }
  }

  Future<void> updatePost(PostModel post) async {
    try {
      await postRepository.updatePost(post);
      final index = posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        posts[index] = post;
      }
    } catch (e) {
      print('Erro ao atualizar post: $e');
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      await postRepository.deletePost(postId);
      posts.removeWhere((post) => post.id == postId);
    } catch (e) {
      print('Erro ao excluir post: $e');
    }
  }
}
