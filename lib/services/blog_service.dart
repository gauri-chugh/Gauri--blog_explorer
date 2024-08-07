import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../models/blog_model.dart';

class BlogService {
  final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  Future<List<Blog>> fetchBlogs() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Blog> blogs = (data['blogs'] as List).map((json) => Blog.fromJson(json)).toList();
        var box = await Hive.openBox('blogs');
        await box.put('blogs', blogs.map((blog) => blog.toJson()).toList());
        return blogs;
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      var box = await Hive.openBox('blogs');
      List? cachedBlogs = box.get('blogs');
      if (cachedBlogs != null) {
        return cachedBlogs.map((json) => Blog.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load blogs');
      }
    }
  }

  void addToFavorites(Blog blog) async {
    var box = await Hive.openBox('favorites');
    List favorites = box.get('favorites', defaultValue: []);
    favorites.add(blog.toJson());
    await box.put('favorites', favorites);
  }

  void removeFromFavorites(Blog blog) async {
    var box = await Hive.openBox('favorites');
    List favorites = box.get('favorites', defaultValue: []);
    favorites.removeWhere((item) => item['id'] == blog.id);
    await box.put('favorites', favorites);
  }
}
