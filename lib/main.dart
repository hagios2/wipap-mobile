import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/map_screen.dart';
import 'screens/main_dashboard.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wipap/components/app_state.dart';


void main(){
  
    WidgetsFlutterBinding.ensureInitialized();
    
    runApp(
      MultiProvider(providers: [ChangeNotifierProvider.value(value: AppState(),)],
        child: MyApp()),
      );
  }



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    @override
  void initState() {
    super.initState();

    _getLocalStorage();
  }

  void _getLocalStorage() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();

       setState(() {
          token = localStorage.getString('token');
      });

 

  }

  String token;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: /* isSignedIn ? MenuDashboardPage.id : */ MapsPage.id,//WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          MapsPage.id: (context) => MapsPage(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
         /*  MenuDashboardPage.id: (context) => MenuDashboardPage(), */
//          ChatScreen.id: (context) => ChatScreen(),
        });
  }
}