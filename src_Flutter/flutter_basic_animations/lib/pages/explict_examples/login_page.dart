import 'package:flutter/material.dart';

class LoginAnimationPage extends StatefulWidget {
  const LoginAnimationPage({super.key});

  @override
  State<LoginAnimationPage> createState() => _LoginAnimationPageState();
}

class _LoginAnimationPageState extends State<LoginAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> logoOpacity;
  late Animation<Offset> userInputTextAnimation;
  late Animation<double> userInputScaleAnimation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    logoOpacity = Tween<double>(begin: 0, end: 1).animate(controller);
    userInputTextAnimation = Tween<Offset>(
      begin: Offset(-1, -1),
      end: Offset.zero,
    ).animate(controller);
    userInputScaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: controller,curve: Curves.ease));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Animation Page"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: mainFiled(
            logoOpacity,
            userInputTextAnimation,
            userInputScaleAnimation,
          ),
        ),
      ),
    );
  }
}

Column mainFiled(
  Animation<double> logoOp,
  Animation<Offset> direction,
  Animation<double> scale,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: FadeTransition(opacity: logoOp, child: FlutterLogo(size: 80)),
      ),
      userInputField(direction, scale),
    ],
  );
}

Padding userInputField(Animation<Offset> position, Animation<double> scale) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SlideTransition(
      position: position,
      child: ScaleTransition(
        scale: scale,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "User Email",
                border: border(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: "Password",
                border: border(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(onPressed: () {}, child: Text("Submit")),
          ],
        ),
      ),
    ),
  );
}

OutlineInputBorder border() {
  return OutlineInputBorder(borderRadius: BorderRadius.circular(20));
}
