import "package:flutter/material.dart";
import "package:think_bot/Screens/Chat/chat_screen.dart";

import "../../Base/Resizer/fetch_pixels.dart";
import "../../Base/Resizer/widget_utils.dart";
import "../../Resources/resources.dart";

class SplashSecond extends StatefulWidget {
  const SplashSecond({super.key});

  @override
  State<SplashSecond> createState() => _SplashSecondState();
}

class _SplashSecondState extends State<SplashSecond> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const ChatScreen();
          },
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                R.strings.smartChoice,
                textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                style: R.textStyle.regularRobotoDisplay().copyWith(
                  fontSize: 30,
                ),
              ),
              getVerSpace(150),
            ],
          ),
        ),
      ),
    );
  }
}
