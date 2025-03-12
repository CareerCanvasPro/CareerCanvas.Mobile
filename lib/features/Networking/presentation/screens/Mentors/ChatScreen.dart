import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "/ChatScreen";

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [
    {'sender': 'other', 'text': 'Hello sir, Good Morning'},
    {'sender': 'self', 'text': 'Morning, Can I help you?'},
    {
      'sender': 'other',
      'text':
          'I saw the UI/UX Designer vacancy that you uploaded on LinkedIn yesterday and I am interested in joining your company.'
    },
    {'sender': 'self', 'text': 'Oh yes, please send your CV/Resume here'},
    {'sender': 'other', 'text': 'Jamet - CV - UI/UX Designer.PDF'},
  ];

  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({'sender': 'self', 'text': text});
      });
      _messageController.clear();
    }
  }

  Future<void> _handleFileUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String fileName = result.files.single.name;
      setState(() {
        _messages.add({'sender': 'self', 'text': 'Uploaded file: $fileName'});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String name = arguments['name'];
    final String imageUrl = arguments['imageUrl'];
    final String status = arguments['status'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imageUrl),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      color: status == 'Online' ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.blue),
            onPressed: () {
              // Additional options
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          final isSelf = message['sender'] == 'self';
          final bubbleColor = isSelf
              ? (theme.brightness == Brightness.dark
                  ? Colors.blue[700]
                  : Colors.blue[100])
              : (theme.brightness == Brightness.dark
                  ? Colors.grey[800]
                  : Colors.grey[200]);
          final textColor = isSelf
              ? (theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black)
              : (theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Align(
              alignment: isSelf ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bubbleColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  message['text']!,
                  style: TextStyle(fontSize: 14, color: textColor),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file, color: Colors.blue),
              onPressed: _handleFileUpload,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Write your message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blue),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
