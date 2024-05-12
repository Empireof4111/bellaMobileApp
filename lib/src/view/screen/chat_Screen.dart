// ignore_for_file: file_names

import 'package:bella_banga/core/app_color.dart';
import 'package:bella_banga/src/model/chat_model.dart';
import 'package:bella_banga/src/view/widget/global_members.dart';
import 'package:bella_banga/src/view/widget/receiver_row_view.dart';
import 'package:bella_banga/src/view/widget/sender_row_view.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat-screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var controller = TextEditingController();
  var scrollController = ScrollController();
  var message = '';

  void animateList() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.offset !=
          scrollController.position.maxScrollExtent) {
        animateList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F3),
      appBar: AppBar(
        foregroundColor: Colors.white,
        elevation: 12,
        titleSpacing: 10,
        backgroundColor: AppColor.lightOrange,
        // leading: const Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: Icon(
        //     Icons.arrow_back_ios_sharp,
        //     color: Colors.white,
        //   ),
        // ),
        leadingWidth: 20,
        title: const ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile_pic.png"),
          ),
          title: Text(
            'Belle Store',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'online',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: chatModelList.length,
                itemBuilder: (context, index) =>
                    chatModelList.elementAt(index).isMee
                        ? SenderRowView(
                            index: index,
                          )
                        : ReceiverRowView(index: index),
              )),
          Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 12.0, left: 8),
                  child: Icon(
                    Icons.emoji_emotions_outlined,
                    color: AppColor.darkOrange,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    maxLines: 6,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    controller: controller,
                    onFieldSubmitted: (value) {
                      controller.text = value;
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8),
                      border: InputBorder.none,
                      focusColor: Colors.white,
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12, right: 10),
                  child: Transform.rotate(
                    angle: 45,
                    child: const Icon(
                      Icons.attachment_outlined,
                      color: AppColor.darkOrange,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      chatModelList.add(ChatModel(controller.text, true));
                      animateList();
                      controller.clear();
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      chatModelList.add(ChatModel(controller.text, false));
                      animateList();
                      controller.clear();
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 8, right: 8),
                    child: CircleAvatar(
                      backgroundColor: AppColor.darkOrange,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
