import 'dart:ffi';

import 'package:flutter/material.dart';

class LoadingAnimationPage extends StatefulWidget {
  const LoadingAnimationPage({super.key});

  @override
  State<LoadingAnimationPage> createState() => _LoadingAnimationPageState();
}

class _LoadingAnimationPageState extends State<LoadingAnimationPage>
    with TickerProviderStateMixin {
  TextEditingController getPercentage = TextEditingController();
  late AnimationController controller;
  late AnimationController floatingButtonController;
  late Animation<double> floatingButtonAnimation;
  late Animation<double> progressAnimation;
  late double progress;

  @override
  void initState() {
    super.initState();
    getPercentage.text = 0.2.toString();
    progress = double.parse(getPercentage.text);
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    progressAnimation = Tween<double>(
      begin: 0,
      end: progress,
    ).animate(controller);
    floatingButtonController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    floatingButtonAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(floatingButtonController);
    floatingButtonController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Loading Animation Page"), centerTitle: true),
      floatingActionButton: SizedBox(
        width: 153,
        child: SizeTransition(
          sizeFactor: floatingButtonAnimation,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                print("Pressed: ${progress.toString()}");
                double oldProgress = progress;
                progress = double.parse(getPercentage.text);
                print("Ended: ${progress.toString()}");
                if (controller.isCompleted) {
                  controller.reset();
                  progressAnimation = Tween<double>(
                    begin: oldProgress,
                    end: progress,
                  ).animate(controller);
                  controller.forward();
                }
                controller.forward();
              });
            },
            child: Text("Enter New Value"),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: getPercentage,
                decoration: InputDecoration(border: border()),
              ),
              SizedBox(height: 70),
              Center(
                child: AnimatedBuilder(
                  animation: progressAnimation,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: CircularProgressIndicator(
                            value: progressAnimation.value,
                            color: Colors.blue,
                            strokeWidth: 8,
                          ),
                        ),
                        Positioned.directional(
                          textDirection: TextDirection.rtl,
                          top: 68,
                          end: 60,
                          child: Text(
                            "${(progressAnimation.value * 100).toInt()}%",
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder border() {
  return OutlineInputBorder(borderRadius: BorderRadius.circular(20));
}
