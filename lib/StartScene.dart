import 'package:flutter/material.dart';


class StartScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void loginCheck(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()),);
    }

    void onStartBtnPressed(){
      loginCheck();
    }

    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            child: const Text('Start'), 
            onPressed: (){
              onStartBtnPressed();
            }
          ),
        ],
      )
    );
  }
}

class LoginPage extends StatelessWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      

    );
  }


}