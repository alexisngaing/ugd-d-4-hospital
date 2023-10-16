import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:ugd_4_hospital/component/pesan.dart';
import 'package:intl/intl.dart';
import 'package:ugd_4_hospital/View/home.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [
    Message(
      text: 'Yes Sure!',
      date: DateTime.now().subtract(
          Duration(minutes: 5)), // Pesan pertama dikirim 5 menit yang lalu
      isSentByMe: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Dokter'),
        backgroundColor: Colors.green,
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
              padding: const EdgeInsets.all(8),
              reverse: true,
              order: GroupedListOrder.DESC,
              elements: messages,
              groupBy: (Message message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (Message message) => SizedBox(
                height: 40,
                child: Center(
                  child: Card(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        DateFormat.yMMMd().format(message.date),
                        style: const TextStyle(color: Colors.white),
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
        elevation: 8,
        color: isSentByMe ? Colors.green : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: isSentByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
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
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
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
              width: 40,
              height: 40,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                radius: 70,
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
