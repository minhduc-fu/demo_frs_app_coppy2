import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_frs_app/core/constants/color_constants.dart';
import 'package:demo_frs_app/core/helper/asset_helper.dart';
import 'package:demo_frs_app/core/helper/image_helper.dart';
import 'package:demo_frs_app/models/product.dart';
import 'package:demo_frs_app/representation/widgets/app_bar_main.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController _controller = CarouselController();
  int _currentIndexBanner = 0;
  int _currentIndexBrand = 0;

  final List<Widget> _bannerImages = [
    ImageHelper.loadFromAsset(AssetHelper.imageBanner1),
    ImageHelper.loadFromAsset(AssetHelper.imageBanner2),
    ImageHelper.loadFromAsset(AssetHelper.imageBanner3),
  ];

  //
  List<String> brandList = [
    "Dior",
    "Chanel",
    "Gucci",
    "Louis Vuitton",
  ];

  List<Product> allProducts = [
    Product(
        name: 'Túi Dior',
        price: '100.000',
        imagePath: AssetHelper.imageDior,
        rating: '4.9',
        brand: 'Dior'),
    Product(
        name: 'Túi Chanel',
        price: '200.000',
        imagePath: AssetHelper.imageChanel,
        rating: '4.2',
        brand: 'Chanel'),
    Product(
        name: 'Túi Gucci',
        price: '300.000',
        imagePath: AssetHelper.imageGucci,
        rating: '4.4',
        brand: 'Gucci'),
    Product(
        name: 'Túi Louis Vuitton',
        price: '400.000',
        imagePath: AssetHelper.imageLV,
        rating: '4.1',
        brand: 'Louis Vuitton'),
  ];

  String selectedBrand = ""; // Không có thương hiệu nào được chọn ban đầu
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // get screen size
    return AppBarMain(
      isBack: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CarouselSlider.builder(
                    carouselController: _controller,
                    itemCount: _bannerImages.length,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return _bannerImages[index];
                    },
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true, // phóng to trung tâm trang
                      // height: 200,
                      aspectRatio: 16 / 9,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndexBanner = index;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 8,
                    // margin: EdgeInsets.symmetric(vertical: 13, horizontal: 30), //
                    child: ListView.builder(
                      // nằm giữa hay không là nó nằm ở shrinWrap này nè
                      shrinkWrap:
                          true, // Cho phép ListView.builder co lại theo nội dung
                      itemCount: _bannerImages.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return buildIndicator(
                            index == _currentIndexBanner, size);
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        height: 40,
                        child: ListView.builder(
                          itemCount: brandList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            String brand = brandList[index];
                            bool isSelected = index == _currentIndexBrand;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _currentIndexBrand == index;

                                  if (brand == "All Items") {
                                    filteredProducts = allProducts;
                                  } else {
                                    filteredProducts = allProducts
                                        .where(
                                            (product) => product.brand == brand)
                                        .toList();
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? ColorPalette.primaryColor
                                      : ColorPalette.hideColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  brand,
                                  style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(filteredProducts[index].name),
                          );
                        },
                      )
                    ],
                  ),
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: brandList.length,
                  //   scrollDirection: Axis.horizontal,
                  //   itemBuilder: (context, index) {
                  //     return ListTile(
                  //       title: Text(brandList[index]),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildIndicator(bool isActive, Size size) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    curve: Curves.bounceInOut,
    margin: EdgeInsets.symmetric(horizontal: 10), // cách từng cục item
    width: isActive ? 20 : 10,
    decoration: BoxDecoration(
      color: isActive ? Colors.black : Colors.grey,
      borderRadius: BorderRadius.circular(5),
      // boxShadow: [
      //   BoxShadow(color: Colors.black38, offset: Offset(3, 6), blurRadius: 3),
      // ],
    ),
  );
}