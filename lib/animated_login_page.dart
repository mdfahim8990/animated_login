import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class AnimatedLoginPage extends StatefulWidget {
  const AnimatedLoginPage({Key? key}) : super(key: key);

  @override
  State<AnimatedLoginPage> createState() => _AnimatedLoginPageState();
}

class _AnimatedLoginPageState extends State<AnimatedLoginPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  var animationLink = 'assets/login.riv';
  late SMITrigger successTrigger, failTrigger;
  late SMIBool lookBool,closeEyesBool;
  Artboard? artBoard;
  late StateMachineController? stateMachineController ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initArtBord();
  }

  initArtBord(){
    rootBundle.load(animationLink).then((value) {
      final file = RiveFile.import(value);
      final art = file.mainArtboard;
      stateMachineController = StateMachineController.fromArtboard(art, "Login Machine")!;
      if(stateMachineController != null){
        art.addController(stateMachineController!);
      }
setState(() {
  artBoard = art;
});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(artBoard!=null)
          SizedBox(
            height: 350,
            width: 400,
            child: Rive(artboard: artBoard!),
          ),

          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: userNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              //height: 50,
              width: 200,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  print(userNameController.text);
                  print(passwordController.text);
                },
              )),
        ],
      ),
    );
  }
}
