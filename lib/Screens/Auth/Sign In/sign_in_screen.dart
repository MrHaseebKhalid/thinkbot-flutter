import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:think_bot/Models/user_model.dart";
import "package:think_bot/Resources/resources.dart";
import "package:think_bot/Screens/Auth/Password_forget/email_for_password.dart";
import "package:think_bot/Screens/Splash/splash2.dart";
import "package:think_bot/Screens/auth/Sign%20Up/sign_up_screen.dart";
import "package:think_bot/Widgets/my_button.dart";
import "package:velocity_x/velocity_x.dart";

import "../../../Base/Resizer/fetch_pixels.dart";
import "../../../Base/Resizer/widget_utils.dart";
import "../../../Provider/data_provider.dart";

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    final myProvider = context.read<DataProvider>();
    myProvider.resetEyeButtonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<DataProvider>();
    final signInKey = GlobalKey<FormState>();
    String? email;
    String? password;

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  getVerSpace(35.0),

                  Text(
                    R.strings.appName,
                    textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                    style: R.textStyle.boldRobotoDisplay().copyWith(
                      fontSize: 40.0,
                      letterSpacing: 1,
                    ),
                  ),

                  getVerSpace(45.0),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: FetchPixels.getPixelWidth(10.0),
                      ),
                      child: Text(
                        R.strings.signInToAccount,
                        textScaler: TextScaler.linear(
                          FetchPixels.getTextScale(),
                        ),
                        style: R.textStyle.regularRobotoDisplay().copyWith(
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ),

                  getVerSpace(35),

                  Form(
                    key: signInKey,
                    child: Column(
                      children: [
                        authText(text: R.strings.email),

                        getVerSpace(10),

                        getTextFormField(
                          context: context,
                          showText: R.strings.showDummyEmail,
                          onSaved: (newValue) {
                            email = newValue;
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

                        getVerSpace(30),

                        authText(text: R.strings.password),

                        getVerSpace(10),

                        getTextFormField(
                          moveNext: false,
                          showButton: true,
                          eyeIconNumber: 1,
                          eyeIconAllowNumber: 1,
                          onTap: () => dataProvider.changeEyeIcon(number: 1),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              dataProvider.changeEyeIconAllow(
                                number: 1,
                                value: true,
                              );
                            } else {
                              dataProvider.changeEyeIconAllow(
                                number: 1,
                                value: false,
                              );
                            }
                          },
                          context: context,
                          onSaved: (newValue) {
                            password = newValue;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return R.strings.passwordNotEnterError;
                            } else if (value.length < 6) {
                              return R.strings.invalidPassword;
                            }
                            return null;
                          },
                        ),
                        getVerSpace(20),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const EmailForPassword();
                                },
                              ),
                            );
                          },
                          child: authText(
                            text: R.strings.forgetPassword,
                            alignment: Alignment.topRight,
                            underLine: true,
                            color: R.colors.blueColor,
                          ),
                        ),

                        getVerSpace(50),

                        MyButton(
                          buttonText: R.strings.sigIn,
                          onTap: () async {
                            await Future.delayed(Duration(milliseconds: 500));

                            if (signInKey.currentState!.validate()) {
                              bool allow = false;
                              signInKey.currentState!.save();

                              for (UserModel x in dataProvider.users) {
                                if (email == x.email &&
                                    password == x.password) {
                                  dataProvider.currentUserIndex = dataProvider
                                      .users
                                      .indexOf(x);
                                  dataProvider.chatsList = dataProvider
                                      .users[dataProvider.currentUserIndex]
                                      .chats;
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
                                      R.strings.problemInSignIn,
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
                                    final dataProvider = context
                                        .read<DataProvider>();
                                    dataProvider.accountLogIn = true;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const SplashSecond();
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

                  getVerSpace(50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      authText(text: R.strings.haveNoAccount, leftPadding: 0.0),
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SignUpScreen();
                              },
                            ),
                          );
                        },
                        child: authText(
                          text: R.strings.sigUp,
                          color: R.colors.blueColor,
                          leftPadding: 7.0,
                          underLine: true,
                        ),
                      ),
                    ],
                  ),
                  getVerSpace(200.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
