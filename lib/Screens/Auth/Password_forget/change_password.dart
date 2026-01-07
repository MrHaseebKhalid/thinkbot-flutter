import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:think_bot/Screens/Auth/Verification/verification_done.dart";
import "package:think_bot/Widgets/my_button.dart";

import "../../../Base/Resizer/fetch_pixels.dart";
import "../../../Base/Resizer/widget_utils.dart";
import "../../../Models/user_model.dart";
import "../../../Provider/data_provider.dart";
import "../../../Resources/resources.dart";

class ChangePassword extends StatefulWidget {
  final String userEmail;

  const ChangePassword({super.key, required this.userEmail});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController passwordChangeController =
      TextEditingController();

  @override
  void initState() {
    final myProvider = context.read<DataProvider>();
    myProvider.resetEyeButtonData();
    super.initState();
  }

  @override
  void dispose() {
    passwordChangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? changedPassword;
    final myProvider = context.read<DataProvider>();
    final passwordChangeKey = GlobalKey<FormState>();
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
                  getVerSpace(45.0),
                  Text(
                    R.strings.enterNewPassword,
                    textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                    style: R.textStyle.boldRobotoDisplay().copyWith(
                      fontSize: 25.0,
                    ),
                  ),
                  getVerSpace(30.0),
                  authText(
                    text: R.strings.tryStrongPassword,
                    alignment: Alignment.center,
                  ),

                  getVerSpace(30.0),

                  Form(
                    key: passwordChangeKey,
                    child: Column(
                      children: [
                        authText(text: R.strings.setPassword),

                        getVerSpace(10.0),

                        getTextFormField(
                          controller: passwordChangeController,
                          showButton: true,
                          eyeIconNumber: 4,
                          eyeIconAllowNumber: 4,
                          onTap: () => myProvider.changeEyeIcon(number: 4),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              myProvider.changeEyeIconAllow(
                                number: 4,
                                value: true,
                              );
                            } else {
                              myProvider.changeEyeIconAllow(
                                number: 4,
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

                        getVerSpace(25.0),

                        authText(text: R.strings.confirmPassword),

                        getVerSpace(10.0),

                        getTextFormField(
                          moveNext: false,
                          showButton: true,
                          eyeIconNumber: 5,
                          eyeIconAllowNumber: 5,
                          onTap: () => myProvider.changeEyeIcon(number: 5),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              myProvider.changeEyeIconAllow(
                                number: 5,
                                value: true,
                              );
                            } else {
                              myProvider.changeEyeIconAllow(
                                number: 5,
                                value: false,
                              );
                            }
                          },
                          context: context,
                          onSaved: (newValue) {
                            changedPassword = newValue;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return R.strings.passwordNotEnterError;
                            } else if (value.length < 6) {
                              return R.strings.invalidPassword;
                            } else if (value != passwordChangeController.text) {
                              return R.strings.passwordNotMatchError;
                            }
                            return null;
                          },
                        ),

                        getVerSpace(40.0),
                        MyButton(
                          buttonText: R.strings.continueText,
                          onTap: () async {
                            await Future.delayed(Duration(milliseconds: 500));
                            if (passwordChangeKey.currentState!.validate()) {
                              passwordChangeKey.currentState!.save();

                              for (UserModel x in myProvider.users) {
                                if (widget.userEmail == x.email) {
                                  myProvider
                                          .users[myProvider.users.indexOf(x)]
                                          .password =
                                      changedPassword!;
                                  break;
                                }
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return VerificationDone(
                                      showText: R.strings.passwordChanged,
                                      textSize: 20,
                                    );
                                  },
                                ),
                              );
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
