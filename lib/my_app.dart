import 'package:api_series/config/theme.dart';
import 'package:api_series/login/google_sign_in.dart';
import 'package:api_series/login/login_google.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login/login_page.dart';
import 'pages/home_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => GoogleSignInProvider(),
    child: MaterialApp(
          
          title: 'Show Analytic',
          theme: theme(),
          debugShowCheckedModeBanner: false,
  
          home: const LoginPage(),
  
        
  
        ),
  );

  }

