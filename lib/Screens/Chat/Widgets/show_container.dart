import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:think_bot/Provider/data_provider.dart";
import "package:think_bot/Screens/Chat/Widgets/text_box.dart";

import "../../../Base/Resizer/fetch_pixels.dart";
import "../../../Resources/resources.dart";

class ShowContainer extends StatelessWidget {
  final Map chat;
  final int index;
  final Widget child;

  const ShowContainer({
    super.key,
    required this.chat,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<DataProvider>();
    return Container(
      constraints:
      (index == dataProvider.currentChatMap.length - 1 &&
          dataProvider.allowSpace)
          ? BoxConstraints(minHeight: FetchPixels.getPixelHeight(530))
          : null,
      alignment: chat["role"] == "user"
          ? Alignment.topRight
          : Alignment.topLeft,
      child: GestureDetector(
        onTapDown: (details) {
          if (dataProvider.stillAnswering &&
              dataProvider.showAnswer.isNotEmpty &&
              dataProvider.allowJump) {
            dataProvider.allowJump = false;
          }
        },
        onLongPressEnd: (details) async {
          final position = details.globalPosition;
          await showMenu(
            color: R.colors.lightGreyColor,
            position: RelativeRect.fromLTRB(
              position.dx,
              position.dy,
              position.dx + 1,
              position.dy + 1,
            ),
            context: context,
            items: [
              PopupMenuItem(
                height: FetchPixels.getPixelHeight(30),
                onTap: () {
                  dataProvider.copyTextToClipboard(chat["content"]);
                },
                child: RichText(
                  textScaler: TextScaler.linear(FetchPixels.getTextScale()),
                  text: TextSpan(
                    children: [
                      TextSpan(text: "      "),
                      WidgetSpan(child: Icon(Icons.copy, size: 17)),
                      TextSpan(text: "   "),
                      TextSpan(
                        text: R.strings.copyText,
                        style: R.textStyle.boldRobotoDisplay().copyWith(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
          MyTextBox.textBoxFocusNode.unfocus();
          dataProvider.allowJump = true;
        },
        child: Container(
          padding: EdgeInsets.all(FetchPixels.getPixelHeight(10.0)),
          margin: EdgeInsets.symmetric(
            vertical: FetchPixels.getPixelHeight(20.0),
          ),
          constraints: BoxConstraints(
            minWidth: 0.0,
            maxWidth: ((chat["role"] == "user")
                ? FetchPixels.getWidthPercentSize(70)
                : FetchPixels.getWidthPercentSize(100)),
          ),
          decoration: BoxDecoration(
            color: (chat["role"] == "user")
                ? R.colors.userTextContainerColor
                : R.colors.transparent,
            borderRadius: BorderRadius.circular(
              FetchPixels.getPixelHeight(10.0),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
