import 'package:aus_dauer/pages/history.dart';
import 'package:aus_dauer/pages/product_detail.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import './add_product.dart';
import './manage_product.dart';
import './landing_page.dart';
import './orders_page.dart';
import './chats.dart';
import './marketplace.dart';

class FreelancePage extends StatefulWidget {
  const FreelancePage({Key? key}) : super(key: key);

  @override
  State<FreelancePage> createState() => _FreelancePageState();
}

class Freelance {
  final String job;
  final String description;
  final double price;
  final String sellerId;
  final String imagePath;
  String sellerName;

  Freelance({
    required this.job,
    required this.description,
    required this.price,
    required this.sellerId,
    required this.imagePath,
    required this.sellerName,
  });
}

class _FreelancePageState extends State<FreelancePage> {
  // ... other methods and variables
  List<Map<String, dynamic>> searched = [];

  final CollectionReference freelanceCollection =
      FirebaseFirestore.instance.collection('freelance');

  final CollectionReference sellersCollection =
      FirebaseFirestore.instance.collection('seller');

  List<Freelance> freelance = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> freelanceSnapshot =
          await freelanceCollection.get()
              as QuerySnapshot<Map<String, dynamic>>;

      List<Freelance> freelanceList = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> freelanceDoc
          in freelanceSnapshot.docs) {
        Map<String, dynamic> freelanceData = freelanceDoc.data();
        String sellerId = freelanceData['sellerID'];

        // Fetch additional seller information
        DocumentSnapshot<Map<String, dynamic>> sellerDoc =
            await sellersCollection.doc(sellerId).get()
                as DocumentSnapshot<Map<String, dynamic>>;
        Map<String, dynamic> sellerData = sellerDoc.data() ?? {};

        // Load image URL from Firebase Storage
        String imageUrl = await getImageUrl(freelanceData['image']);

        Freelance freelance = Freelance(
          job: freelanceData['job'],
          description: freelanceData['description'],
          price: freelanceData['price'].toDouble(),
          sellerId: sellerId,
          imagePath: imageUrl,
          sellerName: sellerData['name'] ?? 'Unknown Seller',
        );

        freelanceList.add(freelance);
      }

      setState(() {
        freelance = freelanceList;
      });
    } catch (e) {
      // print('ERROR: $e');
    }
  }

  Future<String> getImageUrl(String imagePath) async {
    Reference ref = FirebaseStorage.instance.ref().child(imagePath);
    return await ref.getDownloadURL();
  }

  // void _runFilter(String enteredKeyword) {
  //   List<Map<String, dynamic>> results = [];
  //   if (enteredKeyword.isEmpty) {
  //     //results = allsearched;
  //   } else {
  //     // results = allsearched.where((user) => user["name"]
  //     //     .toLowerCase()
  //     //     .contains(enteredKeyword.toLowerCase())).toList();
  //   }
  // }

  // setState((){
  //   allsearched = results;
  // });

  @override
  Widget build(BuildContext context) {
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
          actions: [
            IconButton(
              padding: EdgeInsets.symmetric(horizontal: 20),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatsPage(),
                  ),
                );
              },
              icon: Image.asset(
                'assets/icons/chat.png',
                width: MediaQuery.of(context).size.width / 11,
              ),
            ),
          ],
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
                      builder: (context) => const LandingPage(),
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
                        color: Color(0xFF9F948B),
                      ),
                      Text(
                        "Marketplace",
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
                        color: Color(0xFF607274),
                      ),
                      Text(
                        "Freelance",
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
        drawer: const NavigationDrawer(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    // onChanged: (value) => _runFilter(value),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      hintText: 'Search',
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            color: Colors.grey), // Set the border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            color: Colors.grey), // Set the focused border color
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            color: Colors.grey), // Set the enabled border color
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "For You",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: freelance.map((data) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductDetail(
                                    productId: '4gUCNhdHELl1lWcA8usm'),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                    child: Image(
                                      image: NetworkImage(data.imagePath),
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.job,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18.0,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                data.sellerName,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "\$${data.price}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Image.asset(
                    'assets/images/discover_product.png',
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Inclusive Tech",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: freelance.map((data) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductDetail(
                                    productId: '4gUCNhdHELl1lWcA8usm'),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                    child: Image(
                                      image: NetworkImage(data.imagePath),
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.job,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18.0,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                data.sellerName,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "\$${data.price}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
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
        ),
      );
}
