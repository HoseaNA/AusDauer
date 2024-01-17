import 'package:aus_dauer/pages/cart.dart';
import 'package:aus_dauer/pages/freelance.dart';
import 'package:aus_dauer/pages/history.dart';
import 'package:aus_dauer/pages/product_detail.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './manage_product.dart';
import './landing_page.dart';
import './orders_page.dart';
import './chats.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({Key? key}) : super(key: key);

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class Product {
  final String productId;
  final String name;
  final String description;
  final int numberOfReviews;
  final double price;
  final double rating;
  final String sellerId;
  final int numberOfItemsSold;
  final int stock;
  final String imagePath;
  final String sellerName;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.numberOfReviews,
    required this.price,
    required this.rating,
    required this.sellerId,
    required this.numberOfItemsSold,
    required this.stock,
    required this.imagePath,
    required this.sellerName,
  });
}

class _MarketplacePageState extends State<MarketplacePage> {
  List<Map<String, dynamic>> searched = [];

  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  final CollectionReference sellersCollection =
      FirebaseFirestore.instance.collection('seller');

  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> productsSnapshot =
          await productsCollection.get() as QuerySnapshot<Map<String, dynamic>>;

      List<Product> productList = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> productDoc
          in productsSnapshot.docs) {
        Map<String, dynamic> productData = productDoc.data();
        String sellerId = productData['sellerID'];

        // Fetch additional seller information
        DocumentSnapshot<Map<String, dynamic>> sellerDoc =
            await sellersCollection.doc(sellerId).get()
                as DocumentSnapshot<Map<String, dynamic>>;
        Map<String, dynamic> sellerData = sellerDoc.data() ?? {};

        // Load image URL from Firebase Storage
        String imageUrl = await getImageUrl(productData['image']);

        Product product = Product(
          productId: productDoc.id,
          name: productData['name'],
          description: productData['description'],
          numberOfReviews: productData['reviews'],
          price: productData['price'].toDouble(),
          rating: productData['rating'].toDouble(),
          sellerId: sellerId,
          numberOfItemsSold: productData['sold'],
          stock: productData['stock'],
          imagePath: imageUrl,
          sellerName: sellerData['name'] ?? 'Unknown Seller',
        );

        productList.add(product);
      }

      setState(() {
        products = productList;
      });
    } catch (e) {
      // Handle error
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
          title: const Text(""),
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
                    builder: (context) => const CartPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.shopping_basket_outlined,
                size: 30,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0), // Adjust the height as needed
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
              const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          child: NavigationBar(
            height: 60,
            selectedIndex: 0,
            destinations: [
              InkWell(
                child: const Center(
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
                child: const Center(
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
                child: const Center(
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
                child: const Center(
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
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    // onChanged: (value) => _runFilter(value),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
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
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Text(
                    "For You",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      Product data = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                productId: products[index].productId,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.0,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  width: MediaQuery.of(context).size.height / 4,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(data.imagePath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.name,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        Text(
                                          data.sellerName,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "\$${data.price}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Image.asset(
                    'assets/images/discover_product.png',
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                const SizedBox(height: 15.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: const Text(
                    "Handicrafts",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      Product data = products[index];
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
                          width: MediaQuery.of(context).size.width /
                              2.0, // Updated width
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  width: MediaQuery.of(context).size.height / 4,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(data.imagePath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.name,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        Text(
                                          data.sellerName,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "\$${data.price}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
        ),
      );
}
