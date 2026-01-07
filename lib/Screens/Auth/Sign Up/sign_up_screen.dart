import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:think_bot/Screens/Auth/Verification/verification_done.dart";
import "package:think_bot/Screens/auth/Sign%20In/sign_in_screen.dart";
import "package:think_bot/Widgets/my_button.dart";
import "package:velocity_x/velocity_x.dart";

import "../../../Base/Resizer/fetch_pixels.dart";
import "../../../Base/Resizer/widget_utils.dart";
import "../../../Models/user_model.dart";
import "../../../Provider/data_provider.dart";
import "../../../Resources/resources.dart";
import "../Verification/code_verity_screen.dart";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    final myProvider = context.read<DataProvider>();
    myProvider.resetEyeButtonData();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpKey = GlobalKey<FormState>();
    final myProvider = context.read<DataProvider>();
    String? firstName;
    String? lastName;
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
                children: [
                  getVerSpace(30.0),
                  Text(
                    R.strings.welcomeNote,
                    textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                    style: R.textStyle.semiBoldRobotoDisplay().copyWith(
                      fontSize: 23.0,
                    ),
                  ),
                  Text(
                    R.strings.appName,
                    textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                    style: R.textStyle.boldRobotoDisplay().copyWith(
                      fontSize: 40.0,
                      letterSpacing: 1,
                    ),
                  ),

                  getVerSpace(30.0),

                  Text(
                    R.strings.createAccount,
                    textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                    style: R.textStyle.mediumRobotoDisplay().copyWith(
                      fontSize: 23.0,
                      letterSpacing: 0,
                    ),
                  ),

                  getVerSpace(40.0),
                  Form(
                    key: signUpKey,
                    child: Column(
                      children: [
                        authText(text: R.strings.firstName),

                        getVerSpace(10.0),

                        getTextFormField(
                          showText: R.strings.showDummyFirstName,
                          context: context,
                          onSaved: (newValue) {
                            firstName = newValue;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return R.strings.firstNameNotEnterError;
                            } else if (value.length < 3) {
                              return R.strings.invalidFirstName;
                            } else if (!value.isLetter()) {
                              return R.strings.invalidName;
                            }
                            return null;
                          },
                        ),

                        getVerSpace(30.0),

                        authText(text: R.strings.lastName),

                        getVerSpace(10.0),

                        getTextFormField(
                          showText: R.strings.showDummyLastName,
                          context: context,
                          onSaved: (newValue) {
                            lastName = newValue;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return R.strings.lastNameNotEnterError;
                            } else if (value.length < 3) {
                              return R.strings.invalidLastName;
                            } else if (!value.isLetter()) {
                              return R.strings.invalidName;
                            }
                            return null;
                          },
                        ),

                        getVerSpace(30.0),

                        authText(text: R.strings.email),

                        getVerSpace(10.0),

                        getTextFormField(
                          showText: R.strings.showDummyEmail,
                          context: context,
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

                        getVerSpace(30.0),

                        authText(text: R.strings.setPassword),

                        getVerSpace(10.0),

                        getTextFormField(
                          controller: passwordController,
                          showButton: true,
                          eyeIconNumber: 2,
                          eyeIconAllowNumber: 2,
                          onTap: () => myProvider.changeEyeIcon(number: 2),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              myProvider.changeEyeIconAllow(
                                number: 2,
                                value: true,
                              );
                            } else {
                              myProvider.changeEyeIconAllow(
                                number: 2,
                                value: false,
                              );
                            }
                          },
                          context: context,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return R.strings.passwordNotEnterError;
                            } else if (value.length < 6) {
                              return R.strings.invalidPassword;
                            }
                            return null;
                          },
                        ),

                        getVerSpace(30.0),

                        authText(text: R.strings.confirmPassword),

                        getVerSpace(10.0),

                        getTextFormField(
                          moveNext: false,
                          showButton: true,
                          eyeIconNumber: 3,
                          eyeIconAllowNumber: 3,
                          onTap: () => myProvider.changeEyeIcon(number: 3),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              myProvider.changeEyeIconAllow(
                                number: 3,
                                value: true,
                              );
                            } else {
                              myProvider.changeEyeIconAllow(
                                number: 3,
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
                            } else if (value != passwordController.text) {
                              return R.strings.passwordNotMatchError;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  getVerSpace(50.0),
                  MyButton(
                    buttonText: R.strings.sigUp,
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 500));
                      if (signUpKey.currentState!.validate()) {
                        signUpKey.currentState!.save();
                        bool alreadyExist = false;

                        for (UserModel x in myProvider.users) {
                          if (email == x.email) {
                            alreadyExist = true;
                            break;
                          }
                        }

                        if (alreadyExist) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignUpScreen();
                              },
                            ),
                          );
                          await Future.delayed(Duration(milliseconds: 500));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: R.colors.lightGreyColor,
                              content: Text(
                                R.strings.accountAlreadyExist,
                                textScaler: TextScaler.linear(
                                  FetchPixels.getTextScale(),
                                ),
                                style: R.textStyle.boldRobotoDisplay().copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        } else {
                          myProvider.usersAdd(
                            firstName: firstName!,
                            lastName: lastName!,
                            email: email!,
                            password: password!,
                            chats: [],
                          );
                          await Future.delayed(
                            Duration(milliseconds: 1000),
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CodeVerifyScreen(
                                      navigateScreen: VerificationDone(
                                        textSize: 22,
                                        showText: R.strings.accountCreated,
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
                  getVerSpace(70.0),
                  Text(
                    R.strings.orSignUp,
                    textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                    style: R.textStyle.regularRobotoDisplay().copyWith(
                      fontSize: 16,
                    ),
                  ),
                  getVerSpace(25.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getSignUpOptionsContainer(
                        context,
                        imagePath: R.images.google,
                      ),
                      getHorSpace(20.0),
                      getSignUpOptionsContainer(
                        context,
                        imagePath: R.images.facebook,
                      ),
                      getHorSpace(20.0),
                      getSignUpOptionsContainer(
                        context,
                        imagePath: R.images.microsoft,
                      ),
                    ],
                  ),

                  getVerSpace(40.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      authText(text: R.strings.haveAnAccount, leftPadding: 0.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SignInScreen();
                              },
                            ),
                          );
                        },
                        child: authText(
                          text: R.strings.sigIn,
                          leftPadding: 7.0,
                          color: R.colors.blueColor,
                          underLine: true,
                        ),
                      ),
                    ],
                  ),

                  getVerSpace(100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
