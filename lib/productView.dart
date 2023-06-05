import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:productapp/homePage.dart';

class ProductView extends StatefulWidget {
  final dynamic product;

  const ProductView(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewStatus();
  }

  bool status = true;

  viewStatus() {
    if (widget.product['images'].length == 1) {
      setState(() {
        status = false;
      });
    } else {
      status = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: const [
          Icon(
            Icons.search_rounded,
            color: Colors.black,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.mic,
            color: Colors.black,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
          SizedBox(
            width: 10,
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const HomePage();
              },
            ));
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(children: [
        status
            ? CarouselSlider(
                items: List.generate(
                  widget.product['images'].length,
                  (index) => Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "${widget.product['images'][index]}"))
                      .marginSymmetric(horizontal: 10),
                ),
                options: CarouselOptions(
                  height: 500,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                ),
              )
            : Image(
                fit: BoxFit.fill,
                image: NetworkImage("${widget.product['images'][0]}"))
      ]),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 80,
            width: 190,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Text("Add To Cart",
                style: TextStyle(color: Colors.black)),
          ),
          Container(
            alignment: Alignment.center,
            height: 80,
            width: 190,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: const Text("Buy Now", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
