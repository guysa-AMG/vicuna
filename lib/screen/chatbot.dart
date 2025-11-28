import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatBotScreen extends StatefulWidget{

    @override
    State<ChatBotScreen> createState()=>ChatBotStateScreen();
}

class ChatBotStateScreen extends State<ChatBotScreen>{
    final _chatController = InMemoryChatController();
    @override
    Widget build(BuildContext ctx){
        return Scaffold(
            body:Chat(
              currentUserId: "user1",
              
               resolveUser: (UserID id)async{
                return User(id: id,
               createdAt:
                )
               },
                chatController: _chatController)
        );
    }
}