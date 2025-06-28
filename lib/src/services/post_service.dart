import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post.dart';


class PostService {

  final http.Client client;

  PostService({http.Client? client})
      : client = client ?? http.Client();

  Future<List<Post>> getPosts() async {
    final response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if(response.statusCode == 200){
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    }else{
      throw Exception("Failed to load posts");
    }
  }
}

// try
// catch