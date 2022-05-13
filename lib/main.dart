import 'package:flutter/material.dart';
import 'package:hormoniousflo/data/controller/phase_controller.dart';
import 'package:hormoniousflo/data/services/notification_service.dart';
import 'package:hormoniousflo/ui/shared/const_colors.dart';
import 'package:hormoniousflo/ui/views/main_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PhaseController(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: kAppColor,
          fontFamily: 'Montserrat',
        ),
        home: const MainView(),
      ),
    );
  }
}
