import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/message.dart';

class GeminiChat extends StatefulWidget {
  static const String route = "GeminiChat";

  const GeminiChat({super.key});

  @override
  State<GeminiChat> createState() => _GeminiChatState();
}

class _GeminiChatState extends State<GeminiChat> {
  final List<Message> _messages = [
    Message(value: "Hi", isUser: true),
    Message(value: 'Hello! Can I help you?', isUser: false),
    Message(value: 'What day is today?', isUser: true),
    Message(value: '06/12/2024', isUser: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: buildChatBox(),
          ),
          buildInputValue()
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      shadowColor: Colors.grey,
      elevation: 1,
      leadingWidth: 70,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          "assets/img/chatbox_icon.png",
          color: Colors.green,
          fit: BoxFit.contain,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Gemini Chatbox',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Container(
                      width: 6,
                      height: 6,
                      decoration: const ShapeDecoration(color: Color(0xFF3ABF37), shape: OvalBorder())),
                  const SizedBox(width: 5),
                  const Text('Online',
                      style: TextStyle(fontSize: 17, color: Color(0xFF3ABF37), fontWeight: FontWeight.w500)),
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("hello")));
            },
            child: const Icon(Icons.info, color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget buildInputValue() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32), boxShadow: [
          BoxShadow(spreadRadius: 3, color: Colors.grey.withOpacity(0.5), blurRadius: 7, offset: const Offset(0, 3))
        ]),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Write your message",
                    hintStyle: TextStyle(color: Colors.grey[300])),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.send,
              color: Colors.green,
            ),
            const SizedBox(
              width: 8,
            )
          ],
        ),
      ),
    );
  }

  Widget buildChatBox() {
    return ListView.builder(
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final isUser = _messages[index].isUser;
        return ListTile(
          title: Align(
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isUser ? Colors.green : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(20),
                  bottomRight: const Radius.circular(20),
                  topLeft: isUser ? const Radius.circular(20) : Radius.zero,
                  topRight: isUser ? Radius.zero : const Radius.circular(20),
                ),
              ),
              child: Text(
                _messages[index].value,
                style: TextStyle(color: isUser ? Colors.white : Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }
}
