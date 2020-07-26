import 'package:calenderly/providers/api_interface.dart';
import 'package:calenderly/providers/app_state.dart';
import 'package:calenderly/routes/routes.dart';
import 'package:calenderly/screens/initial_screen/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppState()),
        ChangeNotifierProvider.value(value: ApiInterface()),
      ],
      child: MaterialApp(
        home: InitialScreen(),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
