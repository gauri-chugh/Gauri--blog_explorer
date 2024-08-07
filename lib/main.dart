import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bloc/blog_bloc.dart';
import 'services/blog_service.dart';
import 'screens/blog_list_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('blogs');
  await Hive.openBox('favorites');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => BlogBloc(BlogService())..add(FetchBlogs()),
        child: BlogListScreen(),
      ),
    );
  }
}
