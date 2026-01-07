import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:think_bot/Screens/Opener/opener.dart";
import "package:think_bot/Screens/Profile/advanced_settings_page.dart";

import "../../Base/Resizer/fetch_pixels.dart";
import "../../Base/Resizer/widget_utils.dart";
import "../../Provider/data_provider.dart";
import "../../Resources/resources.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<DataProvider>();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            R.strings.profile,
            textScaler: TextScaler.linear(FetchPixels.getTextScale()),
            style: R.textStyle.boldRobotoDisplay().copyWith(
              fontSize: 23,
              letterSpacing: 1.0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Divider(thickness: 1.0),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: FetchPixels.getPixelHeight(10.0),
                    horizontal: FetchPixels.getPixelWidth(10.0),
                  ),
                  child: Column(
                    children: [
                      getProfileListTile(
                        titleText: R.strings.name,
                        icon: Icons.person,
                        subTitleText: (dataProvider.users.isNotEmpty)
                            ? "${dataProvider.users[dataProvider.currentUserIndex].firstName} ${dataProvider.users[dataProvider.currentUserIndex].lastName}"
                            : R.strings.noDataAvailable,
                      ),

                      getProfileListTile(
                        titleText: R.strings.email,
                        icon: Icons.email_outlined,
                        subTitleText: (dataProvider.users.isNotEmpty)
                            ? dataProvider
                                  .users[dataProvider.currentUserIndex]
                                  .email
                            : R.strings.noDataAvailable,
                      ),

                      getProfileListTile(
                        titleText: R.strings.advancedSettings,
                        icon: Icons.settings,
                        titleTextSize: 17.0,
                        trailingIcon: Icons.arrow_forward_ios,
                        onTap: () async {
                          await Future.delayed(
                            Duration(milliseconds: 1000),
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AdvancedSettingsPage();
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),

                      getProfileListTile(
                        titleText: R.strings.about,
                        icon: Icons.error_outline,
                        titleTextSize: 17.0,
                        onTap: () async {
                          await Future.delayed(
                            Duration(milliseconds: 1000),
                            () {
                              showDialog(
                                context: context,
                                builder: (context) => AboutDialog.adaptive(
                                  applicationName: R.strings.appName,
                                  applicationVersion: R.strings.version,
                                  applicationLegalese: R.strings.legalese,
                                ),
                              );
                            },
                          );
                        },
                      ),

                      getProfileListTile(
                        titleText: R.strings.logOut,
                        icon: Icons.logout_outlined,
                        leadingIconColor: R.colors.redColor,
                        titleTextColor: R.colors.redColor,
                        titleTextSize: 17.0,
                        onTap: () async {
                          await Future.delayed(
                            Duration(milliseconds: 1000),
                            () {
                              showDialog(
                                context: context,
                                builder: (context) => getListTileAlertDialog(
                                  content: Text(
                                    R.strings.doYouWantToLogOut,
                                    textScaler: TextScaler.linear(
                                      FetchPixels.getTextScale(),
                                    ),
                                    style: R.textStyle
                                        .boldRobotoDisplay()
                                        .copyWith(fontSize: 15.0),
                                  ),
                                  firstButton: containerButton(
                                    buttonText: R.strings.cancel,
                                    onTap: () async {
                                      await Future.delayed(
                                        Duration(milliseconds: 500),
                                        () {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    },
                                  ),

                                  lastButton: containerButton(
                                    buttonText: R.strings.logOut,
                                    onTap: () async {
                                      dataProvider.resetData();
                                      dataProvider.accountLogIn = false;
                                      dataProvider.uploadDataToHive();
                                      await Future.delayed(
                                        Duration(milliseconds: 500),
                                        () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return Opener();
                                              },
                                            ),
                                            (Route<dynamic> route) => false,
                                          );
                                        },
                                      );
                                    },
                                    buttonTextColor: R.colors.redColor,
                                  ),
                                ),
                              );
                            },
                          );
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
    );
  }
}
