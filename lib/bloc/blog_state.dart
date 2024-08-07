part of 'blog_bloc.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<Blog> blogs;

  const BlogLoaded(this.blogs);

  @override
  List<Object> get props => [blogs];
}

class BlogSearchResult extends BlogState {
  final List<Blog> searchResults;

  const BlogSearchResult(this.searchResults);

  @override
  List<Object> get props => [searchResults];
}

class BlogFavoriteAdded extends BlogState {
  final Blog blog;

  const BlogFavoriteAdded(this.blog);

  @override
  List<Object> get props => [blog];
}

class BlogFavoriteRemoved extends BlogState {
  final Blog blog;

  const BlogFavoriteRemoved(this.blog);

  @override
  List<Object> get props => [blog];
}

class BlogError extends BlogState {
  final String message;

  const BlogError(this.message);

  @override
  List<Object> get props => [message];
}
