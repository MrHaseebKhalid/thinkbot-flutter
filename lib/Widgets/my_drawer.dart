import "dart:ui";

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:think_bot/Screens/Profile/profile_page.dart";
import "package:tuple/tuple.dart";

import "../Base/Resizer/fetch_pixels.dart";
import "../Base/Resizer/widget_utils.dart";
import "../Provider/data_provider.dart";
import "../Resources/resources.dart";

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<DataProvider>();
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Drawer(
          shape: BoxBorder.all(
            color: R.colors.whiteColor.withValues(alpha: 0.1),
          ),
          backgroundColor: R.colors.blurColor.withValues(alpha: 0.4),
          width: FetchPixels.getWidthPercentSize(70),
          child: Column(
            children: [
              getVerSpace(20.0),
              ListTile(
                splashColor: R.colors.lightGreyColor,
                onTap: () async {
                  if (dataProvider.stillAnswering) {
                    customSnackBar(context, R.strings.showSnackText);
                  } else {
                    await Future.delayed(Duration(milliseconds: 1000), () {
                      if (dataProvider.chatStart == true) {
                        dataProvider.setChat(
                          startChat: false,
                          chatMap: [dataProvider.currentChatMap[0]],
                        );
                      }
                      Scaffold.of(context).closeDrawer();
                    });
                  }
                },
                title: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Icon(Icons.message_outlined, size: 18),
                    ),
                    getHorSpace(10),
                    Text(
                      R.strings.newChat,

                      textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                      style: R.textStyle.mediumRobotoDisplay().copyWith(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              getVerSpace(5.0),
              const Divider(),
              getVerSpace(5.0),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: FetchPixels.getPixelWidth(15.0),
                  ),
                  child: Text(
                    R.strings.chats,
                    textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                    style: R.textStyle.boldRobotoDisplay().copyWith(
                      fontSize: 25.0,
                      color: R.colors.pinPutStrokeColor,
                    ),
                  ),
                ),
              ),
              getVerSpace(10.0),
              Expanded(
                child: Selector<DataProvider, bool>(
                  selector: (context, dataProvider) {
                    return dataProvider.chatsList.isNotEmpty;
                  },
                  builder: (context, value, child) {
                    if (value == true) {
                      return Selector<
                        DataProvider,
                        Tuple4<bool, bool, bool, List<Map<String, dynamic>>>
                      >(
                        selector: (context, dataProvider) {
                          return Tuple4(
                            dataProvider.stillAnswering,
                            dataProvider.changingChatTitle,
                            dataProvider.showNameCircle,
                            dataProvider.chatsList,
                          );
                        },
                        builder: (context, value, child) {
                          final bool stillAnsweringBool = value.item1;
                          final bool changingBool = value.item2;
                          final bool circleBool = value.item3;
                          final List<Map<String, dynamic>> chatList =
                              value.item4;
                          return ListView.builder(
                            itemCount: chatList.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: FetchPixels.getPixelHeight(50.0),
                                child: getChatListTile(
                                  context,
                                  chatList,
                                  index,
                                  title: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textScaler: TextScaler.linear(
                                      FetchPixels.getTextScale(),
                                    ),
                                    text: TextSpan(
                                      style: R.textStyle
                                          .regularRobotoDisplay()
                                          .copyWith(fontSize: 16),
                                      children: [
                                        TextSpan(
                                          text: chatList[index]["chatName"],
                                        ),
                                        if (circleBool == true &&
                                            dataProvider.showCircleTitleIndex ==
                                                index)
                                          WidgetSpan(
                                            child: Padding(
                                              padding: EdgeInsetsGeometry.only(
                                                bottom:
                                                    FetchPixels.getPixelHeight(
                                                      3.0,
                                                    ),
                                              ),
                                              child: Container(
                                                height:
                                                    FetchPixels.getPixelHeight(
                                                      17,
                                                    ),
                                                width:
                                                    FetchPixels.getPixelWidth(
                                                      17,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: R.colors.whiteColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: FetchPixels.getPixelHeight(75),
                          ),
                          child: Text(
                            R.strings.noChats,
                            textScaler: TextScaler.linear(
                              FetchPixels.getTextScale(),
                            ),
                            style: R.textStyle.regularRobotoDisplay().copyWith(
                              fontSize: 18.0,
                              color: R.colors.pinPutStrokeColor,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              const Divider(),
              getVerSpace(5.0),
              ListTile(
                splashColor: R.colors.lightGreyColor,
                onTap: () async {
                  if (dataProvider.stillAnswering) {
                    customSnackBar(context, R.strings.showSnackText);
                  } else {
                    await Future.delayed(Duration(milliseconds: 1000), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfilePage();
                          },
                        ),
                      );
                    });
                  }
                },

                leading: CircleAvatar(
                  radius: 19.0,
                  backgroundColor: R.colors.greyColor,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: R.colors.blackColor,
                    child: Text(
                      (dataProvider.users.isNotEmpty)
                          ? dataProvider
                                .users[dataProvider.currentUserIndex]
                                .firstName
                                .trim()
                                .substring(0, 1)
                                .toUpperCase()
                          : R.strings.errorSign,
                      textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                      style: R.textStyle.mediumRobotoDisplay().copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  R.strings.profile,
                  textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                  style: R.textStyle.mediumRobotoDisplay().copyWith(
                    fontSize: 18.0,
                  ),
                ),
              ),
              getVerSpace(10.0),
            ],
          ),
        ),
      ),
    );
  }
}
