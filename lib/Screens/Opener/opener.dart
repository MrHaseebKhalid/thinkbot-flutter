import "package:flutter/material.dart";
import "package:think_bot/Widgets/my_button.dart";

import "../../Base/Resizer/fetch_pixels.dart";
import "../../Base/Resizer/widget_utils.dart";
import "../../Resources/resources.dart";
import "../Auth/Sign In/sign_in_screen.dart";

class Opener extends StatelessWidget {
  const Opener({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: FetchPixels.getPixelHeight(10.0),
              horizontal: FetchPixels.getPixelWidth(20.0),
            ),
            child: Center(
              child: Column(
                children: [
                  getVerSpace(20.0),
                  Text(
                    R.strings.welcomeNote,
                    textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                    style: R.textStyle.regularRobotoDisplay().copyWith(
                      fontSize: 23.0,
                    ),
                  ),
                  Text(
                    R.strings.appName,
                    textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                    style: R.textStyle.mediumRobotoDisplay().copyWith(
                      fontSize: 40.0,
                    ),
                  ),
                  Container(
                    width: FetchPixels.getPixelWidth(400),
                    height: FetchPixels.getPixelHeight(420),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(R.images.opener),
                      ),
                    ),
                  ),
                  getVerSpace(20.0),
                  Text(
                    textAlign: TextAlign.center,
                    R.strings.openerText,
                    textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                    style: R.textStyle.regularRobotoDisplay().copyWith(
                      fontSize: 16.0,
                    ),
                  ),
                  getVerSpace(60.0),

                  MyButton(
                    buttonText: R.strings.getStarted,
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 500));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignInScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
