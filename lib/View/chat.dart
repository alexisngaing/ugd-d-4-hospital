import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:ugd_4_hospital/component/pesan.dart';
import 'package:ugd_4_hospital/View/home.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [
    Message(
      text: 'Yes Sure!',
      date: DateTime.now().subtract(Duration(minutes: 5)),
      isSentByMe: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Dokter'),
        backgroundColor: const Color(0xff15C73C),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
              padding: EdgeInsets.all(8.sp),
              reverse: true,
              order: GroupedListOrder.DESC,
              elements: messages,
              groupBy: (Message message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (Message message) => SizedBox(
                height: 40.sp,
                child: Center(
                  child: Card(
                    color: const Color(0xff15C73C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.sp),
                      child: Text(
                        DateFormat.yMMMd().format(message.date),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, Message message) =>
                  MessageBubble(message: message),
            ),
          ),
          NewMessageWidget(
            onSubmitted: (text) {
              final message =
                  Message(text: text, date: DateTime.now(), isSentByMe: true);
              setState(() {
                messages.add(message);

                Future.delayed(Duration(seconds: 10), () {
                  final responseMessage = Message(
                      text: 'Bagus Sekali!',
                      date: DateTime.now(),
                      isSentByMe: false);
                  setState(() {
                    messages.add(responseMessage);
                  });
                });
              });
            },
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isSentByMe;

  MessageBubble({required this.message}) : isSentByMe = message.isSentByMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        elevation: 8.sp, // Use sp (responsive size) here
        color: isSentByMe ? const Color(0xff15C73C) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.sp), // Use sp (responsive size) here
            topRight: Radius.circular(16.sp), // Use sp (responsive size) here
            bottomLeft: isSentByMe
                ? Radius.circular(16.sp) // Use sp (responsive size) here
                : Radius.zero,
            bottomRight: isSentByMe
                ? Radius.zero
                : Radius.circular(16.sp), // Use sp (responsive size) here
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.sp), // Use sp (responsive size) here
          child: Text(
            message.text,
            style: TextStyle(
              color: isSentByMe ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class NewMessageWidget extends StatefulWidget {
  final Function(String) onSubmitted;

  NewMessageWidget({required this.onSubmitted});

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 4),
                    blurRadius: 6.sp,
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12.sp),
                  hintText: 'Masukkan Pesan Anda',
                  border: InputBorder.none,
                ),
                onSubmitted: (text) {
                  widget.onSubmitted(text);
                  _controller.clear();
                },
              ),
            ),
          ),
          IconButton(
            icon: Container(
              width: 40.sp,
              height: 40.sp,
              child: CircleAvatar(
                backgroundColor: const Color(0xff15C73C),
                radius: 70.sp,
                child: Icon(Icons.send, color: Colors.white),
              ),
            ),
            onPressed: () {
              widget.onSubmitted(_controller.text);
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
