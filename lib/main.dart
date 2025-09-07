import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewModel/timer_viewmodel.dart';
import 'view/timer_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cronômetro',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const TimerPage(),
      ),
    );
  }
}
