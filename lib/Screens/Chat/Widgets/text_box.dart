import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../../Base/Resizer/fetch_pixels.dart";
import "../../../Provider/data_provider.dart";
import "../../../Resources/resources.dart";

class MyTextBox extends StatefulWidget {
  static FocusNode textBoxFocusNode = FocusNode();

  const MyTextBox({super.key});

  static void disposeTextBoxFocusNode() {
    textBoxFocusNode.dispose();
  }

  @override
  State<MyTextBox> createState() => _MyTextBoxState();
}

class _MyTextBoxState extends State<MyTextBox> {
  final TextEditingController _myController = TextEditingController();

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<DataProvider>();
    return Padding(
      padding: EdgeInsets.only(
        top: FetchPixels.getPixelHeight(5.0),
        bottom: FetchPixels.getPixelHeight(30.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: FetchPixels.getPixelHeight(2.0),
          horizontal: FetchPixels.getPixelWidth(5.0),
        ),
        alignment: Alignment.bottomCenter,
        width: FetchPixels.getWidthPercentSize(90),
        decoration: BoxDecoration(
          color: R.colors.blackColor,
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12.0)),
          border: Border.all(color: R.colors.whiteColor, width: 1.0),
        ),
        child: TextField(
          focusNode: MyTextBox.textBoxFocusNode,
          maxLines: 4,
          minLines: 1,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          controller: _myController,
          style: R.textStyle.regularRobotoDisplay().copyWith(fontSize: 16.0),
          cursorHeight: 23,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 12),
            prefixIconConstraints: BoxConstraints(
              maxWidth: FetchPixels.getPixelWidth(40.0),
              minWidth: FetchPixels.getPixelWidth(40.0),
            ),
            prefixIcon: Icon(Icons.search, size: 25),
            suffixIconConstraints: BoxConstraints(
              maxWidth: FetchPixels.getPixelWidth(40.0),
              minWidth: FetchPixels.getPixelWidth(40.0),
            ),
            suffixIcon: Selector<DataProvider, bool>(
              selector: (context, dataProvider) => dataProvider.stillAnswering,
              builder: (context, value, child) {
                return IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      (value) ? R.colors.pinPutFillColor : R.colors.transparent,
                    ),
                  ),
                  onPressed: (value)
                      ? null
                      : () {
                          if (_myController.text.trim().isNotEmpty) {
                            if (dataProvider.chatStart == false) {
                              dataProvider.changeChatCondition();
                            }
                            dataProvider.keyboardClose();
                            dataProvider.addQuestion(_myController.text.trim());
                            _myController.clear();
                            if (dataProvider.currentChatMap.length == 3) {
                              dataProvider.addChatInChatList();
                            }
                            dataProvider.update();
                            dataProvider.getAnswer();
                          }
                        },
                  icon: (value)
                      ? Icon(Icons.square, size: 18.0)
                      : Icon(Icons.send, size: 22),
                  highlightColor: R.colors.lightGreyColor,
                );
              },
            ),
            border: InputBorder.none,
            hintText: R.strings.chatBoxText,
            hintStyle: R.textStyle.regularRobotoDisplay().copyWith(
              color: R.colors.greyColor,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
