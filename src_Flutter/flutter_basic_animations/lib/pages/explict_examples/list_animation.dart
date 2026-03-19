import 'package:flutter/material.dart';

class ListAnimationPage extends StatefulWidget {
  const ListAnimationPage({super.key});

  @override
  State<ListAnimationPage> createState() => _ListAnimationPageState();
}

class _ListAnimationPageState extends State<ListAnimationPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController turnController;
  int itemCount = 5;
  late List<Animation<Offset>> animations = [];
  late Animation<double> turnAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: itemCount),
    );
    animations = List.generate(
      itemCount,
      (index) => Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(index * (1 / itemCount), 1),
        ),
      ),
    );
    turnController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    turnAnimation = Tween<double>(begin: 0, end: 1).animate(turnController);
    turnController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List Animation Page"), centerTitle: true),
      floatingActionButton: RotationTransition(
        turns: turnAnimation,
        child: ElevatedButton(
          onPressed: () {
            if (controller.isCompleted) {
              controller.reverse();
              return;
            }
            controller.forward();
          },
          child: Text("Try Me!"),
        ),
      ),
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: animations[index],
            child: ListTile(
              title: Text("List Number: ${(index + 1).toString()}"),
            ),
          );
        },
      ),
    );
  }
}
