import 'package:flutter/material.dart';

class ManageProductPage extends StatefulWidget {
  const ManageProductPage({Key? key}) : super(key: key);

  @override
  State<ManageProductPage> createState() => _ManageProductPageState();
}

class _ManageProductPageState extends State<ManageProductPage> {
  final List<Map> items = [
    {"nama": "Cookies", "sales": 7000},
    {"nama": "Donat", "sales": 400},
    {"nama": "Keju", "sales": 7600},
    {"nama": "Nasi", "sales": 5},
    {"nama": "Cookies", "sales": 7000},
    {"nama": "Donat", "sales": 400},
    {"nama": "Keju", "sales": 7600},
  ];

  @override
  Widget build(BuildContext context) {
    List<int> totalPriceList = [];

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
              icon: Image.asset(
                'assets/icons/clipboard.png',
                width: MediaQuery.of(context).size.width / 11,
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Manage Your Products",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Image.asset(
                            'assets/icons/add_product.png',
                            width: MediaQuery.of(context).size.width / 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              mainAxisExtent: 180),
                      itemCount: items.length,
                      itemBuilder: (_, index) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  child: Image.asset(
                                    'assets/images/cookie.png',
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Container(
                                  margin: const EdgeInsets.only(top: 5.0),
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${items.elementAt(index)['nama']}",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      Text(
                                        "${items.elementAt(index)['sales']} sales",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.0,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
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
      ),
    );
  }
}
