import 'package:aus_dauer/pages/freelance.dart';
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

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<Map<String, dynamic>> orders = [
    {"buyer": "Rita Arnold", "nama": "Cookies"},
    {"buyer": "Rita Arnold", "nama": "Cookies"},
    {"buyer": "Rita Arnold", "nama": "Cookies"},
    {"buyer": "Rita Arnold", "nama": "Cookies"},
    {"buyer": "Rita Arnold", "nama": "Cookies"},
    {"buyer": "Rita Arnold", "nama": "Cookies"},
    {"buyer": "Rita Arnold", "nama": "Cookies"},
  ];

  @override
  Widget build(BuildContext context) {
    List<int> totalPriceList = [];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(""),
          leading: Builder(
            builder: (context) => IconButton(
              padding: EdgeInsets.symmetric(horizontal: 20),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
              icon: const Icon(
                Icons.menu,
                size: 30,
              ),
            ),
          ),
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "History",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                            ),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: orders.map((data) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.7,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                5.5,
                                        child: Image.asset(
                                          'assets/images/discover_blue.png',
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                5.5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${data['buyer']}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 12.0,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "x4",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 12.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    "${data['buyer']}",
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                ]),
                                            Text(
                                              "14-01-2023",
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.0,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.width / 5.5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$20",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HistoryDetailPage(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xFF072389)),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Text(
                                                'Details',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF072389),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            PreferredSize(
                              preferredSize: Size.fromHeight(
                                  1.0), // Adjust the height as needed
                              child: Container(
                                height: 1.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/discover.png',
                      width: MediaQuery.of(context).size.width / 11,
                    ),
                    title: const Text("Discover"),
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
