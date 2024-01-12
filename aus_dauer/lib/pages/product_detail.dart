import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final String productId;

  const ProductDetail({super.key, required this.productId});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  final CollectionReference sellersCollection =
      FirebaseFirestore.instance.collection('seller');

  String imgUrl = '';
  String productName = '';
  double numOfReviews = 0.0;
  double price = 0.0;
  double rating = 0.0;
  double stock = 0.0;
  String description = '';
  String sellerId = '';
  String sellerName = '';
  String sellerLocation = '';
  double year = 0.0;
  String sellerDetail = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String productId = widget.productId;

    try {
      DocumentSnapshot<Map<String, dynamic>> productSnapshot =
          await productsCollection.doc(productId).get()
              as DocumentSnapshot<Map<String, dynamic>>;

      Map<String, dynamic>? productData = productSnapshot.data();

      if (productData != null) {
        setState(() {
          imgUrl = productData['image'] ?? '';
          productName = productData['name'] ?? '';
          numOfReviews = productData['reviews'] ?? 0;
          price = (productData['price'] ?? 0.0).toDouble();
          rating = (productData['rating'] ?? 0.0).toDouble();
          stock = productData['stock'] ?? 0;
          description = productData['description'] ?? '';
          sellerId = productData['sellerID'] ?? '';
        });

        DocumentSnapshot<Map<String, dynamic>> sellerDoc =
            await sellersCollection.doc(sellerId).get()
                as DocumentSnapshot<Map<String, dynamic>>;

        Map<String, dynamic>? sellerData = sellerDoc.data();

        if (sellerData != null) {
          setState(() {
            sellerName = sellerData['name'] ?? '';
            sellerLocation = sellerData['location'] ?? '';
            year = (sellerData['since'] ?? 0.0).toDouble();
            sellerDetail = sellerData['description'] ?? '';
          });
        }
      }
    } catch (e) {
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Text(
                        description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About the Seller',
                        style: TextStyle(
                          fontSize: screenHeight * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFFDBFFDA),
                            border: Border.all(
                              color: const Color.fromARGB(252, 31, 160, 3),
                              width: 1,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                          'assets/images/placeholder.png'),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sellerName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          sellerLocation,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'Member since $year',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                                Text(
                                  sellerDetail,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      '$rating stars',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    StarRating(
                                      rating: rating,
                                      size: 20,
                                    ),
                                    Text(
                                      '$numOfReviews reviews',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const ReviewBars(),
                        ],
                      ),
                      const ReviewCards(),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        color: const Color.fromARGB(255, 231, 231, 231),
                        child: ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: null,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 231, 231, 231),
                                  ),
                                ),
                                child: const Text(
                                  'See All Reviews',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
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
              child: const ElevatedButton(
                onPressed: null,
                child: Text(
                  'Add to Cart',
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

class ReviewBars extends StatelessWidget {
  const ReviewBars({super.key});

  @override
  Widget build(BuildContext context) {
    // get the total number of reviews
    const fives = 10;
    const fours = 0;
    const threes = 0;
    const twos = 0;
    const ones = 0;
    const total = fives + fours + threes + twos + ones;

    return const SizedBox(
      width: 150,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '5',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: fives / total,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '4',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: fours / total,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '3',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: threes / total,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '2',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: twos / total,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: ones / total,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReviewCards extends StatelessWidget {
  final int limit;
  final int offset;

  const ReviewCards({super.key, this.limit = 5, this.offset = 0});

  @override
  Widget build(BuildContext context) {
    // get reviews from API
    List reviews = [
      {
        'image': 'assets/images/placeholder.png',
        'name': 'Rita Arnold',
        'rating': 5.0,
        'numOfUserReviews': 234,
        'review':
            'Amazing. The seller was very friendly. The cookies were amazing. etc etc etc',
      },
      {
        'image': 'assets/images/placeholder.png',
        'name': 'Rita Arnold',
        'rating': 5.0,
        'numOfUserReviews': 234,
        'review':
            'Amazing. The seller was very friendly. The cookies were amazing. etc etc etc',
      },
      {
        'image': 'assets/images/placeholder.png',
        'name': 'Rita Arnold',
        'rating': 5.0,
        'numOfUserReviews': 234,
        'review':
            'Amazing. The seller was very friendly. The cookies were amazing. etc etc etc',
      },
      {
        'image': 'assets/images/placeholder.png',
        'name': 'Rita Arnold',
        'rating': 5.0,
        'numOfUserReviews': 234,
        'review':
            'Amazing. The seller was very friendly. The cookies were amazing. etc etc etc',
      },
    ];

    List<Widget> reviewCards = [];

    for (var element in reviews) {
      reviewCards.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(element['image'] as String),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            element['name'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${element['numOfUserReviews']} reviews',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  StarRating(
                    rating: element['rating'] as double,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                element['review'] as String,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ));
    }

    return Column(
      children: reviewCards,
    );
  }
}
