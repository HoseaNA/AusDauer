import 'package:aus_dauer/pages/chat_service.dart';
import 'package:aus_dauer/pages/freelance.dart';
import 'package:aus_dauer/pages/history.dart';
import 'package:aus_dauer/pages/history_detail.dart';
import 'package:aus_dauer/pages/order_info.dart';
import 'package:aus_dauer/pages/orders_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './add_product.dart';
import './marketplace.dart';
import './landing_page.dart';
import './edit_product.dart';
import './manage_product.dart';
import './order_info.dart';
import './chats.dart';

class ChatRoomPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatRoomPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final List<Map<String, dynamic>> chat = [
    {"senderId": 1, "message": "p"},
    {"senderId": 1, "message": "apa kabar"},
    {"senderId": 2, "message": "baik, lu gimans"},
    {"senderId": 1, "message": "aman fren"},
    {
      "senderId": 2,
      "message":
          "asdasdsauidgausdgasyudgyuascgndasuygbcdbyasngcdsyagucbdtsyacbfdiuashdncasdcgnscdansiicydgasnda"
    },
  ];

  final _formKey = GlobalKey<FormState>();
  String? _message;

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    // only send message if there is something to send
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      // clear the text controller after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(""),
          leadingWidth: MediaQuery.of(context).size.width / 1.5,
          leading: Row(children: [
            SizedBox(width: 15),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                'assets/icons/arrow_back.png',
                width: MediaQuery.of(context).size.width / 11,
              ),
            ),
            SizedBox(width: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(50.0),
              ),
              width: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.width / 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.asset(
                  'assets/images/discover_blue.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 15),
            Text(
              'Rita Arnold',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
              ),
            ),
          ]),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0), // Adjust the height as needed
            child: Container(
              height: 1.0,
              color: Colors.black,
            ),
          ),
        ),
        drawer: const NavigationDrawer(),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.blue.shade100,
            labelTextStyle: MaterialStateProperty.all(
              TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          child: NavigationBar(
            height: 60,
            selectedIndex: 0,
            destinations: [
              InkWell(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        size: 30,
                        color: Color(0xFF9F948B),
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                          color: Color(0xFF9F948B),
                          fontWeight: FontWeight.w700,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManageProductPage(),
                    ),
                  );
                },
              ),
              InkWell(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 30,
                        color: Color(0xFF607274),
                      ),
                      Text(
                        "Marketplace",
                        style: TextStyle(
                          color: Color(0xFF607274),
                          fontWeight: FontWeight.w700,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MarketplacePage(),
                    ),
                  );
                },
              ),
              InkWell(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.work_outline_outlined,
                        size: 30,
                        color: Color(0xFF9F948B),
                      ),
                      Text(
                        "Freelance",
                        style: TextStyle(
                          color: Color(0xFF9F948B),
                          fontWeight: FontWeight.w700,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FreelancePage(),
                    ),
                  );
                },
              ),
              InkWell(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_2_outlined,
                        size: 30,
                        color: Color(0xFF9F948B),
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                          color: Color(0xFF9F948B),
                          fontWeight: FontWeight.w700,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManageProductPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context)
                    .size
                    .height, // Set the minimum height you desire
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                  child: Column(
                    children: chat.map((data) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        alignment: (data['senderId'] == 1
                            ? Alignment.centerRight
                            : Alignment.centerLeft),
                        child: Row(
                          mainAxisAlignment: (data['senderId'] == 1
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start),
                          children: [
                            (data['senderId'] == 1)
                                ? SizedBox.shrink()
                                : Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width / 8,
                                    height:
                                        MediaQuery.of(context).size.width / 8,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.asset(
                                        'assets/images/discover_blue.png',
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                            (data['senderId'] == 1)
                                ? SizedBox.shrink()
                                : SizedBox(width: 10),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width / 1.5,
                                // Set the minimum height you desire
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5.0),
                                color: (data['senderId'] == 1
                                    ? Colors.grey.withOpacity(0.2)
                                    : Colors.white),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  data['message'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 1.4,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 1.5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey.withOpacity(0.2)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 14,
                            height: MediaQuery.of(context).size.width / 14,
                            child: Image.asset(
                              'assets/icons/attach.png',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: TextFormField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              hintText: "Enter your message",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0.0),
                              // Added a circular border to make it neater
                            ),
                            // Added behavior when name is typed
                            onChanged: (String? value) {
                              setState(() {
                                _message = value!;
                              });
                            },
                            // Added behavior when data is saved
                            onSaved: (String? value) {
                              setState(() {
                                _message = value!;
                              });
                            },
                            // Validator as form validation
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Mohon isi message!';
                              }
                              return null;
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width / 15,
                            height: MediaQuery.of(context).size.width / 15,
                            child: Image.asset(
                              'assets/icons/sendchat.png',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: Wrap(
                runSpacing: 16,
                children: [
                  ListTile(
                    title: const Text(
                      "ausdauer",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.w400,
                        fontSize: 30.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LandingPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/discover.png',
                      width: MediaQuery.of(context).size.width / 11,
                    ),
                    title: const Text("Discover"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/history.png',
                      width: MediaQuery.of(context).size.width / 11,
                    ),
                    title: const Text("History"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoryPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/chat.png',
                      width: MediaQuery.of(context).size.width / 11,
                    ),
                    title: const Text("Chats"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatsPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/products.png',
                      width: MediaQuery.of(context).size.width / 11,
                    ),
                    title: const Text("Your Products"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ManageProductPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/clipboard.png',
                      width: MediaQuery.of(context).size.width / 11,
                    ),
                    title: const Text("Orders"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrdersPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
}
