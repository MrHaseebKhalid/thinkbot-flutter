import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:think_bot/Screens/Chat/Widgets/show_container.dart";
import "package:tuple/tuple.dart";

import "../../../Base/Resizer/fetch_pixels.dart";
import "../../../Base/Resizer/widget_utils.dart";
import "../../../Provider/data_provider.dart";
import "../../../Resources/resources.dart";

class ChatBox extends StatefulWidget {
  static final ScrollController myScrollController = ScrollController();

  const ChatBox({super.key});

  static void disposeScrollController() {
    myScrollController.dispose();
  }

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(
      begin: FetchPixels.getPixelHeight(0.8),
      end: FetchPixels.getPixelHeight(1.2),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<DataProvider, Tuple2<List<Map<String, dynamic>>, String>>(
      selector: (context, dataProvider) {
        return Tuple2(dataProvider.currentChatMap, dataProvider.showAnswer);
      },
      builder: (context, tuple, child) {
        final listChat = tuple.item1;
        final stringAnswer = tuple.item2;
        return ListView.builder(
          controller: ChatBox.myScrollController,
          itemCount: listChat.length,
          itemBuilder: (context, index) {
            if (index != 0 && index != (listChat.length - 1)) {
              var chat = listChat[index];
              Widget child = getGptMarkdown(chat["content"]);
              return ShowContainer(chat: chat, index: index, child: child);
            } else if (index != 0 && index == (listChat.length - 1)) {
              var chat = listChat[index];

              Widget child = (chat["role"] == "user")
                  ? getGptMarkdown(chat["content"])
                  : (chat["content"] == "")
                  ? ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        height: FetchPixels.getPixelHeight(17.0),
                        width: FetchPixels.getPixelWidth(17.0),
                        decoration: BoxDecoration(
                          color: R.colors.whiteColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : getGptMarkdown(
                      (stringAnswer != "") ? stringAnswer : chat["content"],
                    );

              return ShowContainer(chat: chat, index: index, child: child);
            } else {
              return const SizedBox(height: 0, width: 0);
            }
          },
        );
      },
    );
  }
}
