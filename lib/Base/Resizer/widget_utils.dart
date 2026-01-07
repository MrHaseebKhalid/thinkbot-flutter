import "package:flutter/material.dart";
import "package:gpt_markdown/gpt_markdown.dart";
import "package:pinput/pinput.dart";
import "package:provider/provider.dart";
import "package:tuple/tuple.dart";

import "../../Provider/data_provider.dart";
import "../../Resources/resources.dart";
import "fetch_pixels.dart";

// To add Vertical Space:
Widget getVerSpace(double value) {
  return SizedBox(height: FetchPixels.getPixelHeight(value));
}

// To add horizontal Space:
Widget getHorSpace(double value) {
  return SizedBox(width: FetchPixels.getPixelWidth(value));
}

// To add custom text:
Widget authText({
  required String text,
  double fontSize = 16,
  Alignment alignment = Alignment.topLeft,
  Color? color,
  double? leftPadding,
  bool underLine = false,
}) {
  return Align(
    alignment: alignment,
    child: Padding(
      padding: EdgeInsets.only(
        left: FetchPixels.getPixelWidth(leftPadding ?? 20.0),
      ),
      child: Text(
        text,
        softWrap: true,
        textScaler: TextScaler.linear(FetchPixels.getTextScale()),
        style: R.textStyle.regularRobotoDisplay().copyWith(
          color: color ?? R.colors.whiteColor,
          fontSize: fontSize,
          decoration: (underLine) ? TextDecoration.underline : null,
          decorationColor: R.colors.blueColor,
        ),
      ),
    ),
  );
}

// To add Custom TextFormField:
Widget getTextFormField({
  bool showButton = false,
  bool moveNext = true,
  int? eyeIconNumber,
  int? eyeIconAllowNumber,
  VoidCallback? onTap,
  ValueChanged<String>? onChanged,
  String? showText,
  FormFieldSetter<String>? onSaved,
  TextEditingController? controller,
  required BuildContext context,
  required FormFieldValidator<String> validator,
}) {
  return Selector<DataProvider, Tuple2<bool, bool>>(
    selector: (context, myProvider) {
      bool? item1Value;
      bool? item2Value;
      if (eyeIconNumber == 1) {
        item1Value = myProvider.eyeButton1;
      } else if (eyeIconNumber == 2) {
        item1Value = myProvider.eyeButton2;
      } else if (eyeIconNumber == 3) {
        item1Value = myProvider.eyeButton3;
      } else if (eyeIconNumber == 4) {
        item1Value = myProvider.eyeButton4;
      } else if (eyeIconNumber == 5) {
        item1Value = myProvider.eyeButton5;
      } else {
        item1Value = false;
      }
      if (eyeIconAllowNumber == 1) {
        item2Value = myProvider.eyeButtonAllow1;
      } else if (eyeIconAllowNumber == 2) {
        item2Value = myProvider.eyeButtonAllow2;
      } else if (eyeIconAllowNumber == 3) {
        item2Value = myProvider.eyeButtonAllow3;
      } else if (eyeIconAllowNumber == 4) {
        item2Value = myProvider.eyeButtonAllow4;
      } else if (eyeIconAllowNumber == 5) {
        item2Value = myProvider.eyeButtonAllow5;
      } else {
        item2Value = false;
      }
      return Tuple2(item1Value, item2Value);
    },
    builder: (context, tuple, child) {
      bool value1 = tuple.item1;
      bool value2 = tuple.item2;
      return SizedBox(
        width: FetchPixels.getPixelWidth(350.0),
        child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          maxLines: 1,
          obscureText: value1,
          textAlign: TextAlign.start,
          validator: validator,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          textInputAction: (moveNext) ? TextInputAction.next : null,
          style: R.textStyle.regularRobotoDisplay().copyWith(fontSize: 16),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: FetchPixels.getPixelWidth(10.0)),
              child: (showButton)
                  ? IconButton(
                      onPressed: (value2) ? onTap : null,
                      icon: (value2)
                          ? ((value1)
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_outlined))
                          : Icon(
                              Icons.visibility_off_outlined,
                              color: R.colors.greyColor,
                            ),
                    )
                  : null,
            ),
            enabledBorder: R.decoration.enabledBorder,
            focusedBorder: R.decoration.focusedBorder,
            errorBorder: R.decoration.errorBorder,
            focusedErrorBorder: R.decoration.errorBorder,

            filled: true,
            fillColor: R.colors.darkGreyColor,
            hintText: showText,
            hintStyle: R.textStyle.regularRobotoDisplay().copyWith(
              color: R.colors.greyColor,
              fontSize: 16,
            ),
          ),
          onSaved: onSaved,
        ),
      );
    },
  );
}

// To add Custom Sign up Containers:
Widget getSignUpOptionsContainer(
  BuildContext context, {
  required String imagePath,
}) {
  return InkWell(
    onTap: () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: R.colors.lightGreyColor,
          content: Text(
            R.strings.serviceComingSoon,
            textScaler: TextScaler.linear(FetchPixels.getTextScale()),
            style: R.textStyle.boldRobotoDisplay().copyWith(fontSize: 14),
          ),
        ),
      );
    },
    borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12.0)),
    child: Container(
      padding: EdgeInsets.all(FetchPixels.getPixelHeight(10.0)),
      width: FetchPixels.getPixelWidth(90),
      height: FetchPixels.getPixelHeight(60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12.0)),
        border: BoxBorder.all(color: R.colors.lightGreyColor, width: 2),
      ),
      child: Image.asset(imagePath),
    ),
  );
}

PinTheme getPinTheme({Color? color}) {
  return PinTheme(
    height: FetchPixels.getPixelHeight(58.74),
    width: FetchPixels.getPixelWidth(56),
    textStyle: R.textStyle.semiBoldRobotoDisplay().copyWith(fontSize: 24),

    decoration: BoxDecoration(
      color: R.colors.pinPutFillColor,
      border: BoxBorder.all(
        color: color ?? R.colors.greyColor,
        width: (color == null) ? 2 : 3,
      ),
      borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12.0)),
    ),
  );
}

Widget getDots({
  required double width,
  required double height,
  double? top,
  double? bottom,
  double? left,
  double? right,
}) {
  return Positioned(
    top: top,
    bottom: bottom,
    left: left,
    right: right,
    child: Container(
      width: FetchPixels.getPixelWidth(width),
      height: FetchPixels.getPixelHeight(height),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: R.colors.whiteColor,
      ),
    ),
  );
}

Widget getCheckSign() {
  return Stack(
    children: [
      Container(
        padding: EdgeInsets.all(FetchPixels.getPixelHeight(55.0)),
        height: FetchPixels.getPixelHeight(190),
        width: FetchPixels.getPixelWidth(190),
        child: Container(
          padding: EdgeInsets.all(FetchPixels.getPixelHeight(12.0)),
          height: FetchPixels.getPixelHeight(80),
          width: FetchPixels.getPixelWidth(80),
          decoration: BoxDecoration(
            color: R.colors.backButtonColor,
            shape: BoxShape.circle,
            border: BoxBorder.all(width: 2, color: R.colors.whiteColor),
          ),
          child: ImageIcon(
            AssetImage(R.images.tickIcon),
            color: R.colors.whiteColor,
          ),
        ),
      ),

      getDots(width: 6, height: 6, top: 35, left: 70),
      getDots(width: 4, height: 4, bottom: 75, left: 40),
      getDots(width: 3, height: 3, bottom: 60, right: 30),
    ],
  );
}

Widget getGptMarkdown(String data) {
  return GptMarkdown(
    data,
    maxLines: null,
    textScaler: TextScaler.linear(FetchPixels.getTextScale()),
    style: R.textStyle.regularRobotoDisplay().copyWith(fontSize: 16.0),
    overflow: TextOverflow.clip,
  );
}

void customSnackBar(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final entry = OverlayEntry(
    builder: (context) {
      return Positioned(
        bottom: FetchPixels.getPixelHeight(33),
        right: FetchPixels.getPixelWidth(20),
        left: FetchPixels.getPixelWidth(20),
        child: Material(
          color: R.colors.darkGreyColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              FetchPixels.getPixelHeight(8.0),
            ),
            side: BorderSide(color: R.colors.whiteColor.withValues(alpha: 0.2)),
          ),

          child: Padding(
            padding: EdgeInsetsGeometry.all(FetchPixels.getPixelHeight(16.0)),
            child: Text(
              message,
              textScaler: TextScaler.linear(FetchPixels.getTextScale()),
              style: R.textStyle.semiBoldRobotoDisplay().copyWith(
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    },
  );
  overlay.insert(entry);
  Future.delayed(Duration(seconds: 2), () {
    entry.remove();
  });
}

Widget getChatListTile(
  BuildContext currentContext,
  List<Map<String, dynamic>> chatList,
  int index, {
  required Widget title,
}) {
  final dataProvider = currentContext.read<DataProvider>();
  final TextEditingController renameController = TextEditingController();
  final renameKey = GlobalKey<FormState>();
  return GestureDetector(
    onLongPressStart: (details) async {
      if (dataProvider.stillAnswering) {
        customSnackBar(currentContext, R.strings.showSnackText);
      } else {
        final tapPosition = details.globalPosition;
        await showMenu<void>(
          color: R.colors.lightGreyColor,
          position: RelativeRect.fromLTRB(
            FetchPixels.getPixelWidth(250),
            tapPosition.dy,
            FetchPixels.getPixelWidth(70),
            tapPosition.dy + 1,
          ),
          context: currentContext,
          items: [
            PopupMenuItem(
              onTap: () async {
                renameController.text = chatList[index]["chatName"];
                await Future.delayed(Duration(milliseconds: 500), () {
                  showDialog(
                    context: currentContext,
                    builder: (context) => getListTileAlertDialog(
                      content: Form(
                        key: renameKey,
                        child: TextFormField(
                          autofocus: true,
                          controller: renameController,
                          style: R.textStyle.regularRobotoDisplay().copyWith(
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            constraints: BoxConstraints(
                              minWidth: FetchPixels.getPixelWidth(250),
                              maxWidth: FetchPixels.getPixelWidth(250),
                            ),
                            enabledBorder: R.decoration.enabledBorder,
                            focusedBorder: R.decoration.focusedBorder,
                            errorBorder: R.decoration.errorBorder,
                            focusedErrorBorder: R.decoration.errorBorder,
                            filled: true,
                            fillColor: R.colors.darkGreyColor,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter chat name";
                            } else if (value == chatList[index]["chatName"]) {
                              return "Please enter new name to continue!";
                            }
                            return null;
                          },
                        ),
                      ),
                      firstButton: containerButton(
                        buttonText: R.strings.cancel,
                        onTap: () async {
                          await Future.delayed(Duration(milliseconds: 500), () {
                            Navigator.of(context).pop();
                          });
                        },
                      ),
                      lastButton: containerButton(
                        buttonText: R.strings.rename,
                        onTap: () async {
                          await Future.delayed(Duration(milliseconds: 500), () {
                            if (renameKey.currentState!.validate()) {
                              dataProvider.showCircleTitleIndex = index;
                              Navigator.of(currentContext).pop();
                              dataProvider.getOrChangeChatName(
                                index,
                                newName: renameController.text,
                              );
                            }
                          });
                        },
                      ),
                    ),
                  );
                });
              },
              child: RichText(
                textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.drive_file_rename_outline, size: 20),
                    ),
                    TextSpan(text: "   "),
                    TextSpan(
                      text: R.strings.rename,
                      style: R.textStyle.boldRobotoDisplay().copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              onTap: () async {
                await Future.delayed(Duration(milliseconds: 500), () {
                  showDialog(
                    context: currentContext,
                    builder: (context) => getListTileAlertDialog(
                      content: Text(
                        R.strings.doYouWantToDelete,
                        textScaler: TextScaler.linear(
                          FetchPixels.getTextScale(),
                        ),
                        style: R.textStyle.boldRobotoDisplay().copyWith(
                          fontSize: 16.0,
                        ),
                      ),
                      firstButton: containerButton(
                        buttonText: R.strings.cancel,
                        onTap: () async {
                          await Future.delayed(Duration(milliseconds: 500), () {
                            Navigator.of(context).pop();
                          });
                        },
                      ),

                      lastButton: containerButton(
                        buttonText: R.strings.delete,
                        onTap: () async {
                          await Future.delayed(Duration(milliseconds: 500), () {
                            Navigator.of(currentContext).pop();
                          });
                          await Future.delayed(
                            Duration(milliseconds: 1000),
                            () {
                              chatList.removeAt(index);
                              if (dataProvider.chatStart == true) {
                                dataProvider.setChat(
                                  startChat: false,
                                  chatMap: [dataProvider.currentChatMap[0]],
                                );
                              }
                              Scaffold.of(currentContext).closeDrawer();
                              ScaffoldMessenger.of(currentContext).showSnackBar(
                                SnackBar(
                                  backgroundColor: R.colors.lightGreyColor,
                                  content: Text(
                                    R.strings.chatDeleted,
                                    textScaler: TextScaler.linear(
                                      FetchPixels.getTextScale(),
                                    ),
                                    style: R.textStyle
                                        .boldRobotoDisplay()
                                        .copyWith(fontSize: 14),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        buttonTextColor: R.colors.redColor,
                      ),
                    ),
                  );
                });
              },
              child: RichText(
                textScaler: TextScaler.linear(FetchPixels.getTextScale()),

                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.delete_outline,
                        color: R.colors.redColor,
                        size: 20,
                      ),
                    ),
                    TextSpan(text: "   "),
                    TextSpan(
                      text: R.strings.delete,
                      style: R.textStyle.boldRobotoDisplay().copyWith(
                        fontSize: 14,
                        color: R.colors.redColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    },
    child: ListTile(
      splashColor: R.colors.lightGreyColor,
      selected:
          (dataProvider.chatIndex == index && dataProvider.chatStart == true),
      selectedTileColor: R.colors.lightGreyColor,
      tileColor: R.colors.transparent,
      trailing: (dataProvider.stillAnswering && dataProvider.chatIndex == index)
          ? Padding(
              padding: EdgeInsetsGeometry.only(
                bottom: FetchPixels.getPixelHeight(6.0),
              ),
              child: CircularProgressIndicator(
                color: R.colors.whiteColor,
                strokeWidth: 2,
                constraints: BoxConstraints(
                  minWidth: 18.0,
                  maxWidth: 20.0,
                  maxHeight: 20.0,
                  minHeight: 18.0,
                ),
              ),
            )
          : null,
      title: title,

      onTap: () async {
        if (dataProvider.stillAnswering && dataProvider.chatIndex != index) {
          customSnackBar(currentContext, R.strings.showSnackText);
        } else {
          await Future.delayed(Duration(milliseconds: 1000), () {
            final List<Map<String, dynamic>> currentChatList = dataProvider
                .getDataType(chatList[index]["chats"]);
            if (dataProvider.chatIndex != index) {
              dataProvider.allowSpace = false;
              dataProvider.setChat(startChat: true, chatMap: currentChatList);
              dataProvider.chatIndex = index;
            } else if (dataProvider.chatIndex == index &&
                dataProvider.chatStart == false) {
              dataProvider.allowSpace = false;
              dataProvider.setChat(startChat: true, chatMap: currentChatList);
            }
            Scaffold.of(currentContext).closeDrawer();
          });
        }
      },
    ),
  );
}

Widget getProfileListTile({
  required String titleText,
  required IconData icon,
  IconData? trailingIcon,
  String? subTitleText,
  double? titleTextSize,

  Color? leadingIconColor,
  Color? titleTextColor,
  GestureTapCallback? onTap,
}) {
  return ListTile(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12)),
    ),
    trailing: (trailingIcon != null)
        ? Icon(trailingIcon, color: R.colors.whiteColor, size: 18)
        : null,
    leading: Icon(
      icon,
      color: leadingIconColor ?? R.colors.whiteColor,
      size: 23,
    ),
    title: Text(
      titleText,
      textScaler: TextScaler.linear(FetchPixels.getTextScale()),
      style: R.textStyle.boldRobotoDisplay().copyWith(
        fontSize: titleTextSize ?? 16.0,
        color: titleTextColor ?? R.colors.whiteColor,
      ),
    ),
    subtitle: (subTitleText != null)
        ? Text(
            subTitleText,
            textScaler: TextScaler.linear(FetchPixels.getTextScale()),
            style: R.textStyle.regularRobotoDisplay().copyWith(fontSize: 14.0),
          )
        : null,

    onTap: onTap,
  );
}

Widget containerButton({
  required String buttonText,
  required GestureTapCallback onTap,
  Color? buttonTextColor,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(10)),
    child: Container(
      height: FetchPixels.getPixelHeight(50),
      width: FetchPixels.getPixelWidth(75),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: R.colors.transparent,
        border: BoxBorder.all(color: R.colors.greyColor, width: 1.5),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(10)),
      ),
      child: Text(
        buttonText,
        textScaler: TextScaler.linear(FetchPixels.getTextScale()),
        style: R.textStyle.boldRobotoDisplay().copyWith(
          fontSize: 14,
          color: buttonTextColor ?? R.colors.whiteColor,
        ),
      ),
    ),
  );
}

Widget getListTileAlertDialog({
  required Widget content,
  required Widget firstButton,
  required Widget lastButton,
}) {
  return AlertDialog(
    actionsAlignment: MainAxisAlignment.spaceBetween,
    contentPadding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 30),
    content: content,
    actions: [firstButton, lastButton],
  );
}
