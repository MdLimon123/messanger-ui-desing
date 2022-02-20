import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/models/models.dart';
import 'package:messenger/widgets/avatar.dart';
import 'package:messenger/widgets/glowing_action_button.dart';
import 'package:messenger/widgets/icon_button.dart';

class ChatScreen extends StatelessWidget {
  static Route route(MessageData data) => MaterialPageRoute(
      builder: (context) => ChatScreen(
            messageData: data,
          ));

  const ChatScreen({Key? key, required this.messageData}) : super(key: key);

  final MessageData messageData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
              icon: CupertinoIcons.back,
              onTap: () {
                Navigator.of(context).pop();
              }),
        ),
        title: _AppBarTitle(
          messageData: messageData,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: IconBorder(
                icon: CupertinoIcons.video_camera_solid,
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: IconBorder(
                icon: CupertinoIcons.phone_solid,
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
              child: DemoMessageList()),
          _ActionBar(),
        ],
      ),
    );
  }
}

class DemoMessageList extends StatelessWidget {
  const DemoMessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: const [
          _DateLable(lable: 'Yesterday'),
          _MessageTitle(
              message: 'Hi, Lucy! How\'s your day going',
              messageData: '12:02 PM'),
          _MessageOwnTitle(
              message: 'You Know how it goes', messageData: '12:02 PM'),
          _MessageTitle(
              message: 'Do you want Starbucks', messageData: '12:02 PM'),
          _MessageOwnTitle(
              message: 'Would be awesome!', messageData: '12:03 PM'),
          _MessageTitle(message: 'Coming Up!', messageData: '12:02 PM'),
          _MessageOwnTitle(message: 'YAY!!', messageData: '12:02'),
        ],
      ),
    );
  }
}

class _MessageTitle extends StatelessWidget {
  const _MessageTitle(
      {Key? key, required this.message, required this.messageData})
      : super(key: key);

  final String message;
  final String messageData;
  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF3B76F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message),
              ),
            ),
            Text(
              messageData,
              style: TextStyle(
                  color: Color(0xFF9899A5),
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class _MessageOwnTitle extends StatelessWidget {
  const _MessageOwnTitle(
      {Key? key, required this.message, required this.messageData})
      : super(key: key);

  final String message;
  final String messageData;
  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF3B76F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(
                  message,
                  style: const TextStyle(color: Color(0xFFF5F5F5)),
                ),
              ),
            ),
            Text(
              messageData,
              style: TextStyle(
                  color: Color(0xFF9899A5),
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class _DateLable extends StatelessWidget {
  const _DateLable({Key? key, required this.lable}) : super(key: key);
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              lable,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9899A5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({Key? key, required this.messageData}) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar.small(url: messageData.profilePicture, onTab: () {  },),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                messageData.senderName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                'Online now',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              )
            ],
          ),
        )
      ],
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: true,
        top: false,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(
                width: 2,
                color: Theme.of(context).dividerColor,
              ))),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(
                  CupertinoIcons.camera_fill,
                ),
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: TextField(
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                      hintText: 'Type something.....', border: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 24.0),
              child: GlowingActionButton(
                color: Color(0xFFD6755B),
                icon: Icons.send_rounded,
                onPressed: () {
                  print('TODO: send a message');
                },
              ),
            )
          ],
        ));
  }
}
