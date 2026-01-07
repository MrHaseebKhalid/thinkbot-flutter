import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:think_bot/Resources/resources.dart';
import 'package:think_bot/Screens/Chat/chat_screen.dart';
import 'package:think_bot/Screens/Opener/opener.dart';

import '../../Base/Resizer/fetch_pixels.dart';
import '../../Provider/data_provider.dart';

class SplashFirst extends StatefulWidget {
  const SplashFirst({super.key});

  @override
  State<SplashFirst> createState() => _SplashFirstState();
}

class _SplashFirstState extends State<SplashFirst> {
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(120)),
            child: AnimatedTextKit(
              onFinished: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      final dataProvider = context.read<DataProvider>();
                      if (dataProvider.accountLogIn) {
                        return const ChatScreen();
                      } else {
                        return const Opener();
                      }
                    },
                  ),
                );
              },
              isRepeatingAnimation: false,
              totalRepeatCount: 1,
              pause: Duration(milliseconds: 1000),
              animatedTexts: [
                TyperAnimatedText(
                  R.strings.systemBooting,
                  speed: Duration(milliseconds: 100),
                  textStyle: R.textStyle.regularRobotoDisplay().copyWith(
                    fontSize: 22.0,
                  ),
                ),
                TyperAnimatedText(
                  R.strings.loadingNeuralModules,
                  speed: Duration(milliseconds: 100),
                  textStyle: R.textStyle.regularRobotoDisplay().copyWith(
                    fontSize: 22.0,
                  ),
                ),
                TyperAnimatedText(
                  R.strings.readyToThink,
                  speed: Duration(milliseconds: 100),
                  textStyle: R.textStyle.regularRobotoDisplay().copyWith(
                    fontSize: 22.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
