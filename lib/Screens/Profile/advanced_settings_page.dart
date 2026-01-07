import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../Base/Resizer/fetch_pixels.dart";
import "../../Base/Resizer/widget_utils.dart";
import "../../Provider/data_provider.dart";
import "../../Resources/resources.dart";
import "../Opener/opener.dart";

class AdvancedSettingsPage extends StatelessWidget {
  const AdvancedSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<DataProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          R.strings.advancedSettings,
          textScaler: TextScaler.linear(FetchPixels.getTextScale()),
          style: R.textStyle.boldRobotoDisplay().copyWith(fontSize: 23),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Divider(thickness: 1.0),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: FetchPixels.getPixelHeight(10.0),
                horizontal: FetchPixels.getPixelWidth(10.0),
              ),
              child: getProfileListTile(
                titleText: R.strings.deleteAccount,
                icon: Icons.delete_outline,
                titleTextColor: R.colors.redColor,
                leadingIconColor: R.colors.redColor,
                titleTextSize: 17.0,
                onTap: () async {
                  await Future.delayed(Duration(milliseconds: 1000), () {
                    showDialog(
                      context: context,
                      builder: (context) => getListTileAlertDialog(
                        content: Text(
                          R.strings.doYouWantToDeleteAccount,
                          textScaler: TextScaler.linear(
                            FetchPixels.getTextScale(),
                          ),
                          style: R.textStyle.boldRobotoDisplay().copyWith(
                            fontSize: 15.0,
                          ),
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
                          buttonText: R.strings.delete,
                          onTap: () async {
                            dataProvider.accountLogIn = false;
                            dataProvider.resetData();
                            dataProvider.users.removeAt(
                              dataProvider.currentUserIndex,
                            );
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
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
