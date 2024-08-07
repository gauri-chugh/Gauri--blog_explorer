import 'package:flutter/material.dart';
import '../models/blog_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/blog_bloc.dart';

class BlogDetailScreen extends StatelessWidget {
  final Blog blog;

  const BlogDetailScreen({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
        actions: [
          BlocBuilder<BlogBloc, BlogState>(
            builder: (context, state) {
              bool isFavorite = false;
              if (state is BlogLoaded || state is BlogSearchResult) {
                final blogs = (state is BlogLoaded) ? state.blogs : (state as BlogSearchResult).searchResults;
                isFavorite = blogs.contains(blog);
              }
              return IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  if (isFavorite) {
                    BlocProvider.of<BlogBloc>(context).add(RemoveFromFavorites(blog));
                  } else {
                    BlocProvider.of<BlogBloc>(context).add(AddToFavorites(blog));
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(blog.imageUrl),
            SizedBox(height: 16),
            Text(blog.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Expanded(child: SingleChildScrollView(child: Text(blog.content))),
          ],
        ),
      ),
    );
  }
}
