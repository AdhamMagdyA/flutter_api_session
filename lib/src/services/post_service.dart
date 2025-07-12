import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../models/post.dart';

class PostService {
  final http.Client client;

  PostService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Post>> getPosts() async {
    final response = await client.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }

  Future<void> deletePost(int id) async {
    final response = await client.delete(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/$id"),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      debugPrint("delete post successfully $id");
    } else {
      throw Exception("Failed to delete post");
    }
  }

  Future<void> updatePost(Post post) async {
    final response = await client.put(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/${post.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(post.toJson()),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      debugPrint("update post successfully $post");
    } else {
      throw Exception("Failed to update post");
    }
  }
}