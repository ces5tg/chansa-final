import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chansa_app/consts.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 5),
    ),
    enableLog: true,
  );

  final ChatUser _user = ChatUser(
    id: '1',
    firstName: 'Charles',
    lastName: 'Leclerc',
  );

  final ChatUser _gptChatUser = ChatUser(
    id: '2',
    firstName: 'Chansa',
    lastName: '',
  );

  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 217, 0, 1),
        title: const Text(
          'Chatea con Chansa 😀',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: DashChat(
        currentUser: _user,
        messageOptions: const MessageOptions(
          currentUserContainerColor: Colors.black,
          containerColor: Color.fromRGBO(255, 217, 0, 1),
          textColor: Colors.white,
        ),
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        messages: _messages,
        typingUsers: _typingUsers,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    print('Sending message to ChatGPT: ${m.text}');
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });

    // Create messages history
    List<Messages> messagesHistory = _messages.reversed.toList().map((m) {
      if (m.user == _user) {
        return Messages(
          role: Role.user,
          content: m.text,
        );
      } else {
        return Messages(
          role: Role.assistant,
          content: m.text,
        );
      }
    }).toList();

    final request = ChatCompleteText(
      messages: messagesHistory,
      maxToken: 200,
      model: GptTurbo0301ChatModel(),
    );

    final response = await _openAI.onChatCompletion(request: request);
    if (response != null) {
      for (var element in response.choices) {
        if (element.message != null) {
          print('Received response from ChatGPT: ${element.message!.content}');
          setState(() {
            _messages.insert(
              0,
              ChatMessage(
                user: _gptChatUser,
                createdAt: DateTime.now(),
                text: element.message!.content,
              ),
            );
          });
        }
      }
    } else {
      print('Error: No response received from ChatGPT');
    }

    setState(() {
      _typingUsers.remove(_gptChatUser);
    });
  }
}
