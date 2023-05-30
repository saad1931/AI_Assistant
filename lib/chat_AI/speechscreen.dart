// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:personalassistant/chat_AI/api_services.dart';
import 'package:personalassistant/chat_AI/chat_model.dart';
import 'package:personalassistant/chat_AI/ts.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final List<ChatMessage> messages = [];
  TextEditingController textFieldController = TextEditingController();
  bool isTyping = false;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          "AI Assistant",
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffFEFDFC)),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color:  const Color(0xff343541),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    var chat = messages[index];
                    return chatBubble(chattext: chat.text, type: chat.type);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color:  const Color(0xff343541),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: textFieldController,
                        decoration: const InputDecoration(
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            isTyping = value.isNotEmpty;
                          });
                        },
                        onSubmitted: (value) async {
                          await sendMessage();
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: isTyping
                        ? () async {
                      await sendMessage();
                    }
                        : null,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> sendMessage() async {
    var value = textFieldController.text.trim();
    if (value.isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(
          text: value,
          type: ChatMessageType.user,
        ));
      });
      var msg = await ApiServices.sendMessage(value);
      msg = msg?.trim() ?? '';
      setState(() {
        messages.add(ChatMessage(
          text: msg,
          type: ChatMessageType.bot,
        ));
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        TextToSpeech.speak(msg);
      });
      textFieldController.clear();
      scrollMethod();
    }
  }

  void scrollMethod() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Widget chatBubble({required chattext, required ChatMessageType? type}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.green,
          child: type == ChatMessageType.bot
              ? const Icon(
            Icons.android,
            color: Colors.white,
          )
              : const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: type == ChatMessageType.bot ? Colors.green : Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Text(
              "$chattext",
              style: TextStyle(
                color: type == ChatMessageType.bot ? const Color(0xffFEFDFC) : const Color(0xff343541),
                fontSize: 15,
                fontWeight: type == ChatMessageType.bot ? FontWeight.w400 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
