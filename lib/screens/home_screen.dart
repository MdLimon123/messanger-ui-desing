import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/app.dart';
import 'package:messenger/pages/calls_page.dart';
import 'package:messenger/pages/contact_page.dart';
import 'package:messenger/pages/messages_page.dart';
import 'package:messenger/pages/notification_page.dart';
import 'package:messenger/screens/profile_screen.dart';
import 'package:messenger/screens/screens.dart';
import 'package:messenger/widgets/glowing_action_button.dart';
import 'package:messenger/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  final pages = const [
    MessagePage(),
    NotificationPage(),
    CallsPage(),
    ContactPage()
  ];

  final pageTitles = const[
    'Messages',
    'Notification',
    'Calls',
    'Contact'
  ];

  void _onNavigationItemSelected(index){
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    pageIndex.addListener(() {
      print(pageIndex.value);
    });
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _){
            return  Center(
            child: Text(
            value,
            style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            );
          },

        ),
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: Icons.search,
            onTap: (){
              print("TODO Search ");
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Hero(
              tag: 'hero-profile-picture',
              child:Avatar.small(url: context.currentUserImage, onTab:(){
                Navigator.of(context).push(ProfileScreen.route);
              })
              ),
            ),

        ],
      ),

      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }

}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin:const EdgeInsets.all(0),
      child: SafeArea(
          top: false,
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 8,right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavigationBarItem(
                  index: 0,
                  label: 'Messages',
                  icon: CupertinoIcons.bubble_left_bubble_right_fill,
                  isSelected: (selectedIndex == 0),
                  onTap: handleItemSelected,
                ),
                _NavigationBarItem(
                  index: 1,
                  label: 'Notification',
                  icon: CupertinoIcons.bell_solid,
                  isSelected: (selectedIndex == 1),
                  onTap: handleItemSelected,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GlowingActionButton(color: Color(0xFF3B76F6), icon: CupertinoIcons.add,
                      onPressed: (){
                     print('TODO on new message');
                  }
                  ),
                ),
                _NavigationBarItem(
                    index: 2,
                    label: 'Calls',
                    icon: CupertinoIcons.phone_fill,
                    isSelected: (selectedIndex == 2),
                    onTap: handleItemSelected),
                _NavigationBarItem(
                  index: 3,
                  label: 'Contact',
                  icon: CupertinoIcons.person_2_fill,
                  isSelected: (selectedIndex == 3),
                  onTap: handleItemSelected,
                ),
              ],
            ),
          )),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem(
      {Key? key,
      required this.index,
      required this.label,
      required this.icon,
        this.isSelected = false,
      required this.onTap})
      : super(key: key);

  final int index;
  final String label;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 55,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected? Color(0xFF3B76F6) : null,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              label,
              style:isSelected?
              const TextStyle(fontSize: 11, color: Color(0xFF3B76F6),
                fontWeight: FontWeight.bold,
              )
              : TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
