import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({Key? key}) : super(key: key);

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
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

class _MarketplacePageState extends State<MarketplacePage> {
  // ... other methods and variables
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
          name: productData['name'],
          description: productData['description'],
          numberOfReviews: productData['reviews'],
          price: productData['price'].toDouble(),
          rating: productData['rating'].toDouble(),
          sellerId: sellerId,
          numberOfItemsSold: productData['sold'],
          stock: productData['stock'],
          imagePath: imageUrl, // Use the image URL
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

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      //results = allsearched;
    } else {
      // results = allsearched.where((user) => user["name"]
      //     .toLowerCase()
      //     .contains(enteredKeyword.toLowerCase())).toList();
    }
  }

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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.menu,
              size: 30,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.shopping_basket_outlined,
                size: 30,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize:
                const Size.fromHeight(1.0), // Adjust the height as needed
            child: Container(
              height: 1.0,
              color: Colors.black,
            ),
          ),
        ),
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
                const SizedBox(height: 15),
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: products.map((data) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(10.0)),
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
                        );
                      }).toList(),
                    ),
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: products.map((data) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(10.0)),
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
