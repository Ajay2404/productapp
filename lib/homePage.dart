import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:productapp/productView.dart';

class HomePage extends StatefulWidget {
  static Map map = {};

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myProduct();
  }


  myProduct() async {
    var url = Uri.parse('https://dummyjson.com/products');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    HomePage.map = jsonDecode(response.body);
    setState(() {
      MyData myclasss = MyData(HomePage.map);
      print(myclasss);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
        IconButton(onPressed: () {}, icon: Icon(Icons.share)),
      ]),
      body: ListView.builder(
          itemCount: HomePage.map['products'].length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Map<String, dynamic> product = HomePage.map['products'][index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ProductView(product);
                  },
                ));
              },
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
                child: Row(children: [
                  Card(
                      shape: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Image.network(
                            width: 80,
                            height: 110,
                            fit: BoxFit.fill,
                            "${HomePage.map['products']![index]['thumbnail']}"),
                      )).paddingSymmetric(horizontal: 10),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            "${HomePage.map['products'][index]['title']}",
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              "Brand: ${HomePage.map['products'][index]['brand']}"),
                          Container(
                            width: 54,
                            padding: const EdgeInsets.all(4),
                            decoration:
                                BoxDecoration(color: Colors.green.shade700),
                            child: Row(
                              children: [
                                Text(
                                  style: const TextStyle(color: Colors.white),
                                  "${HomePage.map['products'][index]['rating']}",
                                ),
                                const Icon(
                                  Icons.star,
                                  size: 15,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            "₹${HomePage.map['products'][index]['price']}/-",
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              style: const TextStyle(fontSize: 10),
                              '${HomePage.map['products'][index]['discountPercentage']}% Off'),
                        ],
                      ).paddingOnly(top: 15),
                    ),
                  ),
                ]),
              ).paddingAll(10),
            );
          }),
    );
  }
}

class MyData {
  List<Products>? products;
  int? total;
  int? skip;
  int? limit;

  MyData(Map<dynamic, dynamic> map,
      {this.products, this.total, this.skip, this.limit});

  MyData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['skip'] = skip;
    data['limit'] = limit;
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  Products(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      this.thumbnail,
      this.images});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['discountPercentage'] = discountPercentage;
    data['rating'] = rating;
    data['stock'] = stock;
    data['brand'] = brand;
    data['category'] = category;
    data['thumbnail'] = thumbnail;
    data['images'] = images;
    return data;
  }
}
