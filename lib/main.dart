 import 'package:flutter/material.dart';
import 'package:messenger/app.dart';
import 'package:messenger/screens/home_screen.dart';
import 'package:messenger/screens/select_user_screen.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';



void main()async {
  final client = StreamChatClient(streamKey);
  runApp( MyApp(
    client: client,
  ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.client})
      : super(key: key);

  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatter',
      builder: (context, child){
        return StreamChatCore(
          client: client,
            child: child!);
      },
      theme: ThemeData(
        primaryColor: Colors.lightBlue,

      ),
      themeMode: ThemeMode.dark,
      home:const SelectUserScreen(),
    );
  }
}


