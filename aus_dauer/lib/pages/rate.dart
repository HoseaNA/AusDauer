import 'package:aus_dauer/pages/chats.dart';
import 'package:aus_dauer/pages/history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './manage_product.dart';

class RatePage extends StatefulWidget {
  const RatePage({Key? key}) : super(key: key);

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  final _formKey = GlobalKey<FormState>();
  String? _review;
  final _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width / 1,
                    height: MediaQuery.of(context).size.height / 4,
                    child: Image.asset(
                      'assets/images/cookie.png',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      "Please rate your experience regarding this order",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 15),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _reviewController,
                      maxLines: 7,
                      decoration: InputDecoration(
                        hintText: "Write your review",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        // Added a circular border to make it neater
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      // Added behavior when name is typed
                      onChanged: (String? value) {
                        setState(() {
                          _review = value!;
                        });
                      },
                      // Added behavior when data is saved
                      onSaved: (String? value) {
                        setState(() {
                          _review = value!;
                        });
                      },
                      // Validator as form validation
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon isi review!';
                        }
                        return null;
                      },
                    ),
                  )
                ]),
          ),
        ),
        bottomSheet: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.07,
          color: Colors.green,
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            0), // You can adjust the borderRadius as needed
                      ),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HistoryPage(), // Replace RatePage with your actual rate page
                      ),
                    );
                    // if (_formKey.currentState!.validate()) {
                    //   CollectionReference products =
                    //       FirebaseFirestore.instance.collection('products');

                    //   try {
                    //     await products.add({
                    //       'review': _review,
                    //       'reviews': 0,
                    //       'rating': 0.0,
                    //     });

                    //     _reviewController.clear();

                    //     final successBar = SnackBar(
                    //       content: const Text("Product berhasil disimpan!"),
                    //       action: SnackBarAction(
                    //         label: 'Hide',
                    //         onPressed: () {},
                    //       ),
                    //     );
                    //     ScaffoldMessenger.of(context).showSnackBar(successBar);
                    //     Navigator.pop(context);
                    //   } catch (e) {
                    //     print('Error adding product to Firestore: $e');
                    //   }
                    // }
                  },
                  child: Text(
                    'Confirm',
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
      ),
    );
  }
}
