import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../services/blog_service.dart';
import '../models/blog_model.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogService blogService;

  BlogBloc(this.blogService) : super(BlogInitial()) {
    on<FetchBlogs>(_onFetchBlogs);
    on<SearchBlogs>(_onSearchBlogs);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
  }

  void _onFetchBlogs(FetchBlogs event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    try {
      final blogs = await blogService.fetchBlogs();
      emit(BlogLoaded(blogs));
    } catch (e) {
      emit(BlogError(e.toString()));
    }
  }

  void _onSearchBlogs(SearchBlogs event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    try {
      final blogs = await blogService.fetchBlogs();
      final searchResults = blogs.where((blog) {
        return blog.title.toLowerCase().contains(event.query.toLowerCase());
      }).toList();
      emit(BlogSearchResult(searchResults));
    } catch (e) {
      emit(BlogError(e.toString()));
    }
  }

  void _onAddToFavorites(AddToFavorites event, Emitter<BlogState> emit) async {
    try {
      blogService.addToFavorites(event.blog);
      emit(BlogFavoriteAdded(event.blog));
    } catch (e) {
      emit(BlogError(e.toString()));
    }
  }

  void _onRemoveFromFavorites(RemoveFromFavorites event, Emitter<BlogState> emit) async {
    try {
      blogService.removeFromFavorites(event.blog);
      emit(BlogFavoriteRemoved(event.blog));
    } catch (e) {
      emit(BlogError(e.toString()));
    }
  }
}
