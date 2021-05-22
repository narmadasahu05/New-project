import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      getCategories();
      getProducts();
    });
  }

  List categoriesList;
  List productsList;

  Future getCategories() async {
    String categoriesURl = 'https://fakestoreapi.com/products/categories';
    await http.get(categoriesURl).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          categoriesList = json.decode(response.body);
          print(categoriesList);
        });
      } else {
        throw Exception('Failed to load post');
      }
    });
  }

  Future getProducts() async {
    String productsURl = 'https://fakestoreapi.com/products';
    await http.get(productsURl).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          productsList = json.decode(response.body);
          print(productsList);
        });
      } else {
        throw Exception('Failed to load post');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 10.0, right: 10, top: 50, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'All categories',
            ),
            SizedBox(
              height: 20,
            ),
            categoriesList != null
                ? Container(
                    height: 40,
                    child: ListView.builder(
                      itemCount: categoriesList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  categoriesList[index].toString(),
                                ),
                              ))),
                        );
                      },
                    ),
                  )
                : SizedBox(),
             productsList!=null?
            Expanded(
               child: ListView.builder(
                itemCount: productsList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index){
                   return Padding(
                     padding: const EdgeInsets.only(left:5.0,right:5.0,top: 20),
                     child: Container(                     
                       decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey),
                              ),
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Center(
                               child: Image.network(productsList[index]['image'],
                               width: 100,
                               height: 100,
                               ),
                             ),
                             SizedBox(height: 5,),
                             Text(productsList[index]['title'],style: TextStyle(fontWeight: FontWeight.w600), ),
                             SizedBox(height: 5,),
                              Text(productsList[index]['description'], overflow: TextOverflow.clip,
                              ),
                                SizedBox(height: 5,),
                              Row(
                                children: [
                                  Text('Price', style: TextStyle(fontSize: 15),),
                                  SizedBox(width: 5,),
                                  Text(productsList[index]['price'].toString(), ),
                                ],
                              ),
                           ],
                         ),
                       )
                       ),
                   );
                },

              ),
            )
            :SizedBox(),
          ],
        ),
      ),
    );
  }
}
