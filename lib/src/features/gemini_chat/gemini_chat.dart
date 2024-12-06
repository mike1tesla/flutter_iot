import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../models/message.dart';

class GeminiChat extends StatefulWidget {
  static const String route = "GeminiChat";

  const GeminiChat({super.key});

  @override
  State<GeminiChat> createState() => _GeminiChatState();
}

class _GeminiChatState extends State<GeminiChat> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  bool isSending = false; // Trạng thái kiểm tra khi đang gửi dữ liệu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: buildChatBox(),
            ),
            buildInputValue()
          ],
        ),
      ),
    );
  }

  callGeminiModel() async {
    if (isSending || _controller.text.isEmpty) return; // Ngăn gửi nếu đang xử lý hoặc prompt trống
    setState(() {
      isSending = true;
      _messages.add(Message(value: _controller.text, isUser: true)); // Thêm prompt người dùng vào danh sách
    });
    try {
      final model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: dotenv.env['GOOGLE_API_KEY'].toString(),
      );
      final prompt = _controller.text.trim();
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      setState(() {
        _messages.add(Message(value: response.text!.trim(), isUser: false)); // Thêm phản hồi từ API
        isSending = false;
        _controller.clear(); // Xóa nội dung nhập liệu
      });
    } catch (e) {
      print("ERROR: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("hello")),
              );
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              spreadRadius: 3,
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Write your message",
                    hintStyle: TextStyle(color: Colors.grey[300])),
              ),
            ),
            isSending
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 20,
                    height: 20,
                    child: const CircularProgressIndicator(color: Colors.green),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: callGeminiModel,
                      child: const Icon(Icons.send, color: Colors.green),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildChatBox() {
    return ListView.builder(
      reverse: true, // Hiển thị tin nhắn mới nhất ở cuối
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[_messages.length - index - 1]; // build tin nhan ở cuoi
        final isUser = message.isUser;
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
                message.value,
                style: TextStyle(color: isUser ? Colors.white : Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }
}
