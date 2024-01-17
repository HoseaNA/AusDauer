import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './manage_product.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({Key? key}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  int? _price;
  int? _stock;
  String? _description;
  String? _picture;
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pictureController = TextEditingController();

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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0), // Adjust the height as needed
            child: Container(
              height: 1.0,
              color: Colors.black,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.0),
                  Text(
                    "Edit Item Information",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "Item Name",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Item name",
                      labelText: "Item Name",
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
                        _name = value!;
                      });
                    },
                    // Added behavior when data is saved
                    onSaved: (String? value) {
                      setState(() {
                        _name = value!;
                      });
                    },
                    // Validator as form validation
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon isi nama!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price (in dollars)",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            TextFormField(
                              controller: _priceController,
                              decoration: InputDecoration(
                                hintText: "Ex: 3.45",
                                labelText: "Price",
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
                                  _price = int.parse(value!);
                                });
                              },
                              // Added behavior when data is saved
                              onSaved: (String? value) {
                                setState(() {
                                  _price = int.parse(value!);
                                });
                              },
                              // Validator as form validation
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mohon isi harga!';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Stock",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            TextFormField(
                              controller: _stockController,
                              decoration: InputDecoration(
                                hintText: "Ex: 300",
                                labelText: "Stock",
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
                                  _stock = int.parse(value!);
                                });
                              },
                              // Added behavior when data is saved
                              onSaved: (String? value) {
                                setState(() {
                                  _stock = int.parse(value!);
                                });
                              },
                              // Validator as form validation
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Mohon isi stock!';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 7,
                    decoration: InputDecoration(
                      hintText: "Long Description",
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
                        _description = value!;
                      });
                    },
                    // Added behavior when data is saved
                    onSaved: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    // Validator as form validation
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon isi deskripsi!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "Picture",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: Text(
                        'Image',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60)
                ],
              ),
            ),
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
                    if (_formKey.currentState!.validate()) {
                      CollectionReference products =
                          FirebaseFirestore.instance.collection('products');

                      try {
                        await products.add({
                          'name': _name,
                          'price': _price,
                          'stock': _stock,
                          'description': _description,
                          'image': _picture,
                          'seller': '56NXH5Jrej7i4p0CjxyY',
                          'sold': 0,
                          'reviews': 0,
                          'rating': 0.0,
                        });

                        _nameController.clear();
                        _priceController.clear();
                        _stockController.clear();
                        _descriptionController.clear();
                        _pictureController.clear();
                        final successBar = SnackBar(
                          content: const Text("Product berhasil disimpan!"),
                          action: SnackBarAction(
                            label: 'Hide',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(successBar);
                        Navigator.pop(context);
                      } catch (e) {
                        print('Error adding product to Firestore: $e');
                      }
                    }
                  },
                  child: Text(
                    'Save',
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
