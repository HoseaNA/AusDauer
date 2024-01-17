import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class YourProductDetail extends StatefulWidget {
  final String productId;

  const YourProductDetail({Key? key, required this.productId})
      : super(key: key);

  @override
  State<YourProductDetail> createState() => _YourProductDetailState();
}

class _YourProductDetailState extends State<YourProductDetail> {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  String imgUrl = '';
  String productName = '';
  double numOfReviews = 0.0;
  double price = 0.0;
  double rating = 0.0;
  double stock = 0.0;
  double sold = 0.0;
  double revenue = 0.0;
  double soldLastSevenDays = 0.0;
  double revenueLastSevenDays = 0.0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<String> getImageUrl(String imagePath) async {
    Reference ref = FirebaseStorage.instance.ref().child(imagePath);
    return await ref.getDownloadURL();
  }

  bool isLoading = true;

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    String productId = widget.productId;

    try {
      DocumentSnapshot<Map<String, dynamic>> productSnapshot =
          await productsCollection.doc(productId).get()
              as DocumentSnapshot<Map<String, dynamic>>;

      Map<String, dynamic>? productData = productSnapshot.data();

      if (productData != null) {
        String img = await getImageUrl(productData['image']);

        setState(() {
          imgUrl = img;
          productName = productData['name'];
          numOfReviews = productData['reviews'].toDouble();
          price = productData['price'].toDouble();
          rating = productData['rating'].toDouble();
          sold = productData['sold'].toDouble();
          stock = productData['stock'].toDouble();
        });
      }
    } catch (e) {
      // print('ERROR! : $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 5,
              expandedHeight: 260,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/cookies.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(screenWidth * 0.07),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '$numOfReviews reviews',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '\$$price',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              '/pc',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.003,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            StarRating(
                              rating: rating,
                            ),
                            Text(
                              '(${rating.toInt()})',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Stock: $stock',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    const Text(
                      'Sales Review',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Sales',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('$sold'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Revenue',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${sold * price}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Sales (Last 7 days)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('$sold'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Sales (Last 7 days)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${sold * price}'),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          //TODO delete the item
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          side: MaterialStateProperty.all(
                            const BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Delete this item',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomSheet: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.07,
          color: const Color(0xFF072389),
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    //TODO direct to edit page
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xFF072389),
                    ),
                  ),
                  child: const Text(
                    'Edit item',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final int? ratingcount;

  const StarRating(
      {super.key, required this.rating, this.ratingcount, this.size = 18});

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];

    int realNumber = rating.floor();
    for (int i = 0; i < 5; i++) {
      if (i < realNumber) {
        stars.add(Icon(
          Icons.star_outlined,
          color: Colors.amber,
          size: size,
        ));
      } else if (i == realNumber) {
        stars.add(Icon(
          Icons.star_half_outlined,
          color: Colors.amber,
          size: size,
        ));
      } else {
        stars.add(Icon(
          Icons.star,
          color: Colors.grey,
          size: size,
        ));
      }
    }

    return Row(
      children: stars,
    );
  }
}
