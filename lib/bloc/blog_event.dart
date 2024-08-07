part of 'blog_bloc.dart';

abstract class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

class FetchBlogs extends BlogEvent {}

class SearchBlogs extends BlogEvent {
  final String query;

  const SearchBlogs(this.query);

  @override
  List<Object> get props => [query];
}

class AddToFavorites extends BlogEvent {
  final Blog blog;

  const AddToFavorites(this.blog);

  @override
  List<Object> get props => [blog];
}

class RemoveFromFavorites extends BlogEvent {
  final Blog blog;

  const RemoveFromFavorites(this.blog);

  @override
  List<Object> get props => [blog];
}
