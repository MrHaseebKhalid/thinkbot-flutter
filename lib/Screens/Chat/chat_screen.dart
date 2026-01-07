import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:think_bot/Screens/Chat/Widgets/chat_box.dart";
import "package:think_bot/Screens/Chat/Widgets/text_box.dart";
import "package:think_bot/Widgets/my_drawer.dart";

import "../../Base/Resizer/fetch_pixels.dart";
import "../../Base/Resizer/widget_utils.dart";
import "../../Provider/data_provider.dart";
import "../../Resources/resources.dart";

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<DataProvider>();
    final resetAllow = context.select<DataProvider, bool>(
      (provider) => provider.resetAllow,
    );
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: resetAllow,
        onDrawerChanged: (isOpened) {
          dataProvider.resetAllow = !isOpened;
          dataProvider.update();
          MyTextBox.textBoxFocusNode.unfocus();
        },
        appBar: AppBar(
          title: Text(
            R.strings.appName,
            textScaler: TextScaler.linear(FetchPixels.getTextScale()),
            style: R.textStyle.boldRobotoDisplay().copyWith(
              fontSize: 25,
              letterSpacing: 1.0,
            ),
          ),
          leadingWidth: 65,
          leading: Padding(
            padding: EdgeInsets.only(left: FetchPixels.getPixelWidth(10)),
            child: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(CupertinoIcons.sidebar_left, size: 20),
                );
              },
            ),
          ),
          actionsPadding: EdgeInsets.only(right: FetchPixels.getPixelWidth(7)),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    if (dataProvider.stillAnswering) {
                      customSnackBar(context, R.strings.showSnackText);
                    } else {
                      if (dataProvider.chatStart == true) {
                        dataProvider.setChat(
                          startChat: false,
                          chatMap: [dataProvider.currentChatMap[0]],
                        );
                      }
                      MyTextBox.textBoxFocusNode.unfocus();
                    }
                  },
                  icon: Icon(Icons.message_outlined, size: 22),
                );
              },
            ),
          ],
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Divider(thickness: 1.0),

            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: FetchPixels.getPixelWidth(15.0),
                  vertical: FetchPixels.getPixelHeight(15.0),
                ),
                child: Selector<DataProvider, bool>(
                  selector: (context, dataProvider) {
                    return dataProvider.chatStart;
                  },
                  builder: (context, value, child) {
                    return (value)
                        ? const ChatBox()
                        : Padding(
                            padding: EdgeInsets.all(
                              FetchPixels.getPixelHeight(4.0),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${R.strings.hiText} ${dataProvider.users[dataProvider.currentUserIndex].firstName},",

                                    textScaler: TextScaler.linear(
                                      FetchPixels.getTextScale(),
                                    ),
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: R.textStyle
                                        .regularRobotoDisplay()
                                        .copyWith(fontSize: 23),
                                  ),
                                  getVerSpace(10),
                                  Text(
                                    R.strings.chatScreenText,
                                    textScaler: TextScaler.linear(
                                      FetchPixels.getTextScale(),
                                    ),
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: R.textStyle
                                        .regularRobotoDisplay()
                                        .copyWith(fontSize: 23),
                                  ),
                                  getVerSpace(50),
                                ],
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),

            const MyTextBox(),
          ],
        ),
        drawer: const MyDrawer(),
      ),
    );
  }
}
