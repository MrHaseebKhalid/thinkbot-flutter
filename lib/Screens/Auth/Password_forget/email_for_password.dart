import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:think_bot/Screens/Auth/Password_forget/change_password.dart";
import "package:think_bot/Widgets/my_button.dart";
import "package:velocity_x/velocity_x.dart";

import "../../../Base/Resizer/fetch_pixels.dart";
import "../../../Base/Resizer/widget_utils.dart";
import "../../../Models/user_model.dart";
import "../../../Provider/data_provider.dart";
import "../../../Resources/resources.dart";
import "../Sign In/sign_in_screen.dart";
import "../Verification/code_verity_screen.dart";

class EmailForPassword extends StatelessWidget {
  const EmailForPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<DataProvider>();
    final emailCheckKey = GlobalKey<FormState>();
    String? checkEmailForPassword;
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
                  getVerSpace(60.0),
                  authText(
                    text: R.strings.forgetPassword.capitalized,
                    alignment: Alignment.center,
                    leftPadding: 0.0,
                    fontSize: 30.0,
                  ),
                  getVerSpace(30.0),
                  authText(
                    text: R.strings.passwordChangeText,
                    leftPadding: 0.0,
                  ),
                  getVerSpace(30),
                  Form(
                    key: emailCheckKey,
                    child: Column(
                      children: [
                        authText(text: R.strings.email),
                        getVerSpace(10.0),
                        getTextFormField(
                          moveNext: false,
                          context: context,
                          showText: R.strings.showDummyEmail,
                          onSaved: (newValue) {
                            checkEmailForPassword = newValue;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return R.strings.emailNotEnterError;
                            } else if (!value.validateEmail()) {
                              return R.strings.invalidEmail;
                            }
                            return null;
                          },
                        ),

                        getVerSpace(60.0),
                        MyButton(
                          buttonText: R.strings.continueText,
                          onTap: () async {
                            await Future.delayed(Duration(milliseconds: 500));
                            if (emailCheckKey.currentState!.validate()) {
                              emailCheckKey.currentState!.save();
                              bool allow = false;

                              for (UserModel x in dataProvider.users) {
                                if (checkEmailForPassword == x.email) {
                                  allow = true;
                                  break;
                                }
                              }

                              if (!allow) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SignInScreen();
                                    },
                                  ),
                                );
                                await Future.delayed(
                                  Duration(milliseconds: 500),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: R.colors.lightGreyColor,
                                    content: Text(
                                      R.strings.problemInChangePasswordEmail,
                                      textScaler: TextScaler.linear(
                                        FetchPixels.getTextScale(),
                                      ),
                                      style: R.textStyle
                                          .boldRobotoDisplay()
                                          .copyWith(fontSize: 14),
                                    ),
                                  ),
                                );
                              } else {
                                await Future.delayed(
                                  Duration(milliseconds: 1500),
                                  () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return CodeVerifyScreen(
                                            navigateScreen: ChangePassword(
                                              userEmail: checkEmailForPassword!,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
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
