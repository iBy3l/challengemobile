import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/content_bloc.dart';
import 'pages/home_page.dart';
import 'services/content_service_impl.dart';

typedef OnError = void Function(Exception exception);

void main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContentBloc>(
          create: (context) => ContentBloc(
            ContentServiceImpl(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Challenge Mobile',
        theme: ThemeData(
          backgroundColor: const Color(0xff0F0F29),
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
