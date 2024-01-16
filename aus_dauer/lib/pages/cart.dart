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

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              'assets/icons/arrow_back.png',
              width: MediaQuery.of(context).size.width / 11,
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
                            "Your Cart",
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
                                                  const MarketplacePage(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            border:
                                                Border.all(color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(3),
                                              child: Text(
                                                'Remove',
                                                style: TextStyle(
                                                  color: Colors.white,
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
