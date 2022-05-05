import 'package:api_series/login/login_page.dart';
import 'package:flutter/material.dart';

class HomeTest extends StatefulWidget {
  const HomeTest({ Key? key }) : super(key: key);

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Coé'),
              const SizedBox(height: 50,),
              OutlinedButton.icon(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                },
                icon: const Icon(Icons.exit_to_app, size: 18,),
                label: const Text('Logout')
                )
            ],
          ),
        ),
      ),
    );
  }
}