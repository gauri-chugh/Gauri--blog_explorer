import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/blog_bloc.dart';
import '../models/blog_model.dart';
import 'blog_detail_screen.dart';

class BlogListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Explorer'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: BlogSearch(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BlogLoaded) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(blog.title),
                    leading: Image.network(blog.imageUrl),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogDetailScreen(blog: blog),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is BlogSearchResult) {
            return ListView.builder(
              itemCount: state.searchResults.length,
              itemBuilder: (context, index) {
                final blog = state.searchResults[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(blog.title),
                    leading: Image.network(blog.imageUrl),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogDetailScreen(blog: blog),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is BlogError) {
            return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
          }
          return Center(child: Text('No Blogs Available'));
        },
      ),
    );
  }
}

class BlogSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<BlogBloc>(context).add(SearchBlogs(query));
    return BlocBuilder<BlogBloc, BlogState>(
      builder: (context, state) {
        if (state is BlogLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is BlogSearchResult) {
          return ListView.builder(
            itemCount: state.searchResults.length,
            itemBuilder: (context, index) {
              final blog = state.searchResults[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(blog.title),
                  leading: Image.network(blog.imageUrl),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlogDetailScreen(blog: blog),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else if (state is BlogError) {
          return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
        }
        return Center(child: Text('No Results Found'));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
