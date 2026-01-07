import "package:flutter/material.dart";
import "package:think_bot/Screens/auth/Sign%20In/sign_in_screen.dart";
import "package:think_bot/Widgets/my_button.dart";

import "../../../Base/Resizer/fetch_pixels.dart";
import "../../../Base/Resizer/widget_utils.dart";
import "../../../Resources/resources.dart";

class VerificationDone extends StatelessWidget {
  final String showText;
  final double textSize;

  const VerificationDone({
    super.key,
    required this.showText,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: FetchPixels.getPixelWidth(20.0),
              vertical: FetchPixels.getPixelHeight(10.0),
            ),
            child: Center(
              child: Column(
                children: [
                  getVerSpace(30),

                  getCheckSign(),

                  Text(
                    showText,
                    textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                    style: R.textStyle.boldRobotoDisplay().copyWith(
                      fontSize: textSize,
                    ),
                  ),

                  getVerSpace(10),
                  Text(
                    R.strings.userCanSignIn,
                    textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                    style: R.textStyle.regularRobotoDisplay().copyWith(
                      fontSize: 16,
                    ),
                  ),

                  getVerSpace(350),

                  MyButton(
                    buttonText: R.strings.redirectToSignIn,
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
