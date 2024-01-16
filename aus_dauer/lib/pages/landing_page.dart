import 'package:aus_dauer/pages/freelance.dart';
import 'package:aus_dauer/pages/product_detail.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import './add_product.dart';
import './manage_product.dart';
import './marketplace.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingState();
}

class Product {
  final String name;
  final String description;
  final int numberOfReviews;
  final double price;
  final double rating;
  final String sellerId;
  final int numberOfItemsSold;
  final int stock;
  final String imagePath;
  String sellerName;

  Product({
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

class _LandingState extends State<LandingPage> {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(""),
          leadingWidth: 200,
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "ausdauer",
              style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.w400,
                fontSize: 36.0,
              ),
            ),
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.symmetric(horizontal: 20),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                'assets/icons/notification.png',
                width: MediaQuery.of(context).size.width / 11,
              ),
            ),
          ],
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
                        color: Color(0xFF607274),
                      ),
                      Text(
                        "Home",
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Trending",
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
                      children: products.map((data) {
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
                                  Image(
                                    image: NetworkImage(data.imagePath),
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
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
                                            )
                                          ],
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
                    'assets/images/discover_blue.png',
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Featured Story",
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
                  child: Row(
                    children: products.map((data) {
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
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "My life as a Disabled Pastry Baker",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Anna Marshall is a resilient and determined woman who moved to Indonesia from India...",
                                          maxLines: 3,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Read Full Story",
                                          style: TextStyle(
                                            color: Color(0xFF072389),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3.1,
                                    height: MediaQuery.of(context).size.height /
                                        5.5,
                                    child: Image(
                                      image: NetworkImage(data.imagePath),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              )
                              // child: Column(
                              //   children: [
                              //     Image(
                              //       image: NetworkImage(data.imagePath),
                              //       width:
                              //           MediaQuery.of(context).size.width / 2.5,
                              //     ),
                              //     const SizedBox(height: 10.0),
                              //     Container(
                              //       margin: const EdgeInsets.symmetric(
                              //           vertical: 10.0),
                              //       width:
                              //           MediaQuery.of(context).size.width / 2.5,
                              //       child: Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               Text(
                              //                 data.name,
                              //                 textAlign: TextAlign.start,
                              //                 style: const TextStyle(
                              //                   color: Colors.black,
                              //                   fontWeight: FontWeight.w700,
                              //                   fontSize: 18.0,
                              //                 ),
                              //               ),
                              //               Text(
                              //                 data.sellerName,
                              //                 textAlign: TextAlign.start,
                              //                 style: const TextStyle(
                              //                   color: Colors.black,
                              //                   fontWeight: FontWeight.w400,
                              //                   fontSize: 14.0,
                              //                 ),
                              //               )
                              //             ],
                              //           ),
                              //           Text(
                              //             "\$${data.price}",
                              //             style: const TextStyle(
                              //               color: Colors.black,
                              //               fontWeight: FontWeight.w700,
                              //               fontSize: 18.0,
                              //             ),
                              //           )
                              //         ],
                              //       ),
                              //     )
                              //   ],
                              // ),
                              ),
                        ),
                      );
                    }).toList(),
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
