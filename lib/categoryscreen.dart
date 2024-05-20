import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:skyscrapper/skyapi.dart';
import 'package:skyscrapper/wallpaperscreen.dart';
import 'categorymodal.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool isLoading = false;

  String reason = '';
  final CarouselController _controller = CarouselController();

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      reason = changeReason.toString();
    });
  }

  /*@override
  void initState() {
    // TODO: implement initState
    setState(() {
      isLoading = true;
    });
    Skyapi().loadPostData().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 330;
    return Scaffold(
        backgroundColor: Color.fromRGBO(20, 33, 61, 1),

        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(20, 33, 61, 1),
          title: Text(
            "Sky Scrapp",
            style: TextStyle(
                color: Colors.yellowAccent, fontWeight: FontWeight.w600),
          ),
        ),
        body: Center(
            child: isLoading == true
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CarouselSlider.builder(
                          itemCount: categoryList.length,
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                          ),
                          itemBuilder: (context, index, realIdx) {
                            return Container(
                              child: Center(
                                  child: Image.network(categoryList[index].bg!,
                                      fit: BoxFit.cover, width: 1000)),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: screenHeight,
                        child: GridView.builder(
                          itemCount: categoryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WallpaperScreen(imgName: categoryList[index].tital!,)));
                                },
                                child: Container(
                                  height: double.infinity,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.withOpacity(0.1),
                                    image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                            Colors.transparent,
                                            BlendMode.multiply),
                                        image: NetworkImage(
                                          categoryList[index].bg!,
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                  child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 0.5, sigmaY: 0.5),
                                      child: Container(
                                          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),,),
                                          alignment: Alignment.center,
                                          child: Text(categoryList[index].tital!,
                                              style: TextStyle(
                                                  fontSize: 28,
                                                  color: Colors.deepOrangeAccent,
                                                  fontWeight: FontWeight.bold)))

                                      // ,
                                      ),
                                ),
                              ),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // mainAxisSpacing: 10,

                            childAspectRatio: 3 / 4,
                            //    crossAxisSpacing: 10
                          ),
                        ),
                      ),
                    ],
                  )));
  }
}
