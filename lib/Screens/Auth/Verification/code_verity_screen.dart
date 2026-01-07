import "package:flutter/material.dart";
import "package:pinput/pinput.dart";
import "package:think_bot/Widgets/my_button.dart";

import "../../../Base/Resizer/fetch_pixels.dart";
import "../../../Base/Resizer/widget_utils.dart";
import "../../../Resources/resources.dart";

class CodeVerifyScreen extends StatelessWidget {
  final Widget navigateScreen;

  const CodeVerifyScreen({super.key, required this.navigateScreen});

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
                  getVerSpace(10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: FetchPixels.getPixelHeight(50),
                        width: FetchPixels.getPixelWidth(50),
                        decoration: BoxDecoration(
                          color: R.colors.backButtonColor,
                          borderRadius: BorderRadius.circular(
                            FetchPixels.getPixelHeight(10.0),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: R.colors.whiteColor,
                        ),
                      ),
                    ),
                  ),

                  getVerSpace(30.0),

                  authText(
                    text: R.strings.verifyItsYou,
                    fontSize: 30,
                    leftPadding: 0.0,
                  ),

                  getVerSpace(15),

                  authText(text: R.strings.checkCode, leftPadding: 0.0),

                  getVerSpace(30),

                  Pinput(
                    autofocus: true,
                    length: 4,
                    defaultPinTheme: getPinTheme(),
                    focusedPinTheme: getPinTheme(
                      color: R.colors.pinPutStrokeColor,
                    ),
                    errorPinTheme: getPinTheme(color: R.colors.redColor),
                  ),

                  getVerSpace(40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      authText(text: R.strings.codeNotReceive),
                      authText(
                        text: R.strings.resendCode,
                        leftPadding: 5.0,
                        underLine: true,
                        color: R.colors.blueColor,
                      ),
                    ],
                  ),
                  getVerSpace(40),

                  MyButton(
                    buttonText: R.strings.confirmCode,
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 500));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return navigateScreen;
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
