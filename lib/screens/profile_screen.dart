import 'package:flutter/material.dart';
import 'package:messenger/app.dart';
import 'package:messenger/widgets/avatar.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:messenger/widgets/icon_button.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ProfileScreen extends StatelessWidget {
  static Route get route => MaterialPageRoute(builder: (context) =>const ProfileScreen());
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: Center(
          child: IconBackground(
            icon: Icons.arrow_back_ios,
            onTap: (){
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Hero(tag: 'hero, profile picture',
                child: Avatar.large(url: user?.image, onTab: () {},
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(user?.name ?? 'No name'),
            ),
           const Divider(),

          ],
        ),
      ),
    );
  }
}

class _SignOutButton extends StatefulWidget {
  const _SignOutButton({Key? key}) : super(key: key);

  @override
  _SignOutButtonState createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<_SignOutButton> {
  bool _loading = false;

  Future<void> _signOut() async{
    setState(() {
      _loading = true;
    });

    try{
      await StreamChatCore.of(context).client.disconnectUser();
      await firebase.FirebaseAuth.instance.signOut();


    }on Exception catch(e,st){
      logger.e('Could not sign out', e, st);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
    ? const CircularProgressIndicator()
    : TextButton(onPressed: _signOut, 
        child:Text('Sign Out')
    );
  }
}

