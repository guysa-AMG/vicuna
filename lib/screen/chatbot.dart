import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:vicuna/services/repository/localpref.dart';
import 'package:vicuna/widgets/appabar.dart';

class ChatBotScreen extends StatefulWidget {
  final String? InitialMessage;
  const ChatBotScreen({super.key ,this.InitialMessage});
  @override
  State<ChatBotScreen> createState() => ChatBotStateScreen();
}

class ChatBotStateScreen extends State<ChatBotScreen> {
  final _chatController = InMemoryChatController();
  String targetLanguage = "English";
  @override
  void initState() {
    super.initState();
    targetLanguage = RepositoryProvider.of<LocalInstance>(context).Language;
    if (super.widget.InitialMessage != null) {
      //message on initial message routed from home screen.

      TextMessage tm = TextMessage(
        id: "${Random().nextInt(100) + 1}",
        authorId: "user1",
        text: super.widget.InitialMessage ?? "",
        createdAt: DateTime.now(),
      );

      _chatController.insertMessage(tm);
      respond(tm.text);
    }
  }

  respond(message) async {
    Candidates? can = await Gemini.instance.chat(
      [
        ...[
          Content(
            parts: [
              ...[Part.text(message)],
            ],
          ),
        ],
      ],
      systemPrompt:
          '''
   1. you are a medical note explainer named Vicuna
   2. you help patients find health information and do not engage in unrelated topics 
   3. only respond if you are 89% sure or state you are not sure
   4.  it short simple,
   5. communicate in $targetLanguage
   ''',
    );
    // Candidates? can= await Gemini.instance.prompt(parts: [Part.text(message)]);
    _chatController.insertMessage(
      TextMessage(
        id: "${Random().nextInt(100) + 1}",
        authorId: "robot",
        text: can?.output ?? "?.",
        replyToMessageId: _chatController.messages.last.id,
      ),
    );
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: EpAppBar(title: "Vicuna AI"),
      body: Chat(
        currentUserId: "user1",
        theme: ChatTheme(
          colors: Theme.brightnessOf(context) == Brightness.dark
              ? ChatColors.dark()
              : ChatColors.light(),
          typography: ChatTypography.fromThemeData(Theme.of(context)),
          shape: BorderRadiusGeometry.circular(5),
        ),
        onMessageSend: (text) {
          _chatController.insertMessage(
            TextMessage(
              id: "${Random().nextInt(100) + 1}",
              authorId: "user1",
              text: text,
              createdAt: DateTime.now(),
            ),
          );
          respond(text);
        },

        onAttachmentTap: () async {
          await FilePickerIO().pickFiles(
            type: FileType.custom,
            allowedExtensions: ["jpg", "pdf", "png", "webp"],
          );
        },
        resolveUser: (UserID id) async {
          return User(id: id, name: "john", createdAt: DateTime.now());
        },
        chatController: _chatController,
      ),
    );
  }
}
